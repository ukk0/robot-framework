*** Settings ***
Documentation    Tests to validate main shopping page scenarios
Resource    ../resources/ui_keywords.robot
Library    ../resources/Checkout.py
Test Setup    Open the browser with the main shop page
Test Teardown    Close Browser

*** Test Cases ***
Validate that user can checkout through basket
    Proceed to checkout
    Finish shipping information    FIRST    LAST    12345
    Finish checkout