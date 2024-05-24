from email_service.send_email import send_mailgun_email
from email_service.email_config import MAILGUN_API_KEY, MAILGUN_DOMAIN, FROM_EMAIL

def main():
    to_email = 'tim743244@gmail.com'
    subject = 'Test Email from Mailgun'
    text_content = 'This is a test email sent using Mailgun.'
    html_content = '<h3>This is a test email sent using <a href="https://www.mailgun.com/">Mailgun</a></h3>'
    
    status_code, response_json = send_mailgun_email(
        MAILGUN_API_KEY, MAILGUN_DOMAIN, FROM_EMAIL,
        to_email, subject, text_content, html_content
    )
    
    print('Status Code:', status_code)
    print('Response:', response_json)

if __name__ == "__main__":
    main()
