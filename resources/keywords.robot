*** Settings ***
Documentation     Template for reusable keywords
Library           SeleniumLibrary
Library           String
Resource          locators.robot
Library           config.env_config.EnvConfig
Library           python_lib.date_utils.DateUtils


*** Keywords ***
# Add your common keywords here
Example Keyword
    [Documentation]    Placeholder for a keyword
    No Operation

Open MoRent Application
    [Documentation]    Open the MoRent application in the browser and maximize the window.
    ${url}=    Get Config Value    BASE_URL
    ${browser}=    Get Config Value    BROWSER
    ${timeout}=    Get Config Value    LONG_TIMEOUT
    Open Browser    ${url}    ${browser}
    Maximize Browser Window

Verify Home Page Loaded Successfully
    [Documentation]    Verify that the Home page of the MoRent application has loaded successfully by checking for key elements.
    Wait For Page To Load Completely
    ${timeout}=    Get Config Value    LONG_TIMEOUT
    Wait Until Element Is Visible    ${HOME_PAGE_LOGO}    ${timeout}
    Wait Until Element Is Visible    ${HOME_PAGE_SEARCH_BAR}    ${timeout}
    Wait Until Element Is Visible    ${HOME_SEARCH_BUTTON}    ${timeout}
    Wait Until Element Is Visible    ${HOME_PAGE_MAIN_CONTAINER}    ${timeout}
    ${screenshot_name}=    Replace String    ${TEST NAME}    ${SPACE}    _
    Capture Page Screenshot    ${screenshot_name}.png

Verify No Browser Error
    [Documentation]    Verify that no browser-level error page (such as 404, 500, or blank page) is displayed after launching the application.
    ${page_not_found_code}=    Get Config Value    PAGE_NOT_FOUND_CODE
    ${server_error_code}=    Get Config Value    SERVER_ERROR_CODE
    ${title}=    Get Title
    Should Not Contain    ${title}    ${page_not_found_code}
    Should Not Contain    ${title}    ${server_error_code}
    Should Not Be Empty    ${title}

Page Should Be Ready
    [Documentation]    Verify that the page has fully loaded by checking the document ready state.
    ${state}=    Execute Javascript    return document.readyState
    Should Be Equal    ${state}    complete

Wait For Page To Load Completely
    [Documentation]    Wait until the page has fully loaded by checking the document ready state.
    ${timeout}=    Get Config Value    MEDIUM_TIMEOUT
    ${retry_count}=    Get Config Value    RETRY_COUNT
    Wait Until Keyword Succeeds    ${retry_count}    ${timeout}    Page Should Be Ready

Verify Header Section Is Visible
    [Documentation]    Verify that the Header section is visible on the Home page.
    Element Should Be Visible    ${HEADER_SECTION}
    ${header_sec}=    Get Config Value    HEADER_SECTION_SCREENSHOT
    ${screenshot_name}=    Replace String    ${TEST NAME}    ${SPACE}    _
    Capture Page Screenshot    ${screenshot_name}_${header_sec}

Verify Application Logo Is Visible
    [Documentation]    Verify that the application logo is visible in the Header section.
    Element Should Be Visible    ${HOME_PAGE_LOGO}

Verify Home Page Search Bar Is Visible
    [Documentation]    Verify that the search bar is visible on the Home page.
    Element Should Be Visible    ${HOME_PAGE_SEARCH_BAR}

Verify Navigation Clickability Of Header Elements
    [Documentation]    Click each navigation item and verify redirection
    ${screenshot_name}=    Replace String    ${TEST NAME}    ${SPACE}    _
    ${fav_screenshot}=    Get Config Value    FAVOURITE_NAVIGATION_SCREENSHOT
    ${orders_screenshot}=    Get Config Value    ORDERS_NAVIGATION_SCREENSHOT
    ${settings_screenshot}=    Get Config Value    SETTINGS_NAVIGATION_SCREENSHOT
    ${sign_in_screenshot}=    Get Config Value    SIGN_IN_NAVIGATION_SCREENSHOT
    ${fav_path}=    Get Config Value    FAVORITES_PATH
    ${orders_path}=    Get Config Value    ORDERS_PATH
    ${sign_text}=    Get Config Value    SIGN_IN_PAGE_TEXT
    ${sign_title}=    Get Config Value    SIGN_IN_PAGE_TITLE

    Verify Navigation Redirection    ${FAVORITE_LINK}    ${EMPTY}    ${fav_path}    ${EMPTY}    ${screenshot_name}_${fav_screenshot}
    Verify Navigation Redirection    ${ORDERS_LINK}      ${EMPTY}    ${orders_path}    ${EMPTY}    ${screenshot_name}_${orders_screenshot}
    Verify Navigation Redirection    ${SIGN_IN_BUTTON}   ${sign_text}    ${EMPTY}    ${sign_title}    ${screenshot_name}_${sign_in_screenshot}
    Verify Navigation Redirection    ${USER_SETTINGS_BUTTON}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${screenshot_name}_${settings_screenshot}

Verify Navigation Redirection
    [Arguments]    ${locator}    ${expected_text}=${EMPTY}    ${expected_url}=${EMPTY}    ${expected_title}=${EMPTY}    ${screenshot_name}=nav.png

    ${timeout}=    Get Config Value    LONG_TIMEOUT
    Wait Until Element Is Visible    ${locator}    ${timeout}
    Wait Until Element Is Enabled    ${locator}    ${timeout}
    Click Element    ${locator}

    # Optional URL validation
    IF    '${expected_url}' != ''
        Wait Until Location Contains    ${expected_url}    ${timeout}
    END

    # Optional Page Text validation
    IF    '${expected_text}' != ''
        Wait Until Page Contains    ${expected_text}    ${timeout}
    END

    # Optional Page Title validation
    IF    '${expected_title}' != ''
        Title Should Be    ${expected_title}
    END
    Capture Page Screenshot    ${screenshot_name}
    Go Back
    Wait For Page To Load Completely

Click Search Button
    [Documentation]    Click the search button on Home page
    ${timeout}=    Get Config Value    MEDIUM_TIMEOUT
    Wait Until Element Is Visible    ${HOME_SEARCH_BUTTON}    ${timeout}
    Wait Until Element Is Enabled    ${HOME_SEARCH_BUTTON}    ${timeout}
    Click Element                    ${HOME_SEARCH_BUTTON}

Verify Mandatory Error Message
    [Documentation]    Verify error is displayed if pickup/dropoff date is missing
    Wait Until Element Is Visible    ${ERROR_MESSAGE}
    Element Should Be Visible        ${ERROR_MESSAGE}

Pickup Location Is Visible
    [Documentation]    Verify that the Pickup Location input field is visible on the Home page.
    Wait Until Element Is Visible    ${PICKUP_LOCATION}
    Element Should Be Visible        ${PICKUP_LOCATION}

Pickup Date Is Visible
    [Documentation]    Verify that the Pickup Date field is visible on the Home page.
    Wait Until Element Is Visible    ${PICKUP_DATE}
    Element Should Be Visible        ${PICKUP_DATE}

Pickup Time Is Visible
    [Documentation]    Verify that the Pickup Time field is visible on the Home page.
    Wait Until Element Is Visible    ${PICKUP_TIME}
    Element Should Be Visible        ${PICKUP_TIME}

Dropoff Location Is Visible
    [Documentation]    Verify that the Dropoff Location input field is visible on the Home page.
    Wait Until Element Is Visible    ${DROPOFF_LOCATION}
    Element Should Be Visible        ${DROPOFF_LOCATION}

Dropoff Date Is Visible
    [Documentation]    Verify that the Dropoff Date field is visible on the Home page.
    Wait Until Element Is Visible    ${DROPOFF_DATE}
    Element Should Be Visible        ${DROPOFF_DATE}

Dropoff Time Is Visible
    [Documentation]    Verify that the Dropoff Time field is visible on the Home page.
    Wait Until Element Is Visible    ${DROPOFF_TIME}
    Element Should Be Visible        ${DROPOFF_TIME}

Select Pickup Location
    [Arguments]    ${location}
    [Documentation]    Open the Pickup dropdown by clicking its wrapper, then click the option directly.
    ${timeout}=    Get Config Value    LONG_TIMEOUT
    Wait Until Element Is Visible    ${PICKUP_LOCATION}    ${timeout}
    Scroll Element Into View    ${PICKUP_LOCATION}
    Click Element    ${PICKUP_LOCATION}
    Sleep    1s
    Wait Until Element Is Visible    xpath=//div[contains(@class,'ant-select-item-option') and @title='${location}']    ${timeout}
    Click Element    xpath=//div[contains(@class,'ant-select-item-option') and @title='${location}']
    Sleep    0.5s

Select Pickup Date
    [Arguments]    ${day}
    [Documentation]    Select a date from the Pickup Date picker (e.g., pass '25' for the 25th).
    ${timeout}=    Get Config Value    SHORT_TIMEOUT
    Wait Until Element Is Visible    ${PICKUP_DATE}    ${timeout}
    Click Element    ${PICKUP_DATE}
    Sleep    1s
    Js Click Element By Xpath    //td[contains(@class,'ant-picker-cell-in-view') and not(contains(@class,'ant-picker-cell-disabled'))]//div[contains(@class,'ant-picker-cell-inner') and text()='${day}']

Select Pickup Time
    [Arguments]    ${hour}
    [Documentation]    Select an hour from the Pickup Time picker. Hour should be e.g. '10', '08'.
    ${timeout}=    Get Config Value    SHORT_TIMEOUT
    Wait Until Element Is Visible    ${PICKUP_TIME}    ${timeout}
    Click Element    ${PICKUP_TIME}
    Sleep    1s
    ${padded}=    Evaluate    str(int('${hour}')).zfill(2)
    Js Click Element By Xpath    //ul[@data-type='hour']//div[contains(@class,'ant-picker-time-panel-cell-inner') and text()='${padded}']
    Sleep    0.5s
    Js Click Element By Xpath    //li[contains(@class,'ant-picker-ok')]/button

Select Dropoff Location
    [Arguments]    ${location}
    [Documentation]    Open the Dropoff dropdown by clicking its wrapper, then JS-click the option.
    ...                JS click is used for the option to handle the portal overlay correctly.
    ${timeout}=    Get Config Value    LONG_TIMEOUT
    Wait Until Element Is Visible    ${DROPOFF_LOCATION}    ${timeout}
    Scroll Element Into View    ${DROPOFF_LOCATION}
    Click Element    ${DROPOFF_LOCATION}
    Sleep    1s
    Js Click Element By Xpath    //div[contains(@class,'ant-select-item-option') and @title='${location}']


Select Dropoff Date
    [Arguments]    ${day}
    [Documentation]    Select a date from the Dropoff Date picker.
    ${timeout}=    Get Config Value    SHORT_TIMEOUT
    Wait Until Element Is Visible    ${DROPOFF_DATE}    ${timeout}
    Scroll Element Into View    ${DROPOFF_DATE}
    Click Element    ${DROPOFF_DATE}
    Sleep    1s
    Js Click Element By Xpath    //td[contains(@class,'ant-picker-cell-in-view') and not(contains(@class,'ant-picker-cell-disabled'))]//div[contains(@class,'ant-picker-cell-inner') and text()='${day}']

Select Dropoff Time
    [Arguments]    ${hour}
    [Documentation]    Select an hour from the Dropoff Time picker. Hour should be e.g. '10', '08'.
    ${timeout}=    Get Config Value    SHORT_TIMEOUT
    Wait Until Element Is Visible    ${DROPOFF_TIME}    ${timeout}
    Scroll Element Into View    ${DROPOFF_TIME}
    Click Element    ${DROPOFF_TIME}
    Sleep    1s
    ${padded}=    Evaluate    str(int('${hour}')).zfill(2)
    Js Click Element By Xpath    //ul[@data-type='hour']//div[contains(@class,'ant-picker-time-panel-cell-inner') and text()='${padded}']
    Sleep    0.5s
    Js Click Element By Xpath    //li[contains(@class,'ant-picker-ok')]/button