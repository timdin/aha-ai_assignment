"""
This module implements a simple wrapper for making the request of sending email
"""
from email_service.email_config import ELASTIC_EMAIL_API_KEY, FROM_EMAIL

import requests

def send_elastic_email(to_email:str, body_html:str):
    """
    This function sends an email via Elastic email with the given information
    """
    url = "https://api.elasticemail.com/v2/email/send"
    payload = {
        "apikey": ELASTIC_EMAIL_API_KEY,
        "from": FROM_EMAIL,
        "to": to_email,
        "subject": "Latest test result from github action",
        "bodyText": "Checkout the latest test result from github action",
        "bodyHtml": body_html,
        "isTransactional": True
    }
    requests.post(url, data=payload, timeout=10)
