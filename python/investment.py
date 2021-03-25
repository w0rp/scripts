from decimal import Decimal


def reverse_percentage_drop(p: str) -> str:
    """
    Given a percentage from 0 to 100, return the percentage required to
    reverse a decrease back to previous levels.
    """
    p_d = Decimal(p)

    if p_d == 0:
        return "0"

    result = (1 / (1 - p_d / 100) - 1) * 100

    return "%0.2f" % result
