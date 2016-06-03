define([ 'can_fixture'], (can)->
    can.fixture('POST /bss/user?action=addgroup', (req, res)->
        return `{"response": {
"service": "addgroup",
"response_code": 100,
"execution_time": 2746,
"timestamp": "2013-10-31T01:11:29+0000",
"response_data": {
},
"version": "1.0"
}}`
    )
)