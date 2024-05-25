from email_service.send_email import send_elastic_email
from email_service.email_config import ELASTIC_EMAIL_API_KEY, FROM_EMAIL

def main():
    to_email = 'tim743244@gmail.com'
    subject = 'Test Email from Elastic Email'
    body_text = 'This is a test email sent using Elastic Email.'
    body_html = '<h3>This is a test email sent using <a href="https://elasticemail.com/">Elastic Email</a></h3>'
    
    status_code, response_json = send_elastic_email(
        ELASTIC_EMAIL_API_KEY, FROM_EMAIL,
        to_email, subject, body_text, body_html
    )
    
    print('Status Code:', status_code)
    print('Response:', response_json)


if __name__ == "__main__":
    main()
