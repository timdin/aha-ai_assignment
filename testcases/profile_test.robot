*** Settings ***
Library    SeleniumLibrary
Resource    %{ROBOTPATH}/util/login_util.robot
Resource    %{ROBOTPATH}/sentences/profile_page.robot
Test Tags    profile
Test Setup    Open Browser    url=https://app.earnaha.com/    browser=chrome
Test Teardown    Close Browser
*** Test Cases ***
User should be able to set the date of birth
    When User Login with Email and Password
    And User Goto profile page
    And User click edit on profile page
    And User select a date of birth for current test
    And User set the selected date on the calendar
    And User click save on profile page
    Then User should be on profile page
    When User click edit on profile page
    Then User Birthday should be identical as set previously


User should be able to set the date of birth (leap date)
    When User Login with Email and Password
    And User Goto profile page
    And User click edit on profile page
    And User select a leap date of birth for current test
    And User set the selected date on the calendar
    And User click save on profile page
    Then User should be on profile page
    When User click edit on profile page
    Then User Birthday should be identical as set previously
