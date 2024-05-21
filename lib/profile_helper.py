"""
This is a custom lib for profile page testing related to data generation, comparing and storing
"""
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
        raise KeyError("Could not find value for key {key}")
    def compare(self, key:str, actual:Any) -> None:
        """
        This method compares the data from input and storage with the given key
        """
        expected = self.get_value(key)
        if expected != actual:
            raise AssertionError("""Value at key `{key}` is not equal\n
                                 expected: {expected}\n
                                 actual: {actual}""")
    def set_value(self, key:str, value:Any) -> None:
        """
        This method set the data with given key in the object stoage
        """
        self.storage[key] = value
