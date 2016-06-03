define(['can_fixture'], (can)->
    can.fixture('GET /bss/account?action=getcreditcard',(req, res)->
        return {
            "response":{
                "service":"getcreditcard",
                "response_code":100,
                "execution_time":856,
                "timestamp":"2013-11-25T18:56:03+0000",
                "response_data":{
                    "creditcards":[
                        {
                            "creditcardid":"2",
                            "address1":"295 n bernado ave",
                            "city":"mountain view",
                            "country":"US",
                            "expiration_month":"3",
                            "expiration_year":"2016",
                            "first_name":"CFN",
                            "last_name":"CLN",
                            "number":"XXXX-1111",
                            "zip_code":"94043",
                            "state":"CA",
                            "card_type":"Visa",
                            "primary":true
                        }
                    ]
                },
                "version":"1.0"
            }
        }
    )
)