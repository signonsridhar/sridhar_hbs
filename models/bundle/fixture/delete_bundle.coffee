define([ 'can_fixture'], (can)->
    can.fixture('POST /bss/tenant?action=deletebundle', (req, res)->
        return `{
            "response": {
                "service": "deletebundle",
                "response_code": 100,
                "execution_time": 26,
                "timestamp": "2013-10-31T01:11:29+0000",
                "response_data": {
                },
                "version": "1.0"
            }
        }`
    )
)