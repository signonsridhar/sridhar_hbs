define(['can_fixture'], (can)->
    can.fixture('GET /bss/tenant?action=canceltenant',(req, res)->
        return {
            "response":{
                "service":"canceltenant",
                "response_code":100,
                "execution_time":782,
                "timestamp":"2013-11-25T23:26:42+0000",
                "version":"1.0"
            }
        }
    )
)