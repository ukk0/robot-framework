*** Settings ***
Documentation    Tests to validate login form
Library    SeleniumLibrary
Test Teardown    Close Browser

*** Test Cases ***
Validate unsuccessful login
    Open the browser with the login form
    Fill the login form with incorrect details
    Wait until login error is displayed
    Verify login error message is correct

*** Variables ***
${test_website}    https://www.saucedemo.com/
${locked_out_user}    locked_out_user
${password}    secret_sauce
${locked_out_login_error}    Sorry, this user has been locked out.

*** Keywords ***
Open the browser with the login form
    Create Webdriver    Chrome
    Go To    ${test_website}

Fill the login form with incorrect details
    Input Text    id:user-name    ${locked_out_user}
    Input Password    id:password    ${password}
    Click Button    id:login-button

Wait until login error is displayed
    Wait Until Element Is Visible    class:error-message-container

Verify login error message is correct
    Wait Until Element Contains    class:error-message-container    ${locked_out_login_error}