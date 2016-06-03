define([ 'can_fixture'], (can)->
    can.fixture('POST /bss/extension?action=addportedphonenumberforextension', (req, res)->
        return {
            "response": {
                "service": "addportedphonenumberforextension",
                "response_code": 100,
                "execution_time": 4
                "timestamp": "2013-10-18T18:28:33+0000",
                "version": "1.0"
            }
        }
    )
)