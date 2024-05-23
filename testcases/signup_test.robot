*** Settings ***
Library    SeleniumLibrary
Resource   %{ROBOTPATH}/sentences/signup_page.robot
Resource   %{ROBOTPATH}/sentences/login_page.robot
Test Tags  Sign up
Test Setup  Init browser
Test Teardown  Close Browser

*** Test Cases ***
User should be able to sign up with email and password
    Given The Sign up button is visible
    When User Click the Sign up button
    Then The Email field on sign up page should be visible
    When User input to email field on sign up page
    And User input to password field on sign up page
    And User Click submit button on sign up page
    Then User should be logged in with message of validate email
    When User validate with the link in the email
    Then User should be logged in with out message of validate email

User should be able to sign up with google account
    [Documentation]    Since programmatically create a new google account is sort of forbidden, I'll not create a new google account but use the existing google account with sign up flow
    [Tags]    google
    Given The Sign up button is visible
    When User Click the Sign up button
    Then Google auth button should be visible
    When User Click Google auth
    And Finish login to Google account
    Then User should be logged in