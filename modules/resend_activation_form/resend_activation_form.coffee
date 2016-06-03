define(['bases/control',
        'models/auth/auth',
        'models/user/user',
        'css!modules/resend_activation_form/resend_activation_form'
], (BaseControl, Auth, User)->
    BaseControl.extend({
        LANG: ()->
            LANG = {}
            LANG.errors = {}
            LANG.errors.valid_email_format = {}
            LANG.errors.valid_email_format[VALID.ERROR.REQUIRED] = 'email is required'
            LANG.errors.valid_email_format[VALID.ERROR.SIZE] = 'email has to be between 3-40 characters'
            LANG.errors.valid_email_format[VALID.ERROR.UNIQUE] = 'email is already registered'
            LANG.errors.valid_email_format[VALID.ERROR.FORMAT] = 'email is invalid'
            LANG.errors.valid_email_format[VALID.ERROR.INVALID] = 'email/password is invalid'
            LANG
    }, {
        init:(elem, options)->
            user = this.options.user = new User()
            user.set_validated_attrs(['valid_email_format'])
            this.render('resend_activation_form/resend_activation_form', {user: user})
            this.bind_view(user)

        'submit':()->
            Auth.forgot_password(this.options.user.attr('valid_email_format')).then(()=>
                if(this.options.show_link)
                    window.location = can.route.url({ main:'error',sub:'reset_password_link_sent', partner:'tmus'})
                else
                    window.location = can.route.url({ main:'error',sub:'activation_link_sent', partner:'tmus'})
            ).fail((resp)->
                #this.render('resend_activation_form/resend_activation_error')

                if(resp.code == 1009 || resp.code == 1019 )
                    window.location = can.route.url({ main:'auth',sub:'forgot_password', partner:'tmus'})
                    console.log("Access key expired")
                else if(resp.code == 3351)
                    window.location = can.route.url({ main:'error',sub:'invalid_user'})
                else
                    window.location = can.route.url({ main:'error',sub:'unknown_error'})
            )
            return false
    })
)