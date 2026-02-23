*** Settings ***
Documentation     This test ensures that a new user can register successfully when all required fields are filled with valid data and that the application displays correct UI-level success behavior.
...    The test is designed to be fully automatable and repeatable.
Resource          ../../resources/keywords.robot
Resource          ../../resources/locators.robot
Test Setup       Open MoRent Application
Test Teardown    Close All Browsers

*** Test Cases ***
SG-6 Verify Successful User Registration
    [Documentation]    This test ensures that a new user can register successfully when all required fields are filled with valid data and that the application displays correct UI-level success behavior.
    ...    The test is designed to be fully automatable and repeatable.
    ...    Launch MoRent application and wait for the Home page to load completely.
    ...    Navigate to the Registration (Sign Up) page from Sign In page.
    ...    Verify that the Registration page is displayed.
    ...    Clear any existing values in the registration form fields to ensure a clean state.
    ...    Enter valid First Name and Last Name.
    ...    Enter a valid Email address.
    ...    Enter a valid Password that meets application criteria.
    ...    Click the Continue/Submit button.
    ...    Complete OTP verification manually.
    ...    Wait for the registration process to complete.
    ...    Expected Results:
    ...    Registration form should be submitted successfully.
    ...    No validation or error messages should be displayed.
    ...    A success or confirmation indicator should be visible.
    ...    User should be redirected to Login page or Home page.
    ...    Test should be repeatable without data conflicts.    

    [Tags]    smoke    successful_user_registration
    Wait For Page To Load Completely
    Navigate To Registration Page
    Verify Registration Page Loaded
    Clear Registration Form Fields
    Submit Registration Form With Valid Data
    Verify OTP verification Page Is Displayed
    # OTP step handled manually
    Wait For Registration Success Indicator
    Verify No Validation Errors Displayed
    Verify User Redirected After Successful Registration
    