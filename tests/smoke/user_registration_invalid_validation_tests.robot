*** Settings ***
Documentation     Automate the verification of invalid input validations on the User Registration (Sign Up) form of the MoRent website.
Resource          ../../resources/keywords.robot
Resource          ../../resources/locators.robot
Test Setup       Open MoRent Application
Test Teardown    Close All Browsers

*** Test Cases ***
SG-5 Verify Invalid Input Validation on Registration Form - Invalid Email
    [Documentation]    Automate the verification of invalid input validations on the User Registration (Sign Up) form of the MoRent website.
    ...    This test ensures that the application correctly handles invalid user inputs and displays appropriate validation messages without allowing successful registration.
    ...    Launch MoRent application and wait for the Home page to load.
    ...    Navigate to the Registration (Sign Up) page.
    ...    Verify that the Registration page is displayed.
    ...    Clear any existing values in the registration form fields.
    ...    Enter valid First Name and Last Name.
    ...    Enter an invalid email format.
    ...    Enter a valid password.
    ...    Click the Continue/Submit button.
    ...    Expected Results:
    ...    Registration form should not be submitted.
    ...    Appropriate validation message should be displayed for invalid email format.
    ...    User should remain on the Registration page.

    [Tags]    smoke    user_registration_invalid_validation
    Wait For Page To Load Completely
    Navigate To Registration Page
    Verify Registration Page Loaded
    Clear Registration Form Fields
    Submit Registration Form With Invalid Email
    Verify Email Validation Message Displayed
    Verify User Remains On Registration Page

SG-5 Verify Invalid Input Validation on Registration Form - Invalid Password
    [Documentation] 
    ...    Launch MoRent application and wait for the Home page to load.
    ...    Navigate to the Registration (Sign Up) page.
    ...    Verify that the Registration page is displayed.
    ...    Clear any existing values in the registration form fields.
    ...    Enter valid First Name, Last Name, and Email.
    ...    Enter an invalid or weak password.
    ...    Click the Continue/Submit button.
    ...    Expected Results:
    ...    Registration form should not be submitted.
    ...    Appropriate validation message should be displayed for invalid password criteria.
    ...    User should remain on the Registration page.

    [Tags]    smoke    user_registration_invalid_validation

    Wait For Page To Load Completely
    Navigate To Registration Page
    Verify Registration Page Loaded
    Clear Registration Form Fields
    Submit Registration Form With Invalid Password
    Verify Password Validation Message Displayed
    Verify User Remains On Registration Page
