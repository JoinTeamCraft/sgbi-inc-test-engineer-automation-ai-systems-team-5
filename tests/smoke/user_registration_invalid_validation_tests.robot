*** Settings ***
Documentation     Automate the verification of invalid input validations on the User Registration (Sign Up) form of the MoRent website.
Resource          ../../resources/keywords.robot
Resource          ../../resources/locators.robot
Test Setup       Open MoRent Application
Test Teardown    Close All Browsers

*** Test Cases ***
SG-5 Verify Invalid Input Validation on Registration Form
    [Documentation]    This test ensures that the application correctly handles invalid user inputs and displays appropriate validation messages without allowing successful registration.
    ...    Launch MoRent application and wait for Home page to load
    ...    Navigate to Registration (Sign Up) page
    ...    Verify Registration page is loaded successfully
    ...    Clear any existing form fields
    ...    Test Invalid Email Validation:
    ...    Submit form with invalid email format
    ...    Verify appropriate email validation message is displayed
    ...    Verify user remains on registration page
    ...    Reload page to reset form state
    ...    Test Invalid Password Validation:
    ...    Submit form with invalid/weak password
    ...    Verify appropriate password validation message is displayed
    ...    Verify user remains on registration page
    ...    Expected Results:
    ...    Registration form is not submitted for any invalid input scenario
    ...    Validation message is displayed for invalid email address format
    ...    Validation message is displayed for invalid password criteria
    ...    User remains on the Registration page after each failed validation attempt

    [Tags]    smoke    user_registration_invalid_validation
    Wait For Page To Load Completely
    Navigate To Registration Page
    Verify Registration Page Loaded
    Clear Registration Form Fields
    Submit Registration Form With Invalid Email
    Verify Email Validation Message Displayed
    Verify User Remains On Registration Page
    Reload Page
    Wait For Page To Load Completely
    Submit Registration Form With Invalid Password
    Verify Password Validation Message Displayed
    Verify User Remains On Registration Page
