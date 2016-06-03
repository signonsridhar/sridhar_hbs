define(['can_fixture'], (can)->
    can.fixture("POST /bss/system?action=validatesecurityquestions", (req, res)->
        return response: {
            service: "keepalive",
            response_code: 100,
            execution_time: 50,
            timestamp: "2013-11-19T21:46:19+0000",
            response_data: null,
            version: "1.0"
        }
    )
)