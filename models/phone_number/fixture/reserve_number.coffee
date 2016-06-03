define([ 'can_fixture', 'Faker'], (can, Faker, State)->
    can.fixture('POST /bss/phonenumber?action=reservephonenumber', (req, res)->
        return {
            "response":{
                "service":"reservephonenumber",
                "response_code":100,
                "execution_time":21,
                "timestamp":"2014-03-18T21:57:25+0000",
                "response_data":{
                    "didid":10000000,
                    "partner_code":"tmus",
                    "phonenumber":14085000775,
                    "caller_id":14085000775,
                    "area_code":"408",
                    "country_code":"US",
                    "city":"MORGAN HILL",
                    "state":"CA",
                    "is_conference":false,
                    "is_toll_free":false,
                    "is_ported":false,
                    "partnerid":10000000,
                    "provider_id":"voxbone",
                    "is_assigned":false,
                    "extension":0,
                    "status":"pending_tenant"
                },
                "version":"1.0"
            }
        }
    )
)