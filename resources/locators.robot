*** Settings ***
Documentation     Template for common locators
Library           SeleniumLibrary

*** Variables ***
# Add your application locators here
# ${EXAMPLE_LOCATOR}    id=example

# Home Page Locators
${HOME_SEARCH_BUTTON}    xpath=//button/span[text()='Search']
${HOME_PAGE_LOGO}    xpath=//a/span[text()='MORENT']
${HOME_PAGE_MAIN_CONTAINER}    xpath=//main[contains(@class,'container')]
${HOME_PAGE_SEARCH_BAR}    xpath=//input[@type='search' and @placeholder='Search something here']

${URL}        https://ethical-lizard-51.accounts.dev/sign-in?redirect_url=https%3A%2F%2Fmorent-car.archisacademy.com%2F
${BROWSER}    chrome
${USERNAME}   doe+clerk_test@example.com
${INVALIDUSERNAME}   doe#%@example.com
${PASSWORD}   morenttest@12345
${INVALIDPASSWORD}   @12345
${OTP}      424242
${WELCOMENOTE}      Welcome, test
${INVALIDEMAILID}       Couldn't find your account.


${txtEmailId}      //input[@name='identifier']
${btnContinueemail}     //button[@class='cl-formButtonPrimary cl-button 🔒️ cl-internal-1awoyig']
${txtPass}     //input[@name='password']
${btnPassContinue}      //button[@class='cl-formButtonPrimary cl-button 🔒️ cl-internal-1awoyig']
${txtOtp}       //input[@aria-label='Enter verification code']
${btnotpContinue}       //button[@class='cl-formButtonPrimary cl-button 🔒️ cl-internal-1awoyig']
${txtWelcome}       //h1[contains(text(),'Welcome, test')]
${invalidEmailIdErrorMsg}       //p[@id='error-identifier']
${signOutIcon}      //button[@class='cl-userButtonTrigger cl-button cl-open 🔒️ cl-internal-bth0nk']
${signout}      //button[@class='cl-userButtonPopoverActionButton cl-button cl-userButtonPopoverActionButton__signOut cl-button__signOut 🔒️ cl-internal-1irytfv']