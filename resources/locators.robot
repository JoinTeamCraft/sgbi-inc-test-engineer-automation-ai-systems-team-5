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

# Header Locators
${HEADER_SECTION}    xpath=//header[contains(@class,'header')]
${FAVORITE_LINK}    xpath=//a[contains(@href,'/favourites')]//button[@aria-label='Favorite Icon']
${ORDERS_LINK}    xpath=//a[contains(@href,'/orders')]//button[@aria-label='Notification Icon']
${USER_SETTINGS_BUTTON}    xpath=//button[@aria-label='User Settings']
${SIGN_IN_BUTTON}    xpath=//div[contains(@class,'user-sign')]

#Car Search Locators
${PICKUP_LOCATION}     xpath=//input[@id='rc_select_1']/ancestor::div[contains(@class, 'ant-select-selector')]
${DROPOFF_LOCATION}    xpath=//input[@id='rc_select_2']/ancestor::div[contains(@class, 'ant-select-selector')]
${PICKUP_DATE}        xpath=(//div[contains(@class,'ant-picker-input')]/input[@placeholder='Select date'])[1]
${DROPOFF_DATE}       xpath=(//div[contains(@class,'ant-picker-input')]/input[@placeholder='Select date'])[2]
${PICKUP_TIME}        xpath=(//div[contains(@class,'ant-picker-input')]/input[@placeholder='Select time'])[1]
${DROPOFF_TIME}       xpath=(//div[contains(@class,'ant-picker-input')]/input[@placeholder='Select time'])[2]
${ERROR_MESSAGE}      xpath=//div[contains(text(),'Pickup Date and Dropoff Date is mandatory')]