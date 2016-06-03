define(['can_fixture'], (can)->

    can.fixture("POST /bss/authentication?action=confirmresetcredential", (req)->
        response: {
            service: "confirmresetcredential",
            response_code: 100,
            execution_time: 50,
            timestamp: "2013-11-19T21:46:19+0000",
            response_data: null,
            version: "1.0"
        }

    )
)