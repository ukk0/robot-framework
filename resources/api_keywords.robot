*** Settings ***
Library     RequestsLibrary
Library     Collections

*** Variables ***
${base_url}         https://restful-booker.herokuapp.com
${authorization}    Basic YWRtaW46cGFzc3dvcmQxMjM=

*** Keywords ***
Create new booking payload
    [Arguments]  ${first_name}  ${last_name}  ${total_price}  ${deposit_paid}
    ${dates_dict}=  Create Dictionary  checkin=2024-01-01  checkout=2024-02-01
    ${booking_dict}=  Create Dictionary
    ...  firstname=${first_name}
    ...  lastname=${last_name}
    ...  totalprice=${total_price}
    ...  depositpaid=${deposit_paid}
    ...  bookingdates=${dates_dict}
    ...  additionalneeds=None
    RETURN  ${booking_dict}

Convert response body to json
    [Arguments]  ${response}
    ${response_json}=  Evaluate  json.loads('''${response.content}''')
    RETURN  ${response_json}

Compare request body to response body
    [Arguments]  ${response}  ${req_first_name}  ${req_last_name}  ${req_price}  ${req_deposit_status}
    Should Be Equal  ${response}[booking][firstname]  ${req_first_name}
    Should Be Equal  ${response}[booking][lastname]  ${req_last_name}
    Should Be Equal As Integers  ${response}[booking][totalprice]  ${req_price}
    IF  ${req_deposit_status} == True
        Should Be True  ${response}[booking][depositpaid]
    ELSE
        Should Not Be True  ${response}[booking][depositpaid]
    END

Find existing bookings by first and last name
    [Arguments]  ${first_name}  ${last_name}
    ${query_params}=  Create Dictionary  firstname=${first_name}  lastname=${last_name}
    ${response}=  GET  ${base_url}/booking  params=${query_params}  expected_status=200
    ${response_json}=  Convert response body to json  ${response}
    RETURN  ${response_json}

Create headers with basic authorization
    ${headers}=  Create Dictionary  Authorization=${authorization}
    RETURN  ${headers}
