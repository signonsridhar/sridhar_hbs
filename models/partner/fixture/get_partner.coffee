define(['can_fixture'], (can)->
    can.fixture('GET /bss/partner?action=getpartner',(req, res)->
        return {
            "response": {
                "service": "getpartner",
                "response_code": 100,
                "execution_time": 4718,
                "timestamp": "2013-10-15T23:07:49+0000",
                "response_data": {
                    "partner_id": 10000000,
                    "partner_name": "T-Mobile @Work",
                    "partner_code": "tmus",
                    "language": "EN"
                }
            }
        }
    )
)