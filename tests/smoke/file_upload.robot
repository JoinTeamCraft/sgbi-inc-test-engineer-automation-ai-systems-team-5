*** Settings ***
Documentation     SG-4: Verify Profile Image Upload, Modal Options, and Persistence.
Library           SeleniumLibrary
Library           String
Library           Dialogs

Test Teardown     Run Keyword If Test Failed    Capture Page Screenshot
Suite Teardown    Close Browser

*** Variables ***
${URL}                 https://morent-car.archisacademy.com/
${BROWSER}             chrome

# Credentials
${USER_EMAIL}          doe+clerk_test@example.com
${USER_PASS}           morenttest@12345
${OTP_CODE}            424242

# Local System Path (Updated based on your input)
${IMAGE_PATH}          C:/Users/ASUS/Downloads/test.jpeg

# Locators
${SIGN_IN_BTN}         xpath://button[@component='SignInButton']
${API_EMAIL}           id:identifier-field
${API_PASS}            id:password-field
${CONTINUE_BTN}        xpath://button[@data-localization-key='formButtonPrimary']
${OTP_INPUT}           xpath://input[@inputmode='numeric']

# Navigation & Modal
${HEADER_ICON}         xpath://img[contains(@class,'cl-userButtonAvatarImage')]
${MANAGE_ACC}          xpath://button[normalize-space()='Manage account']
${UPDATE_BTN}          xpath://button[contains(.,'Update')]
${MODAL_IMAGE}         xpath://img[contains(@class,'cl-avatarImage')]

# Your provided XPath converted to a stable relative locator
${UPLOAD_BTN}          xpath://button[normalize-space()='Upload']
${REMOVE_BTN}          xpath://button[normalize-space()='Remove']
${FILE_INPUT}          xpath://input[@type='file']
${SAVE_BTN}            xpath://button[normalize-space()='Save']

*** Test Cases ***
SG-4 Verify File Upload and Modal Options
    [Setup]    Open MoRent Website

    # 1. Login Flow
    Wait Until Element Is Visible    ${SIGN_IN_BTN}    15s
    Click Element    ${SIGN_IN_BTN}
    Pause Execution    Solve CAPTCHA and wait for the email field to appear.

    Input Text    ${API_EMAIL}    ${USER_EMAIL}
    Click Element    ${CONTINUE_BTN}
    Wait Until Element Is Visible    ${API_PASS}    15s
    Input Password    ${API_PASS}    ${USER_PASS}
    Click Element    ${CONTINUE_BTN}
    Wait Until Element Is Visible    ${OTP_INPUT}    20s
    Input Text    ${OTP_INPUT}    ${OTP_CODE}

    # 2. Navigate to Update Modal
    Wait Until Element Is Visible    ${HEADER_ICON}    30s
    Click Element    ${HEADER_ICON}
    Wait Until Element Is Visible    ${MANAGE_ACC}     15s
    Click Element    ${MANAGE_ACC}
    Wait Until Element Is Visible    ${UPDATE_BTN}     20s
    Click Element    ${UPDATE_BTN}

    # 3. Requirement: Verify Modal Options
    Wait Until Element Is Visible    ${MODAL_IMAGE}    15s
    Element Should Be Visible        ${UPLOAD_BTN}     msg=Upload option is missing
    Element Should Be Visible        ${REMOVE_BTN}     msg=Remove option is missing
    ${old_src}=    Get Element Attribute    ${MODAL_IMAGE}    src

    # 4. Requirement: Upload Profile Picture
    # We target the hidden file input directly to trigger the system upload
    Choose File    ${FILE_INPUT}    ${IMAGE_PATH}

    # Click Save
    Wait Until Element Is Enabled    ${SAVE_BTN}    10s    msg=Save button did not enable after upload
    Click Element    ${SAVE_BTN}

    # 5. Requirement: Verify Update Persistence
    Wait Until Element Attribute Does Not Contain    ${MODAL_IMAGE}    src    ${old_src}    timeout=15s
    Press Keys    None    ESC
    Wait Until Element Is Visible    ${HEADER_ICON}    15s
    Click Element    ${HEADER_ICON}
    ${header_src}=    Get Element Attribute    ${HEADER_ICON}    src
    Should Not Be Equal    ${old_src}    ${header_src}    msg=Header image failed to update

*** Keywords ***
Open MoRent Website
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    0.3 seconds