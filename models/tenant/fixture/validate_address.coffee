define(['can_fixture'], (can)->
    can.fixture('POST /bss/system?action=validateaddress',(req, res)->
        return {
            "response":{
                "service":"validateaddress",
                "response_code":100,
                "response_data":"true",
                "execution_time":782,
                "timestamp":"2013-11-25T23:26:42+0000",
                "version":"1.0"
            }
        }
    )
)