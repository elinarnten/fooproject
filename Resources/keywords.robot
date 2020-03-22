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
