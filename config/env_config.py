import os

class EnvConfig:
    """
    Template for environment configuration.
    """
    
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    # Application Config
    BASE_URL = "https://morent-car.archisacademy.com/"
    BROWSER = "chrome"
    SHORT_TIMEOUT = 5
    MEDIUM_TIMEOUT = 15
    LONG_TIMEOUT = 20
    RETRY_COUNT = "3x"

    # Test Data
    PAGE_NOT_FOUND_CODE = "404"
    SERVER_ERROR_CODE = "500"
    SIGN_IN_PAGE_TEXT = "Sign in to Morent"
    HEADER_SECTION_SCREENSHOT = "Header_Section.png"
    FAVOURITE_NAVIGATION_SCREENSHOT = "Favourite_Navigation.png"
    ORDERS_NAVIGATION_SCREENSHOT = "Orders_Navigation.png"
    SETTINGS_NAVIGATION_SCREENSHOT = "Settings_Navigation.png"
    SIGN_IN_NAVIGATION_SCREENSHOT = "Sign_In_Navigation.png"
    SIGN_UP_PAGE_TEXT = "Create your account"
    SIGN_UP_PAGE_SCREENSHOT = "Sign_Up_Page.png"
    SIGN_UP_PAGE_MANDATORY_VALIDATION_SCREENSHOT = "Sign_Up_Page_Mandatory_Validation.png"
    VALID_FIRST_NAME = "John"
    VALID_LAST_NAME = "Doe"
    VALID_EMAIL_DOMAIN = "@example.com"
    INVALID_EMAIL = "user@domain"
    INVALID_PASSWORD = "123"
    PASSWORD_MIN_LENGTH_MESSAGE = "Your password must contain 8 or more characters."
    SIGN_UP_PAGE_INVALID_EMAIL_SCREENSHOT = "Sign_Up_Page_Invalid_Email.png"
    SIGN_UP_PAGE_INVALID_PASSWORD_SCREENSHOT = "Sign_Up_Page_Invalid_Password.png"

    # Navigation Config
    FAVORITES_PATH = "favourites"
    ORDERS_PATH = "orders"
    SIGN_IN_PAGE_TITLE = "My account | Morent"

    #Environment Variables
    VALID_PASSWORD = os.getenv("AUTO_PASSWORD", "DummyPassword@123")
    
    def get_config_value(self, key):
        """Placeholder for config retrieval."""
        return getattr(self, key)
