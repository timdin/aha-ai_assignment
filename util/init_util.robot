*** Settings ***
Library  SeleniumLibrary
*** Keywords ***
Init browser
# centralize the method for selenium to open a new browser
    ${mode} =  Get Variable Value    ${mode}    default=none
    IF  "${mode}" == "headless"
        ${options}=    Evaluate    sys.modules['selenium.webdriver'].chrome.options.Options()    sys, selenium.webdriver
        Call Method    ${options}    add_argument    --disable-dev-shm-usage
        Call Method    ${options}    add_argument    --no-sandbox
        Call Method    ${options}    add_argument    --headless
        Create WebDriver    Chrome    options=${options}
        Go To    https://app.earnaha.com/
    ELSE    
        Open Browser    url=https://app.earnaha.com/    browser=chrome
    END
    Set Selenium Timeout    45
    