define([ 'can_fixture'], (can)->

    can.fixture('POST /bss/dphandler/addcreditcardhandler?partner_code=tmus', (req, res)->
        return {
        "response":{
            "service":"addcreditcardhandler",
            "response_code":100,
            "execution_time":5962,
            "timestamp":"2013-10-09T22:12:06+0000",
            "response_data":{
                "<html><body><script language='javascript'>parent.onAddCreditCard( {dp_response: { success: true, errors: [ {  error_code: '6003', error_message: 'You must enter a credit card number.'   }, {  error_code: '6012',  error_message: 'Credit card expiration month missing.'  }  ] }});</script></body></html>"
            }
        }
        }
    )
)