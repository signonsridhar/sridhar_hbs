define(['can_fixture', 'models/auth/fixture/authenticate'], (can, FixtureAuth)->

    can.fixture("GET /bss/authentication?action=keepalive&accesskeyid=#{FixtureAuth.valid.access_key}", (req)->
        curr_expiry = FixtureAuth.valid.expires
        curr_expiry.setHours(curr_expiry.getHours() + 1)

        return {
            response: {
                service: "keepalive",
                response_code: 100,
                execution_time: 50,
                timestamp: "2013-11-19T21:46:19+0000",
                response_data: curr_expiry.toUTCString(),
                version: "1.0"
            }
        }
    )
)