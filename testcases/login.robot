*** Settings ***
Library    SeleniumLibrary
*** Test Cases ***
Login with Email
    Open Browser    url=https://app.earnaha.com/  browser=chrome
    Wait until element is visible  xpath://div[@class="em-button-base" and text()="Login"]
    Click element  xpath://div[@class="em-button-base" and text()="Login"]
    Wait until element is visible  xpath://input[@id="username"]
    Input text  xpath://input[@id="username"]  tim743244+1@gmail.com
    Input text  xpath://input[@id="password"]  apple banana123
    Click element  xpath://button[@type="submit"]
    Wait until element is visible  xpath://div[@class="em-button-base" and text()="Create Club"]
    
