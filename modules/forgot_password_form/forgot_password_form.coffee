define(['bases/control', 
        'models/auth/auth',
        'models/user/user',
        'css!modules/forgot_password_form/forgot_password_form'
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

            this.access_key = can.route.attr('access_key')
            user = this.options.user = new User()
            user.set_validated_attrs(['valid_email_format'])
            this.render('forgot_password_form/forgot_password_form', {user: user})
            this.bind_view(user)



        'submit':()->
            Auth.forgot_password(this.options.user.attr('valid_email_format')).then(()=>
                window.location = can.route.url({ main:'error',sub:'reset_password_link_sent', partner:'tmus', email: this.options.user.attr('valid_email_format')})
            ).fail((resp)->
                if(resp.code == 1009 || resp.code == 1019 )
                    #access key id expired
                    window.location = can.route.url({ main:'auth',sub:'resend_activation', partner:'tmus', show_link: true})
                else if(resp.code == 3351 || resp.code == 1101)
                    window.location = can.route.url({ main:'error',sub:'invalid_user'})
                else
                    window.location = can.route.url({ main:'error',sub:'unknown_error'})
            )
            return false
    })
)