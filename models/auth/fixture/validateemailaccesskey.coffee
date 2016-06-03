define(['can_fixture', 'models/auth/fixture/authenticate'], (can, FixtureAuth)->

    valid_access_key = FixtureAuth.valid.access_key
    can.fixture("GET /bss/authentication?action=validateemailaccesskey&accesskeyid=#{valid_access_key}", (req)->
        return {
            "response":{
                "service":"validateemailaccesskey",
                "response_code":100,
                "execution_time":4512,
                "timestamp":"2014-03-24T21:14:17+0000",
                "response_data":"true",
                "version":"1.0"
            }
        }

    )
)