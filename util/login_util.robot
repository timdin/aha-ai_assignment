*** Settings ***
Resource   %{ROBOTPATH}/sentences/login_page.robot
Resource   %{ROBOTPATH}/consts/account.robot
*** Keywords ***
User Login with Email and Password
    The Login button is visible
    User Click the Login button
    The Email field should be visible
    User input to email field    ${EMAIL}
    User input to password field    ${PASSWORD}
    User Click submit button on login page
    User should be logged in

User Login with Google
    [Documentation]    Use hard coded username and password for google account login
    The Login button is visible
    User Click the Login button
    Google auth button should be visible
    User Click Google auth
    Finish login to Google account
    User should be logged in