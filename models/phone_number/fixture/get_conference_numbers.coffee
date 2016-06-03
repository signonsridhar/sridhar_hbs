define([ 'can_fixture', 'Faker'], (can, Faker)->
    can.fixture('GET /bss/phonenumber?action=getConferencePhoneNumbers', (req, res)->
        return {
        "response": {
            "service": "getConferencePhoneNumbers",
            "response_code": 100,
            "execution_time": "312",
            "timestamp": "2013-10-03T13:38:38+0000",
            "version": "1.0",
            "response_data": {
                "phone_numbers": [
                    {
                        "didid": 10000082,
                        "partner_code": "tmus",
                        "phonenumber": 14085000773,
                        "caller_id": 14085000773,
                        "area_code": "408",
                        "country_code": "US",
                        "city": "MORGAN HILL",
                        "state": "CA",
                        "is_conference": true,
                        "is_toll_free": false,
                        "is_ported": false,
                        "partnerid": 10000000,
                        "provider_id": "voxbone",
                        "is_assigned": false,
                        "extension": 0,
                        "status": "available"
                    },
                    {
                        "didid": 10000083,
                        "partner_code": "tmus",
                        "phonenumber": 14085000774,
                        "caller_id": 14085000774,
                        "area_code": "408",
                        "country_code": "US",
                        "city": "MORGAN HILL",
                        "state": "CA",
                        "is_conference": true,
                        "is_toll_free": false,
                        "is_ported": false,
                        "partnerid": 10000000,
                        "provider_id": "voxbone",
                        "is_assigned": false,
                        "extension": 0,
                        "status": "available"
                    }
                ]
            }
        }
        }
    )



)

