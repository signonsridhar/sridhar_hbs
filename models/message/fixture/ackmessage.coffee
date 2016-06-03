define([ 'can_fixture'], (can)->
    can.fixture('POST /bss/ui/messagin?action=ackmessage', (req, res)->
        return {
            "response": {
                "service": "ackmessage",
                "response_code": 100,
                "execution_time": 43
                "timestamp": "2013-10-18T18:28:33+0000",
                "version": "1.0"
            }
        }
    )
)