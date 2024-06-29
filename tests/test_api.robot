*** Settings ***
Documentation       Tests to check Restful booker API functionality

Resource            ../resources/api_keywords.robot

*** Variables ***
${base_url}         https://restful-booker.herokuapp.com

*** Test Cases ***
Validate a new booking can be created with a valid payload
    ${payload} =  Create new booking payload  FIRST  LAST  100  True
    ${response} =  POST  ${base_url}/booking  json=${payload}  expected_status=200
    ${response_json} =  Convert response body to json  ${response}
    Compare request body to response body  ${response_json}  FIRST  LAST  100  True
    Log  ${response_json}[bookingid]

Validate a new booking creation will fail with an invalid payload
    ${payload} =  Create Dictionary  insufficient_body=True
    ${response} =  POST  ${base_url}/booking  json=${payload}  expected_status=500

Validate an existing booking can be deleted
    ${existing_bookings} =  Find existing bookings by first and last name  Jim  Brown
    @{booking_list} =  Convert To List  ${existing_bookings}
    ${auth_headers} =  Create headers with basic authorization
    ${response} =  DELETE
    ...  ${base_url}/booking/${booking_list}[0][bookingid]
    ...  headers=${auth_headers}
    ...  expected_status=201
