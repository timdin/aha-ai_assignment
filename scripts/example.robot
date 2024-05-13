*** Settings ***
Library    SeleniumLibrary
*** Test Cases ***
Open browser and land on google homepage
    Open Browser    url=https://google.com    browser=chrome
