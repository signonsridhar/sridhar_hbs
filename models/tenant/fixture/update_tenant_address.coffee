define(['can_fixture'], (can)->
    can.fixture('POST /bss/tenant?action=updatetenantaddress',(req, res)->
        return {
            "response":{
                "service":"updatetenantaddress",
                "response_code":100,
                "execution_time":782,
                "timestamp":"2013-11-25T23:26:42+0000",
                "version":"1.0"
            }
        }
    )
)