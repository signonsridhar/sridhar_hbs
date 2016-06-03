define(['can_fixture'], (can)->
    can.fixture('POST /bss/order?action=getpurchasesummary',(req, res)->
        return {
            "response":{
                "service":"getpurchasesummary",
                "response_code":100,
                "execution_time":11391,
                "timestamp":"2014-04-21T23:48:56+0000",
                "response_data":{
                    "line_name":"T-Mobile Line Bundle Monthly (Dev)-V2",
                    "total_line_quantity":0.0,
                    "line_quantity":3.0,
                    "extension_quantity":3.0,
                    "did_quantity":3.0,
                    "device_quantity":3.0,
                    "master_paln_extensioin_quantity":1.0,
                    "master_plan_did_quantity":0.0,
                    "master_plan_device_quantity":2.0,
                    "billing_period":1,
                    "amount_per_unit":"50.00",
                    "tax_amount":"2.67",
                    "total_amount_before_taxes":"150.00",
                    "total_amount_after_taxes":"152.67",
                    "credit_card":{
                        "creditcardid":"1",
                        "address1":"951 S12 Street",
                        "city":"San Jose",
                        "country":"US",
                        "expiration_month":"5",
                        "expiration_year":"2015",
                        "first_name":"Muslim",
                        "last_name":"Nurakhunov",
                        "number":"XXXX-1111",
                        "zip_code":"95112",
                        "state":"CA",
                        "card_type":"Visa",
                        "primary":true
                    }
                },
                "version":"1.0"
            }
        }
    )
)