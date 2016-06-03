define(['can_fixture'], (can)->
    can.fixture('POST /bss/group?action=addgrouprecording', (req, resp)->
        return `{
                "response": {
                "service": "addgrouprecording",
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