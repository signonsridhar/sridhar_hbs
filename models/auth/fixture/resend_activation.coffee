define(['can_fixture', 'models/auth/fixture/authenticate'], (can, FixtureAuth)->
    valid_access_key = FixtureAuth.valid.access_key
    can.fixture("POST /bss/authentication?action=resendactivation", (req)->
        return true
    )
)