import requests

def send_mailgun_email(api_key, domain, from_email, to_email, subject, text_content, html_content):
    url = f"https://api.mailgun.net/v3/{domain}/messages"
    auth = ("api", api_key)
    data = {
        "from": from_email,
        "to": to_email,
        "subject": subject,
        "text": text_content,
        "html": html_content,
    }
    response = requests.post(url, auth=auth, data=data)
    return response.status_code, response.json()
