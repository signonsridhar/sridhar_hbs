define([
    'bases/model',
    'models/auth/auth',
    'env!dev:models/directory/fixture/get_company_directory'
    'env!dev:models/message/fixture/ackmessage'
    'env!dev:models/message/fixture/getmessage'
], (BaseModel,Auth)->
    BaseModel.extend({

        get_status_message:()->
            $.get('/bss/tenant?action=getcompanydirectory', {tenantid: Auth.get_auth().attr('tenant_id')}).then((response)=>
                { status: response.data.status, credit_card_status:response.data.credit_card_status }
            )
        get_message:(user_id)->
            $.get('/bss/ui/messaging?action=getmessage', {user_id: user_id}).then((response_data)=>
                BaseModel.model.call(this, response_data.data)
            )

    },{
        ack_message:(recording)->
            $.post('/bss/ui/messagin?action=ackmessage', { message_id: this.attr('message_id'),user_id:this.attr('user_id') })

    })
)