define(['can_fixture'], (can)->
    can.fixture('GET /bss/group?action=getgrouprecording', (req, resp)->
        return `{
                            "response": {
                            "service": "getgrouprecording",
                            "response_code": 100,
                            "execution_time": 1332,
                            "timestamp": "2013-10-25T00:17:42+0000",
                            "response_data": {

                            },
                            "version": "1.0"
                    }
                }`
        )
)