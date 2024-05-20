*** Settings ***
Library    SeleniumLibrary
Resource    login_page.robot
Resource    %{ROBOTPATH}/consts/lang_en.robot
*** Keywords ***
User clicked logged out
    [Documentation]    This sentence uses pure text and elem type to locate the element, should be possible to be more decisive if the element could have some unique identifier
    Wait until element is visible    xpath://p[text()=${LOGOUT}]/..
    Click Element    xpath://p[text()=${LOGOUT}]/..
    Wait Until Element Is Visible    xpath://button[text()=${LOGOUT YES}]
    Click Element    xpath://button[text()=${LOGOUT YES}]

User should be logged out
    [Documentation]    This sentence determines if the user was logged out by checking if the log in button is visible again
    The Login button is visible
