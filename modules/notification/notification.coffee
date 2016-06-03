define(['bases/control',
        'models/message/message',
        '_',
        'css! modules/notification/notification'
], (BaseControl,Message,_)->
    BaseControl.extend({
        LANG:()->
            LANG = {}
            LANG.suspended = "Account is restricted and some functionality will not be available until the restriction is lifted. Please contact customer support."
            LANG.disabled = "Account is restricted. Please contact customer support."
            LANG.cancel_pending = "Cancel Pending"
            LANG.terminated = "Account Terminated"
            LANG.pending_expiration = "Your credit card will expire soon, please update it under My Account."
            LANG.expired = "Your credit card has expired. Please update your credit card ASAP under My Account."
            LANG
    },{
        init:(elem, options)->
            this.setup_viewmodel({
            })
            this.viewmodel.attr_promise('status_message', Message.get_status_message())

            this.render('notification/notification')
            this.on()

    })
)