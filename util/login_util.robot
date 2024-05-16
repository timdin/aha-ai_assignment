*** Settings ***
Resource   %{ROBOTPATH}/sentences/login_page.robot
*** Keywords ***
User Login with Email and Password
    [Arguments]    ${email}    ${password}
    The Login button is visible
    User Click the Login button
    The Email field should be visible
    User input to email field    ${email}
    User input to password field    ${password}
    User Click submit button on login page
    User should be logged in

User Login with Google
    The Login button is visible
    User Click the Login button
    Google auth button should be visible
    User Click Google auth
    Finish login to Google account
    User should be logged in