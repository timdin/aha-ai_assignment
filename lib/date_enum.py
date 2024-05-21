"""
This module defines the enum values for the date related data
"""
from enum import Enum

class MonthDirection(Enum):
    """
    This enum value binds to the title of the month selector arrows
    JUST was a custom one for the script to know no need to move anymore
    """
    PREV = "Previous month"
    NEXT = "Next month"
    JUST = "just"
