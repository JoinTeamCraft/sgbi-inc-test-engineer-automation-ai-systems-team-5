*** Settings ***
Documentation     Template for reusable keywords
Library           SeleniumLibrary
Library           String
Resource          locators.robot
Library    config.env_config.EnvConfig

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

Navigate To Registration Page
    [Documentation]    Click on the Register / Sign Up link in the Sign In page to navigate to the Registration page.
    ${timeout}=    Get Config Value    LONG_TIMEOUT
    Click Element    ${SIGNIN_BUTTON}
    Wait For Page To Load Completely
    Wait Until Page Contains Element    ${SIGNUP_LINK}    ${timeout}
    ${sign_in_page}=    Get Config Value    SIGN_IN_NAVIGATION_SCREENSHOT
    ${screenshot_name}=    Replace String    ${TEST NAME}    ${SPACE}    _
    Capture Page Screenshot    ${screenshot_name}_${sign_in_page}
    Click Element    ${SIGNUP_LINK}
    Wait For Page To Load Completely

Verify Registration Page Loaded
    [Documentation]    Verify that the Registration page has loaded successfully by checking for the presence of the Registration form and expected text.
    ${timeout}=    Get Config Value    LONG_TIMEOUT
    ${sign_up_text}=    Get Config Value    SIGN_UP_PAGE_TEXT
    Wait Until Page Contains Element    ${REGISTRATION_FORM}    ${timeout}
    Wait Until Page Contains    ${sign_up_text}    ${timeout}
    ${sign_up_page}=    Get Config Value    SIGN_UP_PAGE_SCREENSHOT
    ${screenshot_name}=    Replace String    ${TEST NAME}    ${SPACE}    _
    Capture Page Screenshot    ${screenshot_name}_${sign_up_page}

Verify Registration Form Fields Presence
    [Documentation]    Verify that all required input fields and the continue button are present and visible on the Registration page.
    Element Should Be Visible    ${REGISTRATION_FIRST_NAME_FIELD}
    Element Should Be Visible    ${REGISTRATION_LAST_NAME_FIELD}
    Element Should Be Visible    ${REGISTRATION_EMAIL_FIELD}
    Element Should Be Visible    ${REGISTRATION_PASSWORD_FIELD}
    Element Should Be Visible    ${REGISTRATION_CONTINUE_BUTTON}

Verify Mandatory Field Validation Messages
    [Documentation]    Verify validation messages when required fields are empty and ensure that the user cannot proceed to the next step.
    
    ${timeout}=    Get Config Value    LONG_TIMEOUT
    # Click Continue without entering data
    Click Element    ${REGISTRATION_CONTINUE_BUTTON}

    # Validate for Email address and Password fields for mandatory check    
    ${email_validation}=    Get Element Attribute    ${REGISTRATION_EMAIL_FIELD}    validationMessage
    Should Not Be Empty    ${email_validation}
    ${password_validation}=    Get Element Attribute    ${REGISTRATION_PASSWORD_FIELD}    validationMessage
    Should Not Be Empty    ${password_validation}

    # Ensure user stays on Registration page
    Wait Until Element Is Visible    ${REGISTRATION_FORM}    ${timeout}
    ${sign_up_page_mandatory}=    Get Config Value    SIGN_UP_PAGE_MANDATORY_VALIDATION_SCREENSHOT
    ${screenshot_name}=    Replace String    ${TEST NAME}    ${SPACE}    _
    Capture Page Screenshot    ${screenshot_name}_${sign_up_page_mandatory}

Clear Registration Form Fields
    [Documentation]    Clear all input fields on the Registration form to ensure they are empty before validation.
    Clear Element Text    ${REGISTRATION_FIRST_NAME_FIELD}
    Clear Element Text    ${REGISTRATION_LAST_NAME_FIELD}
    Clear Element Text    ${REGISTRATION_EMAIL_FIELD}
    Clear Element Text    ${REGISTRATION_PASSWORD_FIELD}

Generate Dynamic Valid Email
    [Documentation]    Generate a dynamic valid email address using a random string and a predefined domain.
    ${email_domain}=    Get Config Value    VALID_EMAIL_DOMAIN
    ${rand}=    Generate Random String    4    [LETTERS]
    ${email}=    Set Variable    ${rand.lower()}${email_domain}
    RETURN    ${email}

Verify Email Validation Message Displayed
    [Documentation]    Verify that the appropriate validation message is displayed when an invalid email format is submitted in the Registration form.
    ${email_validation}=    Get Element Attribute    ${REGISTRATION_EMAIL_FIELD}    validationMessage
    Should Not Be Empty    ${email_validation}
    ${sign_up_invalid_email}=    Get Config Value    SIGN_UP_PAGE_INVALID_EMAIL_SCREENSHOT
    ${screenshot_name}=    Replace String    ${TEST NAME}    ${SPACE}    _
    Capture Page Screenshot    ${screenshot_name}_${sign_up_invalid_email}

Verify Password Validation Message Displayed
    [Documentation]    Verify that the appropriate validation message is displayed when an invalid password format is submitted in the Registration form.
    ${timeout}=    Get Config Value    LONG_TIMEOUT
    ${expected_message}=    Get Config Value    PASSWORD_MIN_LENGTH_MESSAGE
    Wait Until Element Is Visible    ${PASSWORD_ERROR_MESSAGE_LOCATOR}    ${timeout}
    ${password_error}=    Get Text    ${PASSWORD_ERROR_MESSAGE_LOCATOR}
    Log    ${password_error}
    Should Be Equal    ${password_error}    ${expected_message}
    ${sign_up_invalid_password}=    Get Config Value    SIGN_UP_PAGE_INVALID_PASSWORD_SCREENSHOT
    ${screenshot_name}=    Replace String    ${TEST NAME}    ${SPACE}    _
    Capture Page Screenshot    ${screenshot_name}_${sign_up_invalid_password}

Verify User Remains On Registration Page
    [Documentation]    Verify that the user remains on the Registration page after attempting to submit invalid data by checking for the presence of the Registration form.
    ${timeout}=    Get Config Value    LONG_TIMEOUT
    Wait Until Element Is Visible    ${REGISTRATION_FORM}    ${timeout}
    ${sign_up_text}=    Get Config Value    SIGN_UP_PAGE_TEXT
    Wait Until Page Contains    ${sign_up_text}    ${timeout}

Fill And Submit Registration Form
    [Documentation]    Fill in the Registration form with provided details and submit it by clicking the Continue button.]
    [Arguments]    ${first_name}    ${last_name}    ${email}    ${password}
    ${retry_count}=    Get Config Value    RETRY_COUNT
    ${time_out}=    Get Config Value    MEDIUM_TIMEOUT
    Wait Until Keyword Succeeds    ${retry_count}    ${time_out}    Input Text    ${REGISTRATION_FIRSTNAME_FIELD}    ${first_name}
    Wait Until Keyword Succeeds    ${retry_count}    ${time_out}    Input Text    ${REGISTRATION_LASTNAME_FIELD}     ${last_name}
    Wait Until Keyword Succeeds    ${retry_count}    ${time_out}    Input Text    ${REGISTRATION_EMAIL_FIELD}        ${email}
    Wait Until Keyword Succeeds    ${retry_count}    ${time_out}    Input Text    ${REGISTRATION_PASSWORD_FIELD}     ${password}
    Click Element    ${REGISTRATION_CONTINUE_BUTTON}

Submit Registration Form With Invalid Email
    [Documentation]    Submit registration with invalid email and verify validation is triggered.

    ${first_name}=        Get Config Value    VALID_FIRST_NAME
    ${last_name}=         Get Config Value    VALID_LAST_NAME
    ${invalid_email}=     Get Config Value    INVALID_EMAIL
    ${valid_password}=    Get Config Value    VALID_PASSWORD

    Fill And Submit Registration Form
    ...    ${first_name}
    ...    ${last_name}
    ...    ${invalid_email}
    ...    ${valid_password}

Submit Registration Form With Invalid Password
    [Documentation]    Submit registration with invalid password and verify validation is triggered.

    ${first_name}=          Get Config Value    VALID_FIRST_NAME
    ${last_name}=           Get Config Value    VALID_LAST_NAME
    ${valid_email}=         Generate Dynamic Valid Email
    ${invalid_password}=    Get Config Value    INVALID_PASSWORD

    Fill And Submit Registration Form
    ...    ${first_name}
    ...    ${last_name}
    ...    ${valid_email}
    ...    ${invalid_password}
