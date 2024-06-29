*** Settings ***
Documentation  Tests to validate unsuccessful and successful login scenarios
Resource       ../resources/ui_keywords.robot

Test Setup     Open the browser with the login form
Test Teardown  Close Browser

*** Variables ***
${test_website_inventory_url}    https://www.saucedemo.com/inventory.html
${successful_login_user}    standard_user
${locked_out_user}    locked_out_user
${correct_password}    secret_sauce
${incorrect_password}    wrong_password
${locked_out_login_error}    Sorry, this user has been locked out.
${wrong_pw_login_error}     Username and password do not match any user in this service

*** Test Cases ***
Validate unsuccessful login with locked out user
    Fill the login form with details    ${locked_out_user}    ${correct_password}
    Wait until login error is displayed
    Verify login error message is correct    ${locked_out_login_error}

Validate unsuccessful login with incorrect password
    Fill the login form with details    ${successful_login_user}    ${incorrect_password}
    Wait until login error is displayed
    Verify login error message is correct    ${wrong_pw_login_error}

Validate successful login with correct credentials
    Fill the login form with details    ${successful_login_user}    ${correct_password}
    Wait Until Location Is    ${test_website_inventory_url}