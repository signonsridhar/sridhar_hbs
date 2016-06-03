define(['can_fixture'], (can)->
    can.fixture('POST /bss/group?action=changeringorder', (req, resp)->
        return '{
           "response":{
              "service":"changeringorder",
              "response_code":100,
              "execution_time":2746,
              "timestamp":"2013-10-31T01:11:29+0000",
              "version":"1.0"
           }
        }'
    )
)