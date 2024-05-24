import requests
import json

def send_slack_message(slack_token, channel):
    message_payload = {
        "channel": channel,
        "blocks": [
            {
                "type": "section",
                "text": {
                    "type": "mrkdwn",
                    "text": "*Hello, Slack!*\nThis is a message from CI result"
                }
            },
            {
                "type": "divider"
            },
            {
                "type": "section",
                "fields": [
                    {
                        "type": "mrkdwn",
                        "text": "*Priority:*\nHigh"
                    },
                    {
                        "type": "mrkdwn",
                        "text": "*Status:*\nOpen"
                    }
                ]
            },
            {
                "type": "divider"
            },
            {
                "type": "section",
                "text": {
                    "type": "mrkdwn",
                    "text": "Click the button below for the github action page"
                }
            },
            {
                "type": "actions",
                "elements": [
                    {
                        "type": "button",
                        "text": {
                            "type": "plain_text",
                            "text": "Go to github action Job"
                        },
                        "style": "primary",
                        "action_id": "goto_job",
                        "url": "https://google.com"
                    }
                ]
            }
        ]
    }
    # Send the message using the Slack API
    url = 'https://slack.com/api/chat.postMessage'
    headers = {
        'Content-Type': 'application/json',
        'Authorization': f'Bearer {slack_token}'
    }

    response = requests.post(url, headers=headers, data=json.dumps(message_payload))

    if response.status_code == 200 and response.json().get('ok'):
        print('Message sent successfully!')
    else:
        print(f'Failed to send message: {response.status_code}')
        print(response.text)
