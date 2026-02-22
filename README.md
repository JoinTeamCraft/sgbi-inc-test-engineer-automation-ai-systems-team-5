# MoRent Automation - Test Engineer Assessment

## Project Overview
This project contains automated smoke tests for the **MoRent** car rental platform. The current focus is on verifying the landing page header visibility and the functional navigation flow for user registration.

## Tools Used
* **Robot Framework:** Core automation framework.
* **SeleniumLibrary:** For web browser interaction.
* **Python:** Underlying programming language.
* **Chrome Browser:** Target testing environment.

## Project Setup Steps
1. **Clone the repository:** `git clone <your-fork-url>`
2. **Install dependencies:**
   `pip install robotframework seleniumlibrary`
3. **Webdriver:** Ensure the Chrome browser is installed. The `webdriver-manager` or a compatible `chromedriver` should be in your system path.

## How to Run Tests
To execute the smoke tests, run the following command from the project root:
```bash
robot tests/smoke/verify_launch.robot