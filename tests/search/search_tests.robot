*** Settings ***
Documentation     SG-19: Automate car search form verification on the MoRent Home page.
...               Single browser session covering: field visibility, empty search error,
...               pickup-only search (negative), and full pickup+dropoff search (positive).
Resource          ../../resources/keywords.robot
Resource          ../../resources/locators.robot
Test Teardown     Close All Browsers


*** Test Cases ***

SG-19 Verify Car Search Form And Search Functionality
    [Documentation]    Combined single-browser test covering all SG-19 scenarios:
    ...
    ...                Step 1 - Verify all 6 form fields are visible.
    ...                Step 2 - Click Search with no input → verify mandatory error.
    ...                Step 3 - Enter only Pickup details → verify no dropoff param in URL (negative).
    ...                Step 4 - Go back and enter both Pickup + Dropoff → verify redirect (positive).
    ...
    ...                Expected Results:
    ...                  All 6 fields visible. Error shown on empty search.
    ...                  Pickup-only redirects without dropoff param.
    ...                  Full search redirects to /rental-cars.
    [Tags]    smoke    car_search

    # ── Open application ──────────────────────────────────────────
    Open MoRent Application
    Wait For Page To Load Completely

    # ── Step 1: Verify all 6 search fields are visible ────────────
    Log    STEP 1: Verifying all 6 fields are visible    console=True
    Pickup Location Is Visible
    Pickup Date Is Visible
    Pickup Time Is Visible
    Dropoff Location Is Visible
    Dropoff Date Is Visible
    Dropoff Time Is Visible
    Capture Page Screenshot    step1_all_fields_visible.png

    # ── Step 2: Click Search with no input → mandatory error ───────
    Log    STEP 2: Verifying mandatory error on empty search    console=True
    Click Search Button
    Verify Mandatory Error Message
    Scroll Element Into View    ${ERROR_MESSAGE}
    Capture Page Screenshot    step2_validation_error.png

    # ── Step 3: Negative – only Pickup details, no Dropoff ─────────
    Log    STEP 3: Negative - selecting only Pickup and searching    console=True
    Select Pickup Location    Ernakulam
    Select Pickup Date        25
    Select Pickup Time        10
    Click Search Button
    ${timeout}=    Get Config Value    LONG_TIMEOUT
    Wait Until Location Contains    /rental-cars    ${timeout}
    ${url}=    Get Location
    Should Not Contain    ${url}    dropoff
    Capture Page Screenshot    step3_pickup_only_search.png

    # ── Step 4: Positive – both Pickup + Dropoff, full search ──────
    Log    STEP 4: Positive - full search with Pickup and Dropoff    console=True
    ${url}=    Get Config Value    BASE_URL
    Go To    ${url}
    Wait For Page To Load Completely
    Select Pickup Location    Ernakulam
    Select Pickup Date        25
    Select Pickup Time        10
    Select Dropoff Location   Trivandrum
    Select Dropoff Date       28
    Select Dropoff Time       10
    Capture Page Screenshot    step4_before_search.png
    Click Search Button
    Wait Until Location Contains    /rental-cars    ${timeout}
    Location Should Contain    /rental-cars
    Capture Page Screenshot    step4_results_page.png
