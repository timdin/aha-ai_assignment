*** Settings ***
Library    SeleniumLibrary
Resource   %{ROBOTPATH}/sentences/login_page.robot
Test Tags  Login
Test Setup  Open Browser    url=https://app.earnaha.com/  browser=chrome
Test Teardown  Close Browser
*** Test Cases ***
Login with Email
    Given The Login button is visible
    When User Click the Login button
    Then The Email field should be visible
    When User input to email field  tim743244+1@gmail.com
    And User input to password field  apple banana123
    And User Click submit button on login page
    Then User should be logged in
    
Login with Email invalid case
    Given The Login button is visible
    When User Click the Login button
    Then The Email field should be visible
    When User input to email field  tim743244+1@gmail.com
    And User input to password field  invalid password
    And User Click submit button on login page
    Then Error message for login should be visible

Login with Google account
    Given The Login button is visible
    When User Click the Login button
    Then Google auth button should be visible
    When User Click Google auth
    And Finish login to Google account
    Then User should be logged in