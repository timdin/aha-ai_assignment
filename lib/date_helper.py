import datetime, random, calendar
from robot.api.deco import keyword, not_keyword
from date_enum import month_direction


class date_helper:
    def __init__(self):
        self.date_to_use = None
        # this dict will be used to convert month names to month int (e.g. January to 1)
        self.month_to_int = {month: index for index, month in enumerate(calendar.month_name) if month}
        # this dict will be used to convert weekday of date to the corresponding xpath position
        self.weekday_converter = {
            0:2,
            1:3,
            2:4,
            3:5,
            4:6,
            5:7,
            6:1,
        }

    def _check_date_to_use_exists(func):
            def wrapper(self, *args, **kwargs):
                if self.date_to_use == None:
                    raise ValueError("date to use not set, call get a date/get a leap date first")
                return func(self, *args, **kwargs)
            return wrapper
    
    def get_a_date(self):
        """
        This function picks a random date within the last 15 years and stores it in the current date helper object
        """
        today = datetime.date.today()        
        fifteen_years_ago = today - datetime.timedelta(days=15 * 365 + 4)  # adding leap days roughly
        
        # Generate a random number of days to add to the date 15 years ago
        days_between_dates = (today - fifteen_years_ago).days
        random_days = random.randint(0, days_between_dates)
        
        # Calculate the random date
        random_date = fifteen_years_ago + datetime.timedelta(days=random_days)
        
        self.date_to_use=random_date
        print("*INFO* selected date: %s" % self.date_to_use)

    def get_a_leap_date(self):
        """
        This function picks a random leap date within the last 15 years and stores it in the current date helper object
        """
        # Get the current year
        current_year = datetime.date.today().year
        
        # List to store potential leap years
        leap_years = []
        
        # Iterate over the last 15 years to find leap years
        for year in range(current_year - 15, current_year + 1):
            if is_leap_year(year):
                leap_years.append(year)
        
        # Pick a random year from the leap years list
        if leap_years:
            random_year = random.choice(leap_years)
            # February 29 of the chosen leap year
            self.date_to_use = datetime.date(random_year, 2, 29)
            print("*INFO* selected date: %s" % self.date_to_use)
        else:
            return "*WARN* No leap year in the last 15 years has February 29."

    @_check_date_to_use_exists
    def get_year_of_date(self):
        return self.date_to_use.year
    
    @_check_date_to_use_exists    
    def get_month_of_date(self):
        return self.date_to_use.month
    
    @_check_date_to_use_exists
    def get_day_of_date(self):
        """
        Returns the day of the date to use, along with the weekday to correctly 
        select the day if there are multiple appearances
        e.g. for leap days, there would be a 29th from both Jan and Feb present on the calendar grid
        """
        print("*INFO* weekday: {}", self.date_to_use.weekday())
        return self.date_to_use.day, self.weekday_converter[self.date_to_use.weekday()]
    
    @_check_date_to_use_exists
    def get_direction(self, current:str) -> str:
        """
        Returns the direction of the current date to the desired date
        just indicates the month is aligned
        """
        current_month = current.split(" ")[0]
        current_month_int = self.month_to_int[current_month.capitalize()]
        diff = self.date_to_use.month - current_month_int
        if current_month_int == self.date_to_use.month:
            return month_direction.just.value
        if current_month_int > self.date_to_use.month:
            return month_direction.prev.value
        else:
            return month_direction.next.value
        
    @_check_date_to_use_exists
    def compare_date(self, date_data:str, year_and_month_data:str):
        # debug information
        print("*INFO* previous date: %s" % self.date_to_use)
        print("*INFO* data for date: %s" % date_data)
        print("*INFO* data for year and month: %s" % year_and_month_data)
        result_date = date_data.split("/")[0]
        result_month = year_and_month_data.split(" ")[0]
        result_month_int = self.month_to_int[result_month.capitalize()]
        result_year = year_and_month_data.split(" ")[1]
        date_object = datetime.datetime.strptime(
            f"{result_year}-{result_month_int}-{result_date}", "%Y-%m-%d")
        if self.date_to_use == date_object.date():
            return
        else:
            raise AssertionError("Validation failed: Actual date: {}, expected date: {}"
                                 .format(date_object.date(), self.date_to_use))
        
@not_keyword
def is_leap_year(year):
    # Check if a given year is a leap year
    return (year % 4 == 0) and (year % 100 != 0 or year % 400 == 0)

