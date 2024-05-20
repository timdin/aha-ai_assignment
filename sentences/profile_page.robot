*** Settings ***
Library    SeleniumLibrary    timeout=10
Library    %{ROBOTPATH}/lib/date_helper.py
*** Keywords ***
User Goto profile page
    [Documentation]    Use directly url access as there is a potential bug where the user could not access the profile through the sidebar when the user has not joined any club
    Go to    https://app.earnaha.com/profile/account

User click edit on profile page
    Wait Until Element Is Visible    xpath://div[@class="em-button-base" and text()="Edit Profile"]
    Click Element   xpath://div[@class="em-button-base" and text()="Edit Profile"]

User select a date of birth for current test
    Get a date

User select a leap date of birth for current test
    Get A Leap Date

User set the selected date on the calendar
    Wait Until Element Is Visible    xpath://input[@placeholder="DD / MM / YY"]
    Click Element    xpath://input[@placeholder="DD / MM / YY"]
    Wait Until Element Is Visible    xpath://button[@title="Pick year"]
    # format here: June 1999
    ${display year and month}=	Get Text    xpath://button[@title="Pick year"]/p
    Click Element    xpath://button[@title="Pick year"]
    # get year and click year
    ${year}=    get year of date
    Click Element    xpath://button[text()=${year}]
    # get direction for month selection
    ${direction}=     get direction    current=${display year and month}
    
    # loop and select corresponding month, until direction is "just"
    WHILE    $direction != "just"
    Wait Until Element Is Visible    xpath://button[@title="${direction}"]
    Click Element    xpath://button[@title="${direction}"]
    ${display year and month}=	Get Text    xpath://button[@title="Pick year"]/p
    ${direction}=     get direction    current=${display year and month}
    END
    # select date
    # since it's possible that the same date has 2 appearance, select the one with the correct weekday
    ${date}    ${weekday}=    Get Day Of Date
    Click Element    xpath://div/div[${weekday}]/div/button[text()="${date}"]
    # click ok button
    Click Element    xpath://button[@type="button" and text()="OK"]

User click save on profile page
    Wait Until Element Is Visible    xpath://div[@class="em-button-base" and text()="Save"]
    Click Element   xpath://div[@class="em-button-base" and text()="Save"]

User should be on profile page
    # wait for the edit profile button as the indication for page loaded
    Wait Until Element Is Visible    xpath://div[@class="em-button-base" and text()="Edit Profile"]
    Location Should Be    https://app.earnaha.com/profile/account

User Birthday should be identical as set previously
    Wait Until Element Is Visible    xpath://input[@placeholder="DD / MM / YY"]
    # get date
    ${display date}=	Get Element Attribute	xpath://input[@placeholder="DD / MM / YY"]    value
    # get year and month here
    Click Element    xpath://input[@placeholder="DD / MM / YY"]
    Wait Until Element Is Visible    xpath://button[@title="Pick year"]
    ${display year and month}=	Get Text    xpath://button[@title="Pick year"]/p
    # compare date with the previous random selected date
    compare date    ${display date}    ${display year and month}

