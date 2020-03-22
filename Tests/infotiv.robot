*** Settings ***
Documentation   Basic info
Resource  ../Resources/keywords.robot
Library  SeleniumLibrary
Test Setup  Begin Web Test
Test Teardown  End Web Test

*** Variables ***
${BROWSER} =    Chrome
${URL} =    http://rental28.infotiv.net/
${VALID_USER} =     elin.arnten@hotmail.com
${VALID_PASSWORD} =    123456789
${UNVALID_PASSWORD} =  12345


*** Test Cases ***
Create User Fail
    [Documentation]  The password is required to be more than six characters. This test case is about to see if there will be an error if you type in less than six characters.
    [Tags]          Test 1
    Go To Web Page
    Verify Page Loaded
    Create User Error

Login
    [Documentation]     When the user does the login successfull the header will verify.
    [Tags]          Test 2
    Given Go To Web Page
    When Login      ${VALID_USER}   ${VALID_PASSWORD}
    Then Wait Until Page Contains   You are signed in as elin

Book a Car
    [Documentation]     Testing the booking function and verify if any possible changes is restored.
    [Tags]          Test 3
    Go To Web Page
    Login Success
    To selecting car Page
    Verify Car page loaded
    Select The First Car
    Verify Card page loaded
    Type in Card Information
    Verify Confirm Page Loaded
    Go To My Page
    Verify Mypage Page Loaded
    Cancel Booking
    Go To My Page
    Verify Booking is Cancelled

Book a car error
    [Documentation]     Trying to book a car that can't take 9 passengers.
    [Tags]          Test 4
    Given Go To Web Page
    When Login Success
    When To selecting car Page
    When Select Car Brand
    When Select Number of Passengers
    Then Verify Error Message

Choose a Date
    [Documentation]     Selecting a day in the calender in order to book a car.
    [Tags]          Test 5
    Go To Web Page
    Login Success
    Select Date Start
    Click Button    id:continue

Invalid Date
    [Documentation]     Trying to select yesterday's date.
    [Tags]          Test 6
    Go To Web Page
    Login Success
    Select Date End
    Click Button    id:continue
    Wait until Element is Visible       css:#end:invalid

Header
    [Documentation]     The header should be visable on every page.
    [Tags]          VG_test
    Given Go To Web Page
    Given Login Success
    When Check Header
    Then Verify Header

