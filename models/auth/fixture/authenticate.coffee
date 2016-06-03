define(['can_fixture'], (can)->
    data = {
        valid:{
            email: 'valid@gmail.com',
            password: 'totally_secure'
            user_id:10000001
            access_key:'valid_access_key'
            expires:new Date()
        },
        invalid:{
            email: 'invalid@gmail.com',
            password:'totally_secure'
        }
    }

    partner_code = 'tmus'

    can.fixture("POST /bss/authentication?action=authenticate", (req, res)->

        req_data = JSON.parse(req.data)
        now = new Date()
        now.setHours(now.getHours() + 1)
        data.valid.expires = now

        if (req_data.credential == data.valid.password and req_data.identification == data.valid.email)
            return {
                response:{
                    response_code:100,
                    response_data:{
                        partner_code:partner_code,
                        expires: data.valid.expires.toUTCString(),
                        accesskey:data.valid.access_key,
                        userid:data.valid.user_id
                    }
                }
            }

        else if(req_data.credential == 'password')
            return `{"response": {
                            "service": "authenticate",
                            "response_code": 500,
                            "error_message": "The password must be 8 to 16 characters long, must contain at least one lowercase, one uppercase, one number (0-9). Must contain one special character from the following !@#$%^&*()-_=+,<.>[{]}\|~",
                            "execution_time": 193,
                            "timestamp": "2014-03-17T21:59:41+0000",
                            "version": "1.0"
                    }}`
        else
            return {
                    response:{
                        response_code:1007,
                        response_data:{
                        }
                    }
                }
    )

    data
)