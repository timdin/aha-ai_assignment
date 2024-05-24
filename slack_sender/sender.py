"""
The sender module implements the basic functionality of sending message in Block format
"""
import json
import requests

def send_slack_message(
        slack_token:str,
        channel:str,
        result:tuple,
        url:str
        ):
    """
    This function sends a pre-defined formatted slack message
    to the desired channel with given token
    slack_token: token of the bot
    channel: id of the channel
    """
    message_payload = {
        "channel": channel,
        "blocks": [
            {
                "type": "section",
                "text": {
                    "type": "mrkdwn",
                    "text": "*Hello, Slack!*\nHere is the latest result from Github action"
                }
            },
            {
                "type": "section",
                "fields": [
                    {
                        "type": "mrkdwn",
                        "text": f">*Pass*: {result[0]}\n>*Fail*: {result[1]}\n>*Skip*: {result[2]}"
                    }
                ]
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
                        "url": url
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

    response = requests.post(url, headers=headers, data=json.dumps(message_payload), timeout=5)

    if response.status_code == 200 and response.json().get('ok'):
        print('Message sent successfully!')
    else:
        print(f'Failed to send message: {response.status_code}')
        print(response.text)
