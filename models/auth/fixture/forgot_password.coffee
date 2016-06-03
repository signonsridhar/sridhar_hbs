define(['can_fixture', 'models/auth/fixture/authenticate'], (can)->

    can.fixture("POST /bss/authentication?action=forgotpassword", (req)->
        response: {
            service: "keepalive",
            response_code: 100,
            execution_time: 50,
            timestamp: "2013-11-19T21:46:19+0000",
            response_data: null,
            version: "1.0"
        }

    )
)