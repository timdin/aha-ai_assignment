"""
This script will parse the result xml, compose and send the notification
"""
import sys
import os
from lxml import etree

from slack_sender.config import SLACK_TOKEN
from slack_sender.sender import send_slack_message

from email_service.send_email import send_elastic_email
from email_service.email_template import format_email

def parse_result(filepath:str) -> tuple[str, str, str]:
    """
    This function will take a filepath as input of robot result xml,
    and return 3 strings as the result count of pass, fail and skip
    
    input
    - filepath: string
    
    output
    - pass, fail, skip: string
    """
    tree = etree.parse(filepath)
    stat = tree.find(".//statistics/total/stat")
    return stat.get("pass"), stat.get("fail"), stat.get("skip")

# this is the entry point for the reporting module
if __name__ == '__main__':
    # receive the result xml from input variables
    if len(sys.argv) < 2:
        raise ValueError("Wrong number of arguments, "
                         "expected 2 argument of report path and run path")
    res = parse_result(os.path.join(sys.argv[1], "output.xml"))
    # push to slack
    CHANNEL_ID = "C044SMHP44D"
    send_slack_message(SLACK_TOKEN, CHANNEL_ID, res, sys.argv[2])
    # push to email
    # I'm using elastic email as the email service provider
    # but the free trial seems only works with the email I used to setup the account
    TO_EMAIL = "tim743244@gmail.com"
    body_html = format_email(res[0],res[1],res[2], sys.argv[2])
    send_elastic_email(TO_EMAIL, body_html)
