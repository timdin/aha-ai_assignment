"""
This module implements the basic email reading functionality
"""
import os.path
from pathlib import Path
import base64
import time
import random
import string
from bs4 import BeautifulSoup

from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError

class EmailError(Exception):
    "Raised when fetching the validation email failed"

def retry(max_attempts=5, max_sleep=30):
    """
    this is the decorator function to retry for the method used in the email client
    """
    def decorator(func):
        def wrapper(*args, **kwargs):
            attempts = 0
            while attempts < max_attempts:
                try:
                    return func(*args, **kwargs)
                except ValueError as e:
                    attempts += 1
                    sleep_time = random.uniform(0, max_sleep)
                    print(f"""Attempt {attempts}: Failed with error {e}.
                           Retrying in {sleep_time:.2f} seconds...""")
                    time.sleep(sleep_time)
                except HttpError as e:
                    attempts += 1
                    sleep_time = random.uniform(0, max_sleep)
                    print(f"""Attempt {attempts}: Failed with error {e}.
                           Retrying in {sleep_time:.2f} seconds...""")
                    time.sleep(sleep_time)
            raise EmailError(f"Failed after {max_attempts} attempts.")
        return wrapper
    return decorator


class email_helper():# pylint: disable=C0103 disable=too-few-public-methods
    # the class name has to be exactly match to the name
    # of the file for robotframework to properly import it
    """
    This is the class which provides functionality for the test script
    """
    def __init__(self):
        self.email_template = "tim743244+{alias}@gmail.com"
        self.email = None
        file_path = Path(__file__)
        # form the path to the credentials folder
        cred_dir_path = file_path.parent.parent.joinpath("credentials")
        token_path = cred_dir_path.joinpath("token.json")
        cred_path = cred_dir_path.joinpath("credentials.json")
        creds = None
        scopes = ["https://www.googleapis.com/auth/gmail.readonly"]
        if os.path.exists(token_path):
            creds = Credentials.from_authorized_user_file(token_path, scopes)
        if not creds or not creds.valid:
            if creds and creds.expired and creds.refresh_token:
                creds.refresh(Request())
            else:
                flow = InstalledAppFlow.from_client_secrets_file(
                    cred_path, scopes
                )
                creds = flow.run_local_server(port=0)
                # Save the credentials for the next run
                with open(token_path, "w", encoding="utf-8") as token:
                    token.write(creds.to_json())
        self.creds = creds

    @retry(max_attempts=5, max_sleep=30)
    def get_auth_email(self, target_email:str) -> str: # pylint: disable=R1710
        # this method designed to return the validation link if found, but
        # given it might not be present, suppressing the pylint warning as it should
        # raise an exception in such case
        """
        This method returns the corresponding validation link for the given email
        """
        target_message = None
        try:
            # Call the Gmail API
            service = build("gmail", "v1", credentials=self.creds)
            results = service.users().messages().list(
                    userId="me",
                    labelIds=["Label_8637904359501327770"]
                ).execute()
            messages = results.get('messages', [])

            if not messages:
                raise ValueError("No email found")
            for message in messages:
                msg = service.users().messages().get(userId='me', id=message['id']).execute()
                for elem in msg["payload"]["headers"]:
                    if elem.get("name") == "Delivered-To":
                        # check receiver
                        if elem.get("value") == target_email:
                            target_message = msg["payload"]["body"]["data"]
                        break
                if target_message is not None:
                    break
        except HttpError as error:
            print(f"An error occurred: {error}")
            # check if target message exists
        if target_message is None:
            raise ValueError("No validation email found")
        # retrieve the message
        decoded_data = base64.urlsafe_b64decode(target_message.encode('ASCII'))
        html_content = decoded_data.decode('utf-8')
        soup = BeautifulSoup(html_content, features="html.parser")
        # get validation link
        for item in soup.find_all("span"):
            if "https" in item.text and "aha" in item.text:
                return item.text
        raise ValueError("No validation link found")
    def random_an_email(self) -> str:
        """
        This method returns a email with random generated alias
        """
        alias = ''.join(random.choices(string.ascii_lowercase + string.digits, k = 6))
        self.email = self.email_template.format(alias=alias)
        return self.email
    def get_email(self) -> str:
        """
        This method returns the email previously generated by the email helper
        """
        if self.email is None:
            raise ValueError("Email not set, call random an email first")
        return self.email

if __name__ == "__main__":
    a = email_helper()
    print("result:", a.get_auth_email("tim743244+88@gmail.com"))
