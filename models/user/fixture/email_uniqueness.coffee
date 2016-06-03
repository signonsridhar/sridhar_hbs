define(['can_fixture'], (can)->

    can.fixture('GET /bss/authentication?action=checkcredentialavailability', (req, resp)->
        switch req.data.identification
            when 'duplicate@gmail.com'
                `{"response": {
                        "service": "checkcredentialavailability",
                        "response_code": 100,
                        "error_message": "Error",
                        "execution_time": 7,
                        "timestamp": "2013-10-04T21:01:17+0000",
                        "version": "1.0",
                        "response_data": "false"
                }}`

            when 'unique@gmail.com'
                `{"response": {
                        "service": "checkcredentialavailability",
                        "response_code": 100,
                        "error_message": "Error",
                        "execution_time": 7,
                        "timestamp": "2013-10-04T21:01:17+0000",
                        "version": "1.0",
                        "response_data": "true"
                }}`
            else
                `{"response": {
                        "service": "checkcredentialavailability",
                        "response_code": 100,
                        "error_message": "Error",
                        "execution_time": 7,
                        "timestamp": "2013-10-04T21:01:17+0000",
                        "version": "1.0",
                        "response_data": "true"
                }}`
    )
)