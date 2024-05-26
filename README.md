# Web-automation assignment

## Introduction

The project contains the basic tests for the following features:

* Login
* Log out
* Profile editing
* Sign up

Also, the implementation supports sending email and slack notifications once the github action pipeline is done.

See screenshots here

Email:

![image](https://github.com/timdin/aha-ai_assignment/blob/main/notification_screenshots/email_notification.png)

Slack:

![image](https://github.com/timdin/aha-ai_assignment/blob/main/notification_screenshots/slack_notification.png)

## Repository breakdown

Here is a high-level summary of each folder in the repository

* consts:

    contains the information for the test account, I could use github action secrets for them but it would take away the availability of executing locally

* credentials:

    contains the token for the email accessing module, it's currently not available in the repo since it was runtime exported from the github action secrets, kindly reach out to me if you want to set it up locally

* email_service:

    contains the module for sending the report email notification once the pipeline is done

* lib:

    contains the custom library for the test execution

    there are some pylint suppressions here and there, I've commented the reason for taking the rule violating approach.

* reporter:

    contains the python script of parsing the result from the result xml, and calls the email_service and slack_sender modules for sending the notification

* sentences:

    contains the sentences(aka keywords for robotframework) for the test execution

* slack_sender:

    contains the module of sending the slack notification

* testcases:

    contains the actual test scripts, it's composed entirely by readable sentences from the sentences folder

* util:

    contains several sentences for common setup like opening the browser and login

## Notes

Currently, there are several difficulties in the project, which are perhaps doable, but considering this is for assignment purposes, not for production application, I'll stop here but leave some thoughts.

1.
    The google authentication in the sign-in/sign-up process will always fail, since the captcha chanllage will always appear for the environment hosted by github

    Possible solution might be adding a test profile and set it up upon opening the browser, but I didn't find a way to do so yet.

2.
    The test stability of the suite is still not very good, even after adding the re-run failure execution, despite the local execution being successful.

    I'll attach [a successful report](https://github.com/timdin/aha-ai_assignment/blob/main/reports.zip) in the repo, feel free to check it out.

3.
    The current method of defining the xpath is not really scalable if there are tons of elements to locate.

    I'll consider adding a name-space alike approach for the scenario but since the assignment wasn't having that much of element, I'll take the light weight approach for now.

4.
    The current github action (or CI pipeline) was slightly unhygienic as it just stuffed all the steps into one job, but since the github action does not preserve the previous environment from previous job, inorder not to run `pip install -r requirements.txt` all the time, I still take the unhygienic but faster way.

## setting up the environment

1. Clone the project
2. `cd` into the folder
3. Set up virtual environment with following command

    ```shell
    python -m venv .venv
    ```

4. Run the following command to activate the virtual environment

    ```shell
    source .venv/bin/activate
    ```

5. Run the follwing command to install the dependencies

    ```shell
    pip install -r requirements.txt
    ```

    And check if the environment is ready by

    ```shell
    robot --version
    ```

6. Set up path for robot execution and python path

    The robot path is mandatory, but the python path is optional as it was only for the reporter module

    ```shell
    export ROBOTPATH=${PWD}
    # optional
    export PYTHONPATH=$PYTHONPATH:${PWD}
    ```

7. Place the credentials in the credentials folder.

    You could reach out to me for the credentials.

8. Run all the testcases

    ```shell
    robot testcases
    ```

    And you should be able to see the result htmls.

9. Headless mode is also supported

    ```shell
    robot --variable mode:headless testcases
    ```
