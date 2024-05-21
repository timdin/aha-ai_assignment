"""
This is a custom lib for profile page testing related to data generation, comparing and storing
"""
import random
import string
from typing import Any

class profile_helper: # pylint: disable=C0103
    # the class name has to be exactly match to the name
    # of the file for robotframework to properly import it
    """
    This class provides a simple toolbox for profile page testing which does not involve dates
    - generate and storing data
    - compare data from input and storage
    """
    def __init__(self):
        self.storage = {}

    def get_value(self, key:str) -> Any:
        """
        This method retrieve data from the storage with the given key
        """
        if key in self.storage:
            return self.storage[key]
        raise KeyError(f"Could not find value for key {key}")
    def compare_value(self, key:str, actual:Any) -> None:
        """
        This method compares the data from input and storage with the given key
        """
        expected = self.get_value(key)
        if expected != actual:
            raise AssertionError(f"""Value at key `{key}` is not equal\n
                                 expected: {type(expected)}: {expected}\n
                                 actual: {type(actual)}: {actual}""")
    def set_value(self, key:str, value:Any) -> None:
        """
        This method set the data with given key in the object stoage
        """
        self.storage[key] = value
    def random_a_string(self) -> str:
        """
        This method randomly generate a string
        """
        return ''.join(
            random.choices(string.ascii_lowercase + string.digits, k = random.randrange(8, 20))
            )
    def random_a_number(self, range_low: int, range_high: int) -> int:
        """
        This method randomly choose a number within the given range
        """
        return random.randrange(range_low, range_high)
