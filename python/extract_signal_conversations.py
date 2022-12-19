"""
A script to take messages out of a Signal database and put them into flat files
that are easy to read.
"""
import argparse
import datetime
import itertools
import os
import sqlite3
from collections.abc import Iterable
from typing import NamedTuple


class Arguments(NamedTuple):
    filename: str
    directory: str


class Message(NamedTuple):
    conversation: str
    sender: str
    timestamp: datetime.datetime
    body: str


SQL = r"""
SELECT
    COALESCE(
        groups.title,
        NULLIF(person.system_display_name, ''),
        person.profile_joined_name
    ) AS conversation,
    CASE
        WHEN message.reactions_last_seen != -1
        THEN COALESCE(
            NULLIF(person.system_display_name, ''),
            person.profile_joined_name,
            '(You)'
        )
        ELSE '(You)'
    END AS sender,
    message.date_sent AS timestamp,
    message.body AS body
FROM (
    SELECT
        thread_id,
        date_sent,
        recipient_id,
        body,
        reactions_last_seen
    FROM sms
    UNION ALL
    SELECT
        thread_id,
        date_sent,
        recipient_id,
        body,
        reactions_last_seen
    FROM mms
) message
LEFT JOIN thread
ON thread._id = thread_id
LEFT JOIN recipient AS person
ON person._id = message.recipient_id
LEFT JOIN recipient AS thread_recipient
ON thread_recipient._id = message.recipient_id
LEFT JOIN groups
ON groups.group_id = thread_recipient.group_id
where message.body IS NOT NULL
AND message.body != ''
ORDER BY conversation, message.date_sent;
"""


def parse_arguments() -> Arguments:
    parser = argparse.ArgumentParser()
    parser.add_argument("filename")
    parser.add_argument("directory")

    raw_args = parser.parse_args()

    return Arguments(
        filename=raw_args.filename,
        directory=raw_args.directory,
    )


def get_messages(con: sqlite3.Connection) -> Iterable[Message]:
    cursor = con.cursor()
    cursor.execute(SQL)

    while True:
        row = cursor.fetchone()

        if row is None:
            break

        yield Message(
            conversation=row[0],
            sender=row[1],
            timestamp=datetime.datetime.fromtimestamp(row[2] // 1000),
            body=row[3],
        )

    cursor.close()


def main() -> None:
    args = parse_arguments()
    con = sqlite3.connect(args.filename)

    # Write out
    for conversation, messages in itertools.groupby(
        get_messages(con),
        key=lambda m: m.conversation,
    ):
        filename = os.path.join(
            args.directory,
            f"{conversation.replace('/', ' ')}.txt",
        )

        with open(filename, "w") as conversation_file:
            for message in messages:
                print(
                    "[",
                    # Human readable and right-justified.
                    # The size of text is only valid for English.
                    message.timestamp.strftime("%A, %-d %B %Y").rjust(28),
                    "] ",
                    message.sender,
                    ": ",
                    message.body,
                    sep="",
                    file=conversation_file,
                )

    con.close()


if __name__ == "__main__":  # pragma: no cover
    main()  # pragma: no cover
