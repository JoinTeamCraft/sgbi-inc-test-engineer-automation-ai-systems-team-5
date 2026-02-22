*** Settings ***
Documentation     SG-3: Verify Account Page Profile Details (Avatar, Name, Email, Status).
Library           SeleniumLibrary
Library           Dialogs
Library           String

Test Teardown     Run Keyword If Test Failed    Capture Page Screenshot
Suite Teardown    Close Browser

*** Variables ***
${URL}                 https://morent-car.archisacademy.com/
${BROWSER}             chrome

# Test Credentials
${USER_EMAIL}          doe+clerk_test@example.com
${USER_PASS}           morenttest@12345
${OTP_CODE}            424242
${EXPECTED_NAME}       test morent
${EXPECTED_EMAIL}      doe+clerk_test@example.com

# Authentication Locators
${SIGN_IN_BTN}         xpath://button[@component='SignInButton']
${API_EMAIL}           id:identifier-field
${API_PASS}            id:password-field
${CONTINUE_BTN}        xpath://button[@data-localization-key='formButtonPrimary']
${OTP_INPUT}           xpath://input[@inputmode='numeric']

# Navigation
${PROFILE_ICON}        xpath://img[contains(@class,'cl-userButtonAvatarImage')]
${MANAGE_ACC}          xpath://button[normalize-space()='Manage account']

# Profile Page Locators
${ACC_NAME}            xpath://span[contains(@class,'cl-userPreviewMainIdentifierText')]
${ACC_EMAIL}           xpath://p[contains(@class,'cl-internal') and contains(text(),'@')]
${ACC_IMAGE}           xpath://img[contains(@class,'cl-avatarImage')]
${UPDATE_BTN}          xpath://button[contains(.,'Update')]

*** Test Cases ***
SG-3 Verify Account Page Profile Details

    # =========================
    # Step 1: Open Website
    # =========================
    Open MoRent Website

    # =========================
    # Step 2: Login
    # =========================
    Wait Until Element Is Visible    ${SIGN_IN_BTN}    15s
    Click Button    ${SIGN_IN_BTN}
    Pause Execution    Solve CAPTCHA if present and continue.

    Wait Until Element Is Visible    ${API_EMAIL}    15s
    Input Text    ${API_EMAIL}    ${USER_EMAIL}
    Click Element    ${CONTINUE_BTN}

    Wait Until Element Is Visible    ${API_PASS}    15s
    Input Password    ${API_PASS}    ${USER_PASS}
    Click Element    ${CONTINUE_BTN}

    Wait Until Element Is Visible    ${OTP_INPUT}    20s
    Input Text    ${OTP_INPUT}    ${OTP_CODE}

    Wait Until Element Is Visible    ${PROFILE_ICON}    30s

    # =========================
    # Step 3: Navigate to Profile
    # =========================
    Click Element    ${PROFILE_ICON}
    Wait Until Element Is Visible    ${MANAGE_ACC}    15s
    Click Element    ${MANAGE_ACC}

    Wait Until Page Contains    Profile    20s

    # =========================
    # Step 4: Validate Name
    # =========================
    Run Keyword And Continue On Failure    Validate Profile Name

    # =========================
    # Step 5: Validate Email
    # =========================
    Run Keyword And Continue On Failure    Validate Profile Email

    # =========================
    # Step 6: Validate Profile Image
    # =========================
    Run Keyword And Continue On Failure    Validate Profile Image

    # =========================
    # Step 7: Update Button Visible
    # =========================
    Element Should Be Visible    ${UPDATE_BTN}

*** Keywords ***

Open MoRent Website
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Timeout    20s

Validate Profile Name
    Wait Until Element Is Visible    ${ACC_NAME}    20s
    ${actual_name}=    Get Text    ${ACC_NAME}
    ${actual_name}=    Strip String    ${actual_name}
    ${expected_name}=  Strip String    ${EXPECTED_NAME}
    Log    Expected Name: ${expected_name}
    Log    Actual Name: ${actual_name}
    Should Be Equal As Strings    ${actual_name}    ${expected_name}

Validate Profile Email
    Wait Until Element Is Visible    ${ACC_EMAIL}    20s
    ${actual_email}=    Get Text    ${ACC_EMAIL}
    ${actual_email}=    Strip String    ${actual_email}
    ${expected_email}=  Strip String    ${EXPECTED_EMAIL}
    Log    Expected Email: ${expected_email}
    Log    Actual Email: ${actual_email}
    Should Be Equal As Strings    ${actual_email}    ${expected_email}

Validate Profile Image
    Wait Until Element Is Visible    ${ACC_IMAGE}    20s
    Element Should Be Visible    ${ACC_IMAGE}
    ${img_src}=    Get Element Attribute    ${ACC_IMAGE}    src
    Should Not Be Empty    ${img_src}