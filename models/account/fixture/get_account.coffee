define(['can_fixture'], (can)->
    can.fixture('GET /bss/account?action=getaccount',(req, res)->
       return {
           "response":{
               "service":"getaccount",
               "response_code":100,
               "execution_time":125,
               "timestamp":"2013-11-25T18:36:37+0000",
               "response_data":{
                   "account_id":"14449979",
                   "name": "Choochee"
                   "account_address_street1":"295 n bernado ave",
                   "account_address_city":"mountain view",
                   "account_address_state":"CA",
                   "account_address_country":"US",
                   "account_address_zip":"94043",
                   "billing_address_street1":"295 n bernado ave",
                   "billing_address_city":"mountain view",
                   "billing_address_state":"CA",
                   "billing_address_country":"US",
                   "billing_address_zip":"94043",
                   "primary_email":"sudha@choochee.com",
                   "contact_first_name":"adminFirstname",
                   "contact_last_name":"AdminLastname",
                   "currencycode":"USD",
                   "status":"ACTIVE",
                   "credit_card_address1":"295 n bernado ave",
                   "credit_card_city":"mountain view",
                   "credit_card_country":"US",
                   "credit_card_expiration_month":"3",
                   "credit_card_expiration_year":"2016",
                   "credit_card_mask_number":"XXXX-1111",
                   "credit_card_postal_code":"94043",
                   "credit_card_state":"CA",
                   "credit_card_type":"Visa",
                   "bill_cycle_day":"25",
                   "master_plan_name":"General Aria Master Plan (Dev)",
                   "master_plan_id":"10905223",
                   "bill_period_start": "11/1/2013",
                   "bill_period_end": "11/30/2013",
                   "bill_cycle_date": "2013-11-28T00:00:00-0500",
                   "last_bill_cycle_date": "10/31/2013",
                   "last_paid_amount": 0.0,
                   "total_recurring_charge": 0.0
               },
               "version":"1.0"
           }
       }
    )
)