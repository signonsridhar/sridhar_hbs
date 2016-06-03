define([ 'can_fixture', 'Faker'], (can, Faker, State)->
    can.fixture('GET /bss/phonenumber?action=unreservephonenumber', (req, res)->
        return {
            "response": {
                "service": "unreservephonenumber",
                "response_code": 100,
                "execution_time": "312",
                "timestamp": "2013-10-03T13:38:38+0000",
                "version": "1.0",
                "response_data": {

                }
            }
        }
    )
)