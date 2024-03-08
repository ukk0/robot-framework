*** Settings ***
Documentation    Tests to validate main shopping page scenarios
Resource    ../../resources/ui/keywords.robot
Library    ../../resources/custom_keywords/Checkout.py
Test Setup    Open the browser with the main shop page
Test Teardown    Close Browser

# Testing the usage of custom keywords defined in Checkout.py
*** Test Cases ***
Validate that user can checkout through basket
    Proceed to checkout
    Finish shipping information    FIRST    LAST    12345
    Finish checkout