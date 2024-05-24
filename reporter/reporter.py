"""
This module will parse the result xml, compose and send the notification
"""
from slack_sender.config import SLACK_TOKEN
from slack_sender.sender import send_slack_message

CHANNEL_ID = 'C044SMHP44D'
send_slack_message(SLACK_TOKEN, CHANNEL_ID)
