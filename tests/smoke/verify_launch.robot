*** Settings ***
Documentation     MoRent Header Task: Event-driven navigation to Registration via Clerk API.
Library           SeleniumLibrary

*** Variables ***
${URL}            https://morent-car.archisacademy.com/
${BROWSER}        chrome
${HEADER_TAG}     tag:header

# Robust locators from your HTML inspection
${LOGO}           xpath://h1[text()='MORENT']
${SIGN_IN_BTN}    xpath://button[@component='SignInButton']
${SIGN_UP_LINK}   link:Sign up

*** Test Cases ***
Verify Header Visibility and Functional Registration Journey
    [Documentation]    Checks header visibility and triggers the sequential Clerk API flow.
    [Setup]            Open MoRent Website

    # STEP 1: Verify Header and Logo visibility on Home Page
    Wait Until Element Is Visible    ${HEADER_TAG}    timeout=10s
    Element Should Be Visible        ${LOGO}          msg=Logo not found!

    # STEP 2: Trigger the Sign-In Modal (Triggers the first API event)
    Wait Until Element Is Visible    ${SIGN_IN_BTN}   timeout=10s
    Click Button                     ${SIGN_IN_BTN}

    # STEP 3: Wait for the Clerk API to load the Sign-In template
    Wait Until Page Contains         Sign in to Morent    timeout=10s

    # STEP 4: Trigger the Sign-Up event inside the modal (Triggers the second API event)
    Wait Until Element Is Visible    ${SIGN_UP_LINK}  timeout=10s
    Click Link                       ${SIGN_UP_LINK}

    # STEP 5: Verify the final Registration state
    Wait Until Page Contains         Create your account  timeout=10s
    Log To Console                   SUCCESS: Reached registration page via API events.

    [Teardown]         Close Browser

*** Keywords ***
Open MoRent Website
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    # Speed is key to allow the API to render components before the next click
    Set Selenium Speed    0.7 seconds