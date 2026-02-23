from robot.api.deco import library, keyword
from SeleniumLibrary import SeleniumLibrary
from robot.libraries.BuiltIn import BuiltIn
from selenium.webdriver.common.action_chains import ActionChains
from selenium.common.exceptions import (
    NoSuchElementException,
    ElementNotInteractableException,
    ElementClickInterceptedException,
    StaleElementReferenceException,
)
from datetime import datetime, timedelta
import time


@library
class DateUtils:
    """
    Utility library for date/time handling and for interacting with
    Ant Design (React) date/time/location picker components via JavaScript.
    """

    @keyword
    def get_future_date(self, days_ahead=7):
        """Returns a future date string in YYYY-MM-DD format."""
        future = datetime.now() + timedelta(days=days_ahead)
        return future.strftime("%Y-%m-%d")

    @keyword
    def get_future_day(self, days_ahead=7):
        """Returns just the day number of a future date as a string (e.g. '26')."""
        future = datetime.now() + timedelta(days=days_ahead)
        return str(future.day)

    # --- Selenium / React component helpers ---

    def __init__(self):
        self._sel_lib = None

    @property
    def selenium_lib(self) -> SeleniumLibrary:
        if self._sel_lib is None:
            self._sel_lib = BuiltIn().get_library_instance('SeleniumLibrary')
        return self._sel_lib

    @keyword
    def action_click_element_by_xpath(self, xpath):
        """Clicks an element using Selenium ActionChains to properly trigger
        React synthetic events. Use this for dropdown trigger elements where
        JS click doesn't register the correct React component focus."""
        driver = self.selenium_lib.driver
        for attempt in range(10):
            try:
                element = driver.find_element("xpath", xpath)
                driver.execute_script(
                    "arguments[0].scrollIntoView({block: 'center'});", element
                )
                time.sleep(0.2)
                actions = ActionChains(driver)
                actions.move_to_element(element).click().perform()
                return True
            except (NoSuchElementException, ElementNotInteractableException,
                    ElementClickInterceptedException, StaleElementReferenceException):
                time.sleep(0.5)
        raise Exception(
            f"Failed to action-click element with xpath: {xpath}"
        )

    @keyword
    def js_click_element_by_xpath(self, xpath):
        """Clicks an element via JavaScript for the given XPath, bypassing
        Selenium visibility restrictions caused by React portal overlays.
        Retries up to 10 times with 0.5s delay between attempts."""
        driver = self.selenium_lib.driver
        for attempt in range(10):
            try:
                element = driver.find_element("xpath", xpath)
                driver.execute_script(
                    "arguments[0].scrollIntoView({block: 'center'});", element
                )
                time.sleep(0.2)

                # Try standard click first
                try:
                    element.click()
                    return True
                except Exception:
                    pass

                # Try ActionChain click
                try:
                    actions = ActionChains(driver)
                    actions.move_to_element(element).click().perform()
                    return True
                except Exception:
                    pass

                # Fallback: pure JS click
                driver.execute_script("arguments[0].click();", element)
                return True
            except (NoSuchElementException, ElementNotInteractableException,
                    ElementClickInterceptedException, StaleElementReferenceException):
                time.sleep(0.5)

        raise Exception(
            f"Failed to find or click element with xpath: {xpath}"
        )
