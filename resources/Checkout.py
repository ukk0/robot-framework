from robot.api.deco import keyword, library
from robot.libraries.BuiltIn import BuiltIn


# Testing the creation of custom keywords in Python
@library
class Checkout:
    def __init__(self):
        self.sel_lib = BuiltIn().get_library_instance("SeleniumLibrary")

    @keyword
    def proceed_to_checkout(self):
        self.sel_lib.click_element("id:shopping_cart_container")
        self.sel_lib.click_button("id:checkout")

    @keyword
    def finish_shipping_information(self, first_name: str, last_name: str, zip_code: int):
        self.sel_lib.input_text("id:first-name", first_name)
        self.sel_lib.input_text("id:last-name", last_name)
        self.sel_lib.input_text("id:postal-code", zip_code)
        self.sel_lib.click_button("id:continue")

    @keyword
    def finish_checkout(self):
        self.sel_lib.click_button("id:finish")
        self.sel_lib.wait_until_element_is_visible("class:complete-header")
