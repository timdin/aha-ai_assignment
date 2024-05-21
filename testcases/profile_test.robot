*** Settings ***
Library    SeleniumLibrary
Resource    %{ROBOTPATH}/util/login_util.robot
Resource    %{ROBOTPATH}/sentences/profile_page.robot
Test Tags    profile
Test Setup    Given User open homepage and login with email
Test Teardown    Close Browser
*** Test Cases ***
User should be able to set the date of birth
    [Tags]    Date selector
    When User Goto profile page
    And User click edit on profile page
    And User select a date of birth for current test
    And User set the selected date on the calendar
    And User click save on profile page
    Then User should be on profile page
    When User click edit on profile page
    Then User Birthday should be identical as set previously


User should be able to set the date of birth (leap date)
    [Tags]    Date selector
    When User Goto profile page
    And User click edit on profile page
    And User select a leap date of birth for current test
    And User set the selected date on the calendar
    And User click save on profile page
    Then User should be on profile page
    When User click edit on profile page
    Then User Birthday should be identical as set previously

User should be able to set the input information on profile page
    [Tags]    Profile setting    input
    When User Goto profile page
    And User click edit on profile page
    # update profile here
    And User set value on input field "Full Name"
    And User set value on input field "User Name"
    And User set value on input field "High School Name"
    And User click save on profile page
    Then User should be on profile page
    # validate profile here
    When User click edit on profile page
    Then Value of input field "Full Name" should be identical
    And Value of input field "User Name" should be identical
    And Value of input field "High School Name" should be identical

User should be able to set the selection information on profile page
    [Tags]    Profile setting    selection
    When User Goto profile page
    And User click edit on profile page
    # update profile here
    And User set value on selection field "Gender"
    And User set value on selection field "Dream College"
    And User click save on profile page
    Then User should be on profile page
    # validate profile here
    When User click edit on profile page
    Then Value of input field "Gender" should be identical
    And Value of input field "Dream College" should be identical

User should be able to set the text area on profile page
    [Tags]    Profile setting    textarea
    When User Goto profile page
    And User click edit on profile page
    # update profile here
    And User set value on text area field "Bio"
    And User click save on profile page
    Then User should be on profile page
    # validate profile here
    When User click edit on profile page
    Then Value of text area field "Bio" should be identical


User should be able to set the digit information on profile page
    [Tags]    Profile setting    digit
    When User Goto profile page
    And User click edit on profile page
    # update profile here
    And User set value on digit field "High School Graduation Year"
    And User click save on profile page
    Then User should be on profile page
    # validate profile here
    When User click edit on profile page
    Then Value of digit field "High School Graduation Year" should be identical


