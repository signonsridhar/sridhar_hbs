define([ 'can_fixture', 'Faker'], (can, Faker)->

    can.fixture('POST /bss/tenant?action=signuptenant', (req, res)->
        return {
            "response": {
                "service": "signuptenant",
                "response_code": 100,
                "execution_time": 444,
                "timestamp": "2013-10-18T18:28:33+0000",
                "response_data":{
                    "tenant_id": 10000000,
                    "access_key": "10000002_0567375721_1387586528325"
                },
                "version": "1.0"
            }
        }
    )
)