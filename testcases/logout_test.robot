*** Settings ***
Library    SeleniumLibrary
Resource    %{ROBOTPATH}/util/login_util.robot
Resource    %{ROBOTPATH}/sentences/logout_page.robot
Resource    %{ROBOTPATH}/sentences/profile_page.robot
Resource   %{ROBOTPATH}/util/init_util.robot
Test Tags  Logout
Test Setup    Init browser
Test Teardown    Close Browser
*** Test Cases ***
User should be able to logout when logged in with email and password
    When User Login with Email and Password
    And User Goto profile page
    And User clicked logged out
    Then User should be logged out
User should be able to logout when logged in with Google 
    [Tags]    google
    When User Login with Google
    And User Goto profile page
    And User clicked logged out
    Then User should be logged out