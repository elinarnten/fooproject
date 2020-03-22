*** Settings ***
Documentation   Basic info
#Resource  ../Resources/keywords.robot
Library  SeleniumLibrary
Test Setup  Begin Web Test
Test Teardown  End Web Test

*** Variables ***
${BROWSER} =    Chrome
${URL} =    http://rental28.infotiv.net/
${VALID_USER} =     elin.arnten@hotmail.com
${VALID_PASSWORD} =    123456789
${UNVALID_PASSWORD} =  12345

*** Keywords ***
Begin Web Test
    Open Browser    about:blank  ${BROWSER}
    Maximize Browser Window

Go To Web Page
    Go To   ${URL}

Verify Page Loaded
    ${link_text} =                Get Text    xpath://*[@id="title"]
    Should be Equal             ${link_text}  Infotiv Car Rental

Create User Error
    Click Button    xpath://*[@id="createUser"]
    Input Text      xpath://*[@id="name"]   elin
    Input Text      xpath://*[@id="last"]   arnten
    Input Text      xpath://*[@id="phone"]  07123456798
    Input Text      xpath://*[@id="emailCreate"]    elin.arnten@hotmail.com
    Input Text      xpath://*[@id="confirmEmail"]   elin.arnten@hotmail.com
    Input Text      xpath://*[@id="passwordCreate"]     12345
    Input Text      xpath://*[@id="confirmPassword"]    12345
    Click Button    xpath://*[@id="create"]
    Wait until Element is Visible       css:#passwordCreate:invalid

Login Success
    Input Text      xpath://*[@id="email"]  ${VALID_USER}
    Input Text      xpath://*[@id="password"]   ${VALID_PASSWORD}
    Click Button    xpath://*[@id="login"]

Login
    [Arguments]     ${email}    ${password}
    Input Text    id:email   ${email}
    Input Text    id:password   ${password}
    Click Button    xpath://*[@id="login"]

To selecting car Page
    Sleep  2 s
    Click Button    xpath://*[@id="continue"]

Verify Car Page Loaded
    ${link_text} =      Get Text    //*[@id="questionText"]
    Should be Equal     ${link_text}  What would you like to drive?

Select The First Car
    Click Button    xpath://*[@id="bookQ7pass5"]

Verify Card Page Loaded
    ${link_text} =      Get Text  //*[@id="questionText"]
    Should be Equal     ${link_text}  Confirm booking of Audi Q7

Cancel Car Booking
    Click Button    xpath://*[@id="cancel"]

Back to Homepage
    Click Element    xpath://*[@id="title"]

Type in Card Information
    Input Text      xpath://*[@id="cardNum"]    1212121212121212
    Input Text      xpath://*[@id="fullName"]   elin
    Input Text      xpath://*[@id="cvc"]    345
    Click Button    xpath://*[@id="confirm"]

Verify Confirm Page Loaded
    ${link_text} =      Get Text  xpath://*[@id="confirmMessage"]/label
    Should be Equal     ${link_text}  You can view your booking on your page

Go To My Page
    Click Button    xpath://*[@id="mypage"]

Verify Mypage Page Loaded
    ${link_text} =      Get Text  //*[@id="historyText"]
    Should be Equal     ${link_text}    My bookings

Cancel Booking
    Click Button    xpath://*[@id="unBook1"]
    Handle Alert

Verify Booking is Cancelled
    Wait Until Page Contains    You have no bookings

Select Car Brand
    Click Button    xpath://*[@id="ms-list-1"]/button
    Click Element   xpath://*[@id="ms-list-1"]/div/ul/li[4]/label

Select Number of Passengers
    Click Element   xpath://*[@id="ms-list-2"]/button
    Click Element   xpath://*[@id="ms-opt-9"]

Verify Error Message
    Wait Until Page Contains    No cars with selected filters. Please edit filter selection.

Select Date Start
    ${START_DAY} =       Get Time        day month       now + 10 day
    Input Text      id:start        ${START_DAY}

Select Date End
    ${END_DAY} =        Get Time        day month       now - 1 day
    Input Text      id:end          ${END_DAY}

Verify Header
    Wait Until Page Contains    Infotiv Car Rental

Check Header
    Wait Until Page Contains    Infotiv Car Rental
    Click Button    xpath://*[@id="continue"]
    Wait Until Page Contains    Infotiv Car Rental
    Click Button    xpath://*[@id="bookQ7pass5"]
    Wait Until Page Contains    Infotiv Car Rental
    Click Button    xpath://*[@id="cancel"]
    Click Element    xpath://*[@id="title"]

End Web Test
    Close Browser

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

