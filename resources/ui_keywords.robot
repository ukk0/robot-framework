*** Settings ***
Library     SeleniumLibrary
Library     Collections

*** Keywords ***
Open the browser with the login form
    Create Webdriver  Chrome
    Go To  https://www.saucedemo.com/

Fill the login form with details
    [Arguments]  ${username}  ${password}
    Input Text  id:user-name  ${username}
    Input Password  id:password  ${password}
    Click Button  id:login-button

Wait until login error is displayed
    Wait Until Element Is Visible  class:error-message-container

Verify login error message is correct
    [Arguments]  ${error_message}
    Wait Until Element Contains  class:error-message-container  ${error_message}

Open the browser with the main shop page
    Create Webdriver  Chrome
    Go To  https://www.saucedemo.com/
    Add Cookie  session-username  standard_user  domain=www.saucedemo.com  path=/
    Go To  https://www.saucedemo.com/inventory.html

Open the shop side menu
    Click Button  id:react-burger-menu-btn
    Wait Until Element Is Visible  class:bm-menu-wrap

Close the shop side menu
    Click Button  id:react-burger-cross-btn
    Wait Until Element Is Not Visible  class:bm-menu-wrap

Check that all side menu items are present
    Wait Until Element Is Visible  class:bm-item-list
    Element Should Be Visible  id:inventory_sidebar_link
    Element Should Be Visible  id:about_sidebar_link
    Element Should Be Visible  id:logout_sidebar_link
    Element Should Be Visible  id:reset_sidebar_link

List all inventory items
    ${elements} =  Get WebElements  class:inventory_item_name
    @{all_items} =  Create List
    FOR  ${item}  IN  @{elements}
        Append To List  ${all_items}  ${item.text}
    END
    RETURN  @{all_items}

Compare actual and expected inventory items
    [Arguments]  @{args}
    [Documentation]  test

    List Should Contain Sub List  ${args[0]}  ${args[1]}

Add inventory item to basket
    [Arguments]  ${item}

    ${locator} =  Set Variable  css:[data-test=add-to-cart-${item}]
    Click Button  ${locator}

Remove inventory item from basket
    [Arguments]  ${item}

    ${locator} =  Set Variable  css:[data-test=remove-${item}]
    Click Button  ${locator}

Check inventory item count match
    [Arguments]  ${expected_count}

    ${count_of_items} =  Get Text  class:shopping_cart_badge
    Should Be Equal  ${count_of_items}  ${expected_count}

Select inventory sorting option
    [Arguments]  ${sort_option}

    Select From List By Value  class:product_sort_container  ${sort_option}

Compare inventory list orders
    [Arguments]  ${original_ordering}  ${current_ordering}  ${should_equal}

    IF  ${should_equal} == True
        Lists Should Be Equal  ${original_ordering}  ${current_ordering}
    ELSE
        Should Not Be Equal  ${original_ordering}  ${current_ordering}
    END
