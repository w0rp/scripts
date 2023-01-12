#!/home/w0rp/script/python/ve/bin/python
"""
A script to read just one character at a time from a Keepass file to get
characters for logging in to RBS. This is at least better than copy and pasting
the password into a file to work out each character, or using a weak password.
"""

import gc
import getpass
import os
from typing import Any

from pykeepass import PyKeePass  # type: ignore


def main() -> None:
    while True:
        try:
            db: Any = PyKeePass(
                os.path.expanduser('~/Passwords.kdbx'),
                password=getpass.getpass().strip()
            )
        except ValueError:
            pass
        else:
            break

    # Force garbage collection to try and get rid of the password.
    # This might not actually get it out of memory.
    gc.collect()

    rbs_account = db.find_entries(title='RBS Bank Account', first=True)
    rbs_pass = rbs_account.password

    while True:
        try:
            char = input('Which character? ').strip()

            if char.isdigit():
                index = int(char) - 1

                if index >= 0 and index < len(rbs_pass):
                    print(rbs_pass[index])

        except KeyboardInterrupt:
            print()
            break


if __name__ == "__main__":
    main()
