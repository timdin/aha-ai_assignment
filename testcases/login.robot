*** Settings ***
Library    SeleniumLibrary
Test Tags  Login
Test Setup  Open Browser    url=https://app.earnaha.com/  browser=chrome
Test Teardown  Close Browser
*** Test Cases ***
Login with Email
    Wait until element is visible  xpath://div[@class="em-button-base" and text()="Login"]
    Click element  xpath://div[@class="em-button-base" and text()="Login"]
    Wait until element is visible  xpath://input[@id="username"]
    Input text  xpath://input[@id="username"]  tim743244+1@gmail.com
    Input text  xpath://input[@id="password"]  apple banana123
    Click element  xpath://button[@type="submit"]
    Wait until element is visible  xpath://div[@class="em-button-base" and text()="Create Club"]
    
Login with Google account
    Wait until element is visible  xpath://div[@class="em-button-base" and text()="Login"]
    Click element  xpath://div[@class="em-button-base" and text()="Login"]
    Wait until element is visible  xpath://button[@type="submit" and @data-provider="google"]
    Click element  xpath://button[@type="submit" and @data-provider="google"]
    Wait until element is visible  xpath://input[@type="email"]
    Input text  xpath://input[@type="email"]  tim743244@gmail.com
    # press key to work around the submition button
    Press keys  xpath://input[@type="email"]  ENTER
    Wait until element is visible  xpath://input[@type="password"]
    Input text  xpath://input[@type="password"]  apple banana
    Press keys  xpath://input[@type="password"]  ENTER
    Wait until element is visible  xpath://div[@class="em-button-base" and text()="Create Club"]