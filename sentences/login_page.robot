*** Settings ***
Library    SeleniumLibrary
*** Keywords ***
The Login button is visible
    Wait until element is visible  xpath://div[@class="em-button-base" and text()="Login"]

User Click the Login button
    Click element  xpath://div[@class="em-button-base" and text()="Login"]

The Email field should be visible
    Wait until element is visible  xpath://input[@id="username"]

User input to email field 
    [Arguments]    ${email}
    Input text  xpath://input[@id="username"]  ${email}

User input to password field
    [Arguments]    ${password}
    Input text  xpath://input[@id="password"]  ${password}

User Click submit button on login page
    Click element  xpath://button[@type="submit"]

User should be logged in
    Wait until element is visible  xpath://div[@class="em-button-base" and text()="Create Club"]

Error message for login should be visible
    Wait until element is visible  xpath://span[@id="error-element-password"]

Google auth button should be visible
    Wait until element is visible  xpath://button[@type="submit" and @data-provider="google"]

User Click Google auth
    Click element  xpath://button[@type="submit" and @data-provider="google"]

Finish login to Google account
    Wait until element is visible  xpath://input[@type="email"]
    Input text  xpath://input[@type="email"]  tim743244@gmail.com
    # press key to work around the submition button
    Press keys  xpath://input[@type="email"]  ENTER
    Wait until element is visible  xpath://input[@type="password"]
    Input text  xpath://input[@type="password"]  apple banana
    Press keys  xpath://input[@type="password"]  ENTER