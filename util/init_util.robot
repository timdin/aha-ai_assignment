*** Settings ***
Library  SeleniumLibrary
*** Keywords ***
Init browser
# centralize the method for selenium to open a new browser
    ${mode} =  Get Variable Value    ${mode}    default=none
    IF  "${mode}" == "headless"  
        Open Browser    url=https://app.earnaha.com/    browser=headlesschrome
    ELSE    
        Open Browser    url=https://app.earnaha.com/    browser=chrome
    END
    