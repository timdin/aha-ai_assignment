*** Settings ***
Library    SeleniumLibrary
Resource   %{ROBOTPATH}/sentences/login_page.robot
Resource   %{ROBOTPATH}/consts/account.robot
Resource   %{ROBOTPATH}/util/init_util.robot
Test Tags  Login
Test Setup  Init browser
Test Teardown  Close Browser
*** Test Cases ***
User shoule be able to Login with Email and Password
    Given The Login button is visible
    When User Click the Login button
    Then The Email field should be visible
    When User input to email field    ${EMAIL}
    And User input to password field    ${PASSWORD}
    And User Click submit button on login page
    Then User should be logged in
    
User should not be able to Login with incorrect password
    Given The Login button is visible
    When User Click the Login button
    Then The Email field should be visible
    When User input to email field    ${EMAIL}
    And User input to password field    ${INVALID PASSWORD}
    And User Click submit button on login page
    Then Error message for login should be visible

User should be able to login with Google account
    [Tags]    google
    Given The Login button is visible
    When User Click the Login button
    Then Google auth button should be visible
    When User Click Google auth
    And Finish login to Google account
    Then User should be logged in