define([ 'can_fixture', 'Faker'], (can, Faker, State)->
    can.fixture('GET /bss/tenant?action=getportedphonenumbers', (req, res)->
        return `{
            "response":{
                "service":"getportedphonenumbers",
                "response_code":100,
                "execution_time":10,
                "timestamp":"2013-12-18T23:42:16+0000",
                "response_data":{
                    "phone_numbers":[
                    {
                        "didid":10000001,
                        "partner_code":"tmus",
                        "phonenumber":14085000776,
                        "caller_id":0,
                        "is_conference":false,
                        "is_toll_free":false,
                        "is_ported":false,
                        "is_assigned":true,
                        "extension":201,
                        "userid":10000002,
                        "username":"sapna blesson",
                        "firstname":"sapna",
                        "lastname":"blesson"
                    },
                    {
                        "didid":10000000,
                        "partner_code":"tmus",
                        "phonenumber":14085000775,
                        "caller_id":0,
                        "is_conference":false,
                        "is_toll_free":false,
                        "is_ported":false,
                        "is_assigned":true,
                        "extension":200
                    }
                    ]
                },
                "version":"1.0"
            }
        }`
    )
)