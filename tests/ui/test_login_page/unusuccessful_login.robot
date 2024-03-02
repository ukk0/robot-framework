*** Settings ***
Documentation    Tests to validate unsuccessful login scenarios
Resource    ../../../resources/ui/variables.robot
Resource    ../../../resources/ui/keywords.robot
Test Teardown    Close Browser

*** Test Cases ***
Validate unsuccessful login with locked out user
    Open the browser with the login form    ${test_website_url}
    Fill the login form with details    ${locked_out_user}    ${correct_password}
    Wait until login error is displayed
    Verify login error message is correct    ${locked_out_login_error}

Validate unsuccessful login with incorrect password
    Open the browser with the login form    ${test_website_url}
    Fill the login form with details    ${successful_login_user}    ${incorrect_password}
    Wait until login error is displayed
    Verify login error message is correct    ${wrong_pw_login_error}
