*** Settings ***
Library    SeleniumLibrary
Resource    login_page.robot
*** Keywords ***
User Goto profile page
    [Documentation]    Use directly url access as there is a potential bug where the user could not access the profile through the sidebar when the user has not joined any club
    Go to    https://app.earnaha.com/profile/account

User clicked logged out
    [Documentation]    This sentence uses pure text and elem type to locate the element, should be possible to be more decisive if the element could have some unique identifier
    Wait until element is visible    xpath://p[text()="Log out"]/..
    Click Element    xpath://p[text()="Log out"]/..
    Wait Until Element Is Visible    xpath://button[text()="Yes"]
    Click Element    xpath://button[text()="Yes"]

User should be logged out
    [Documentation]    This sentence determines if the user was logged out by checking if the log in button is visible again
    The Login button is visible
