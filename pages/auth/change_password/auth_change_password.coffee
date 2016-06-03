define(['bases/page', 
'models/user/user',
'css!pages/auth/change_password/auth_change_password'
], (BasePage, User)->
    BasePage.extend({
       LANG:()->

           LANG = {}
           LANG.title = 'Reset your password'
           LANG.subtitle = ''
           LANG.errors = {}
           LANG.errors.confirm_password = {}
           LANG.errors.confirm_password[VALID.ERROR.EQUAL] = 'Password has to be the same'

           LANG.errors.password = {}
           LANG.errors.password[VALID.ERROR.REQUIRED] = 'Password is required'

           return LANG
    }, {

        init:(elem, options)->
            this.access_key = can.route.attr('access_key')
            #alert('need to have an access key to be able to reset password') if not this.access_key?

            this.options.user = this.user = new User()
            this.user.set_validated_attrs(['password', 'confirm_password'])
            this.set_validity(false)
            this.render('auth/change_password/auth_change_password', {user: this.user})
            this.bind_view(this.user)
            this.on()

        'form submit':()->
            this.options.user.set_password(this.access_key).then(()=>
                window.location = can.route.url({ main:'error',sub:'reset_password_success'})
                setTimeout(()=>
                    window.location = can.route.url({ main:'auth',sub:'login'})
                , 5000)

            ).fail((resp)->
                window.location = can.route.url({ main:'error',sub:'account_locked'})
            )
            return false

        '{user} change':()->

            this.set_validity(this.user.valid())


    })
)