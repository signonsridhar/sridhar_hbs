define([ 'can_fixture', 'Faker'], (can, Faker, State)->
    can.fixture('GET /bss/ui/messaging?action=getmessage', (req, res)->
        return `{
           "response":{
              "service":"getmessage",
              "response_code":100,
              "execution_time":229,
              "timestamp":"2014-03-07T22:06:52+0000",
              "response_data":{
                 "messages":[
                    {
                       "message_id":10000011,
                       "user_id":22245255,
                       "message_code":"credit_card_expiring_soon",
                       "message_type":"modal",
                       "creation_date":"Fri, Mar 07, 2014"
                    },
                    {
                       "message_id":10000009,
                       "user_id":22245255,
                       "message_code":"credit_card_expiring_soon",
                       "message_type":"modal",
                       "creation_date":"Fri, Mar 07, 2014"
                    },
                    {
                       "message_id":10000007,
                       "user_id":22245255,
                       "message_code":"credit_card_expiring_soon",
                       "message_type":"modal",
                       "creation_date":"Fri, Mar 07, 2014"
                    },
                    {
                       "message_id":10000005,
                       "user_id":2224255,
                       "message_code":"credit_card_expiring_soon",
                       "message_type":"modal",
                       "creation_date":"Fri, Mar 07, 2014"
                    }
                 ]
              },
              "version":"1.0"
           }
        }`
    )
)