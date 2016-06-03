define(['can_fixture', 'models/auth/fixture/authenticate'], (can, FixtureAuth)->
    valid_access_key = FixtureAuth.valid.access_key
    can.fixture("GET /bss/authentication?action=validateaccesskey&accesskeyid=#{valid_access_key}", (req)->
        return true
    )
)