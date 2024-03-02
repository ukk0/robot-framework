*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Open the browser with the login form
    [Arguments]    ${test_website_url}
    Create Webdriver    Chrome
    Go To    ${test_website_url}

Fill the login form with details
    [Arguments]    ${username}    ${password}
    Input Text    id:user-name    ${username}
    Input Password    id:password    ${password}
    Click Button    id:login-button

Wait until login error is displayed
    Wait Until Element Is Visible    class:error-message-container

Verify login error message is correct
    [Arguments]    ${error_message}
    Wait Until Element Contains    class:error-message-container    ${error_message}
