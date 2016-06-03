define([ 'can_fixture', 'Faker'], (can, Faker)->

    can.fixture('POST /bss/authentication?action=updateUserName', (req, res)->
        return {
        "response": {
            "service": "updateUserName",
            "response_code": 100,
            "execution_time": 3151,
            "timestamp": "2013-10-15T22:22:13+0000",
            "response_data": {
            }
        }
        }
    )
)
