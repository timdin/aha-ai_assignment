import requests

def send_elastic_email(api_key, from_email, to_email, subject, body_text, body_html):
    url = "https://api.elasticemail.com/v2/email/send"
    payload = {
        "apikey": api_key,
        "from": from_email,
        "to": to_email,
        "subject": subject,
        "bodyText": body_text,
        "bodyHtml": body_html,
        "isTransactional": True
    }
    response = requests.post(url, data=payload)
    return response.status_code, response.json()
