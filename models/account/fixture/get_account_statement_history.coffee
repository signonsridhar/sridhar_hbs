define(['can_fixture'], (can)->
    can.fixture('GET /bss/account?action=getaccountstatementhistory',(req, res)->
        return {
            "response":{
                "service":"getaccountstatementhistory",
                "response_code":100,
                "execution_time":2586,
                "timestamp":"2014-02-26T20:02:19+0000",
                "response_data":{
                    "statements":[
                        {
                            "statement_number":431978683,
                            "description":"February 2014",
                            "creation_date":"Tue, Feb 25, 2014",
                            "currency":"usd",
                            "total_amount":0.0
                        },
                        {
                            "statement_number":431979293,
                            "description":"February 2014",
                            "creation_date":"Tue, Feb 25, 2014",
                            "currency":"usd",
                            "total_amount":0.0
                        }
                    ]
                },
                "version":"1.0"
            }
        }
    )
)