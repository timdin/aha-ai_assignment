*** Settings ***
Library    SeleniumLibrary
Resource   %{ROBOTPATH}/consts/lang_en.robot
Library    %{ROBOTPATH}/lib/email_helper.py
*** Keywords ***
The Sign up button is visible
    Wait until element is visible  xpath://div[@class="em-button-base" and text()=${SIGN UP}]

User Click the Sign up button
    Click element  xpath://div[@class="em-button-base" and text()=${SIGN UP}]

The Email field on sign up page should be visible
    Wait until element is visible  xpath://input[@id="email"]

User input to email field on sign up page
    ${email} =    Random An Email
    Input text  xpath://input[@id="email"]  ${email}

User input to password field on sign up page
    Input text  xpath://input[@id="password"]  apple banana123

User Click submit button on sign up page
    Click element  xpath://button[@type="submit"]

User should be logged in with message of validate email
    # use resend email button as the indication of validate email
    Wait until element is visible    xpath://button[text()=${RESEND EMAIL}]
    # Combine the create club button to indicate the user is logged in
    Wait until element is visible  xpath://div[@class="em-button-base" and text()=${CREATE CLUB}]

User validate with the link in the email
    # retrieve the previous used email
    ${sign up email} =    Get Email
    Log    The email to be validate is ${sign up email}
    # retrieve the auth link for the corresponding email
    ${auth link} =    Get Auth Email    ${sign up email}
    Log    The corresponding validation link is ${auth link}
    # trigger the auth link by directly opening the link to simulate clicking the link
    Go To    ${auth link}

User should be logged in with out message of validate email
    # after the user clicked the link in the validation email, user will be redirected to the profile page
    # hence use the edit profile button to indicate the page is loaded
    Wait until element is visible    xpath://div[@class="em-button-base" and text()=${EDIT PROFILE}]
    Page Should Not Contain Element    xpath://button[text()=${RESEND EMAIL}]