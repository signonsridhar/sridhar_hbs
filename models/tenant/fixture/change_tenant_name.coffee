define(['can_fixture'], (can)->
    can.fixture('GET /bss/tenant?action=changetenantname',(req, res)->
        return {
            "response":{
                "service":"changetenantname",
                "response_code":100,
                "execution_time":782,
                "timestamp":"2013-11-25T23:26:42+0000",
                "version":"1.0"
            }
        }
    )
)