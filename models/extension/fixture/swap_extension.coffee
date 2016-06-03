define([ 'can_fixture'], (can)->
    can.fixture('GET /bss/extension?action=swapextension', (req, res)->
        return {
        "response": {
            "service": "swapextension",
            "response_code": 100,
            "execution_time": 44
            "timestamp": "2013-10-18T18:28:33+0000",
            "response_data":{
                "pin_changed": "true"
            },
            "version": "1.0"
        }
        }
    )
)