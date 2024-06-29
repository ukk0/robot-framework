*** Settings ***
Documentation       Tests to validate main shopping page scenarios

Resource            ../resources/ui_keywords.robot

Test Setup          Open the browser with the main shop page
Test Teardown       Close Browser

*** Variables ***
@{expected_items}   Sauce Labs Backpack
...                 Sauce Labs Bike Light
...                 Sauce Labs Bolt T-Shirt
...                 Sauce Labs Fleece Jacket
...                 Sauce Labs Onesie
...                 Test.allTheThings() T-Shirt (Red)

*** Test Cases ***
Validate that all side menu works and all options are available
    Open the shop side menu
    Check that all side menu items are present
    Close the shop side menu

Validate that all expected products are displayed
    ${actual_items} =  List all inventory items
    Compare actual and expected inventory items  ${actual_items}  ${expected_items}

Validate that items can be added to and removed from basket
    Add inventory item to basket  sauce-labs-backpack
    Add inventory item to basket  sauce-labs-bike-light
    Check inventory item count match  2
    Remove inventory item from basket  sauce-labs-backpack
    Check inventory item count match  1

Validate that inventory sorting Z-A works
    ${original_ordering}=  List all inventory items
    Select inventory sorting option  za
    ${current_ordering}=  List all inventory items
    Compare inventory list orders  ${original_ordering}  ${current_ordering}  False
    Reverse List  ${original_ordering}
    Compare inventory list orders  ${original_ordering}  ${current_ordering}  True
