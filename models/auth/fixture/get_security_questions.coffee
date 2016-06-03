define(['can_fixture'], (can)->
    can.fixture("GET /bss/system?action=getsecurityquestions", (req, res)->
        return `{"response": {
            "service": "getsecurityquestions",
            "response_code": 100,
            "execution_time": 5,
            "timestamp": "2014-03-18T22:47:40+0000",
            "response_data": {
                "securityQuestions": [
                {
                    "securityQuestionId": 1,
                    "securityQuestion": "What is your mother's rapper name?"
                },
                {
                    "securityQuestionId": 10,
                    "securityQuestion": "Are you a Belieber?"
                },
                {
                    "securityQuestionId": 25,
                    "securityQuestion": "Do you believe in life after love?"
                },
                {
                    "securityQuestionId": 5,
                    "securityQuestion": "Annie are you okay? Are you okay?"
                }
                ]
            },
            "version": "1.0"
            }}`
    )
    can.fixture("GET /bss/system?action=getsecurityquestions&email=test@gmail.com", (req, res)->
        return `{"response": {
            "service": "getsecurityquestions",
            "response_code": 100,
            "execution_time": 5,
            "timestamp": "2014-03-18T22:47:40+0000",
            "response_data": {
                "securityQuestions": [
                {
                    "securityQuestionId": 1,
                    "securityQuestion": "What is your mother's rapper name?"
                },
                {
                    "securityQuestionId": 10,
                    "securityQuestion": "Are you a Belieber?"
                },
                {
                    "securityQuestionId": 25,
                    "securityQuestion": "Do you believe in life after love?"
                }
                ]
            },
            "version": "1.0"
            }}`

    )
)