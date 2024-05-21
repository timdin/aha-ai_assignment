*** Settings ***
Library    SeleniumLibrary    timeout=10
Library    %{ROBOTPATH}/lib/date_helper.py
Library    %{ROBOTPATH}/lib/profile_helper.py
Library    ../.venv/lib/python3.12/site-packages/robot/libraries/XML.py
Resource   %{ROBOTPATH}/consts/lang_en.robot
*** Variables ***
# the available variables for placeholders are listed in the lang_en.robot
# as placeholders could possibly change given different language applications

*** Keywords ***
User Goto profile page
    [Documentation]    Use directly url access as there is a potential bug where the user could not access the profile through the sidebar when the user has not joined any club
    Go to    https://app.earnaha.com/profile/account

User click edit on profile page
    Wait Until Element Is Visible    xpath://div[@class="em-button-base" and text()=${EDIT PROFILE}]
    Click Element   xpath://div[@class="em-button-base" and text()=${EDIT PROFILE}]

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
    Click Element    xpath://div/div[${weekday}]/div/button[text()=${date}]
    # click ok button
    Click Element    xpath://button[@type="button" and text()=${OK}]

User click save on profile page
    Wait Until Element Is Visible    xpath://div[@class="em-button-base" and text()=${SAVE}]
    Click Element   xpath://div[@class="em-button-base" and text()=${SAVE}]

User should be on profile page
    # wait for the edit profile button as the indication for page loaded
    Wait Until Element Is Visible    xpath://div[@class="em-button-base" and text()=${EDIT PROFILE}]
    Location Should Be    https://app.earnaha.com/profile/account

User Birthday should be identical as set previously
    Wait Until Element Is Visible    xpath://input[@placeholder="DD / MM / YY"]
    # get date
    ${display date}=	SeleniumLibrary.Get Element Attribute	xpath://input[@placeholder="DD / MM / YY"]    value
    # get year and month here
    Click Element    xpath://input[@placeholder="DD / MM / YY"]
    Wait Until Element Is Visible    xpath://button[@title="Pick year"]
    ${display year and month}=	Get Text    xpath://button[@title="Pick year"]/p
    # compare date with the previous random selected date
    compare date    ${display date}    ${display year and month}

User set value on input field "${field}"
    [Documentation]    The variable $\{field\} should pass the name of the desired field, not the value of it
    ${placeholder} =    Set Variable   ${${field}}
    ${value} =    Random A String
    # set selenium speed slightly slower to make the following key press work
    ${original speed} =  Set Selenium Speed    0.3 seconds
    Wait Until Page Contains Element    xpath://input[@placeholder=${placeholder}]
    Scroll Element Into View    xpath://input[@placeholder=${placeholder}]
    # work around for clear element text, as clear text somehow didn't work
    Press keys  xpath://input[@placeholder=${placeholder}]  COMMAND+CTRL+a    BACKSPACE
    Input Text    xpath://input[@placeholder=${placeholder}]    ${value}
    Set Selenium Speed    ${original speed}
    Set Value    ${placeholder}    ${value}

Value of input field "${field}" should be identical
    [Documentation]    The variable $\{field\} should pass the name of the desired field, not the value of it
    ${placeholder} =    Set Variable   ${${field}}
    Wait Until Page Contains Element    xpath://input[@placeholder=${placeholder}]
    Scroll Element Into View    xpath://input[@placeholder=${placeholder}]
    ${value} =    SeleniumLibrary.Get Element Attribute    xpath://input[@placeholder=${placeholder}]    value
    Compare Value    ${placeholder}    ${value}
User set value on selection field "${field}"
    [Documentation]    The variable $\{field\} should pass the name of the desired field, not the value of it
    ${placeholder} =    Set Variable   ${${field}}
    # set selenium speed slightly slower to make the following key press work
    ${original speed} =  Set Selenium Speed    0.3 seconds
    Wait Until Page Contains Element    xpath://input[@placeholder=${placeholder}]
    Scroll Element Into View    xpath://input[@placeholder=${placeholder}]
    Click element    xpath://input[@placeholder=${placeholder}]
    # get all available elements from the dropdown selection field
    ${count} =    SeleniumLibrary.Get Element Count    xpath://li[@role="option"]
    ${selection} =   Random A Number    ${0}    ${count}
    # store the value of the randomly picked element
    ${value} =    Get Text    xpath://ul/li[${selection}]
    Click Element    xpath://ul/li[${selection}]
    Set Selenium Speed    ${original speed}
    Set Value    ${placeholder}    ${value}

Value of selection field "${field}" should be identical
    [Documentation]    The variable $\{field\} should pass the name of the desired field, not the value of it
    ${placeholder} =    Set Variable   ${${field}}
    Wait Until Page Contains Element    xpath://input[@placeholder=${placeholder}]
    Scroll Element Into View    xpath://input[@placeholder=${placeholder}]
    ${value} =    SeleniumLibrary.Get Element Attribute    xpath://input[@placeholder=${placeholder}]    value
    Compare Value    ${placeholder}    ${value}
User set value on text area field "${field}"
    [Documentation]    The variable $\{field\} should pass the name of the desired field, not the value of it
    ${placeholder} =    Set Variable   ${${field}}
    ${value} =    Random A String
    ${original speed} =  Set Selenium Speed    0.3 seconds
    Wait Until Page Contains Element    xpath://textarea[@placeholder=${placeholder}]
    Scroll Element Into View    xpath://textarea[@placeholder=${placeholder}]
    # work around for clear element text, as clear text somehow didn't work
    Press keys  xpath://textarea[@placeholder=${placeholder}]  COMMAND+CTRL+a    BACKSPACE
    Input Text    xpath://textarea[@placeholder=${placeholder}]    ${value}
    Set Selenium Speed    ${original speed}
    Set Value    ${placeholder}    ${value}

Value of text area field "${field}" should be identical
    [Documentation]    The variable $\{field\} should pass the name of the desired field, not the value of it
    ${placeholder} =    Set Variable   ${${field}}
    Wait Until Page Contains Element    xpath://textarea[@placeholder=${placeholder}]
    Scroll Element Into View    xpath://textarea[@placeholder=${placeholder}]
    ${value} =    SeleniumLibrary.Get Element Attribute    xpath://textarea[@placeholder=${placeholder}]    value
    Compare Value    ${placeholder}    ${value}

User set value on digit field "${field}"
    [Documentation]    The variable $\{field\} should pass the name of the desired field, not the value of it
    ${placeholder} =    Set Variable   ${${field}}
    # random a up to 4 digit number value
    ${value} =   Random A Number    ${0}    ${9999}
    # set value to string as the data was presented as string on the profile page
    ${value} =    Convert To String    ${value}
    ${original speed} =  Set Selenium Speed    0.3 seconds
    Wait Until Page Contains Element    xpath://input[@placeholder=${placeholder}]
    Scroll Element Into View    xpath://input[@placeholder=${placeholder}]
    # work around for clear element text, as clear text somehow didn't work
    Press keys  xpath://input[@placeholder=${placeholder}]  COMMAND+CTRL+a    BACKSPACE
    Input Text    xpath://input[@placeholder=${placeholder}]    ${value}
    Set Selenium Speed    ${original speed}
    Set Value    ${placeholder}    ${value}

Value of digit field "${field}" should be identical
    [Documentation]    The variable $\{field\} should pass the name of the desired field, not the value of it
    ${placeholder} =    Set Variable   ${${field}}
    Wait Until Page Contains Element    xpath://input[@placeholder=${placeholder}]
    Scroll Element Into View    xpath://input[@placeholder=${placeholder}]
    ${value} =    SeleniumLibrary.Get Element Attribute    xpath://input[@placeholder=${placeholder}]    value
    Compare Value    ${placeholder}    ${value}