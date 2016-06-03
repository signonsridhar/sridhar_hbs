define([ 'can_fixture'], (can)->
    can.fixture('POST /bss/tenant?action=configureCompanyDirectory', (req, res)->
        return {
            "response":{
                "service":"configurecompanydirectory",
                "response_code":100,
                "execution_time":17328,
                "timestamp":"2014-01-28T18:48:34+0000",
                "response_data":{
                    "purchase_summary":{
                        "invoice_id":"51500414",
                        "order_number":"5726036",
                        "invoice_items":[
                            {
                                "product_id":"10260667",
                                "name":"Polycom IP550",
                                "amount":50.0,
                                "quantity":1.0
                            }
                        ],
                        "tax_amount":0.0,
                        "total_amount_before_taxes":50.0,
                        "total_amount_after_taxes":50.0,
                        "credit_card":{
                            "creditcardid":"1",
                            "address1":"977 Nasa Pkwy",
                            "city":"Houston",
                            "country":"US",
                            "expiration_month":"5",
                            "expiration_year":"2016",
                            "first_name":"Jack",
                            "last_name":"Black",
                            "number":"XXXX-1111",
                            "zip_code":"77058",
                            "state":"TX",
                            "card_type":"Visa",
                            "primary":true
                        }
                    }
                },
                "version":"1.0"
            }
        }
    )
)