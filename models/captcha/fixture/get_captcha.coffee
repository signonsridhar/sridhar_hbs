define([ 'can_fixture'], (can)->
    can.fixture('GET /bss/authentication?action=getcaptcha&identification=show%40captcha.com', (req, res)->
        return `{
            "response": {
                "service": "getcaptcha",
                "response_code": 100,
                "execution_time": 9,
                "timestamp": "2014-03-13T19:22:17+0000",
                "response_data": "6LfMpO8SAAAAAPMQ8qHVULI3LaJBj7c3oRBLEE4_",
                "version": "1.0"

            }
        }`
    )

    can.fixture('GET /bss/authentication?action=getcaptcha&identification=no%40captcha.com', (req, res)->
        return `{
                "response": {
                    "service": "getcaptcha",
                    "response_code": 100,
                    "execution_time": 9,
                    "timestamp": "2014-03-13T19:22:17+0000",
                    "response_data": "",
                    "version": "1.0"

                }
            }`
    )

    can.fixture('GET /bss/authentication?action=getcaptcha&identification=locked%40captcha.com', (req, res)->
        return `{
                    "response": {
                        "service": "getcaptcha",
                        "response_code": 1177,
                        "error_message": "User is locked",
                        "execution_time": 4,
                        "timestamp": "2014-03-14T18:21:03+0000",
                        "version": "1.0"
                    }
            }`
    )
)