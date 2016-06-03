define(['bases/page', 
        'models/auth/auth', 
        'models/user/user', 
        'modules/agreement/agreement',
        'modules/security_questions_form/setup_security_questions_form',
        'css!pages/setup_password/index/setup_password_index'
], (BasePage, Auth, User, Agreement, SecurityQuestionsForm)->
    BasePage.extend({
       LANG:()->
            LANG = {}
            LANG.title = 'Welcome to T-Mobile @Work, The Office Phone System'
            LANG.subtitle ='You are almost there. Please set a password.'
            LANG.errors = {}
            LANG.errors.confirm_password = LANG.errors.password = {}
            LANG.errors.confirm_password[VALID.ERROR.EQUAL] = 'Password has to be the same'
            LANG.errors.confirm_password[VALID.ERROR.FORMAT] =  "The password must be 8 to 16 characters long, must contain at least one lowercase, one uppercase, one number (0-9). Must contain one special character from the following !@#$%^&*()-_=+,<.>[{]}\|~"
            LANG

    }, {
        init:(elem, options)->
            this.set_validity(false)
            this.access_key = can.route.attr('access_key')
            Auth.validate_email_access_key(this.access_key).then(()=>
                console.log("inside access key success")
                this.options.user = this.user = new User({confirm_password:'', password:'', email: can.route.attr('email')})

                this.user.set_validated_attrs(['confirm_password'])
                this.render('setup_password/index/setup_password_index', {user: this.user})
                this.options.agreement = this.agreement = new Agreement(this.find('.e911_container_js'), {enable:['tos', 'e911']})
                this.options.security_questions_form = this.security_questions_form = new SecurityQuestionsForm(this.find('.security_questions_cont'))
                this.bind_view(this.user, this.find('form.password'))
                this.on()
            ).fail((resp)->
                if(resp.code == 1009 || resp.code == 1019 )
                    window.location = can.route.url({ main:'auth',sub:'resend_activation', partner:'tmus'})
                    console.log("Access key expired")
                else if(resp.code == 3351)
                    window.location = can.route.url({ main:'error',sub:'invalid_user'})
                else
                    window.location = can.route.url({ main:'error',sub:'unknown_error'})
            )


        validate:()->
            validity = this.user.valid() and this.agreement.validity() and this.security_questions_form.validity()
            console.log('VALIDITY', this.user.valid(), this.agreement.validity() , this.security_questions_form.validity())
            this.set_validity(validity)

        '{user.valid} change':()->
            console.log('user validity changed', this.user.valid())
            this.validate()

        '{agreement.validity} change':()->
            console.log('agreement validity changed', this.agreement.validity())
            this.validate()

        '{security_questions_form.validity} change':()->
            console.log('security_questions_form validity changed', this.security_questions_form.validity())
            this.validate()

        'form submit':()->
            this.options.user.attr('security_questions', this.security_questions_form.get_questions())
            this.options.user.save_security(this.access_key).then(()=>
                auth = Auth.get_auth()
                auth.login_attempt(this.options.user.attr('email'), this.options.user.attr('password'))
                .then((access_info)->
                    #console.log('access_info', access_info, Auth.get_auth().get_authenticated_user())
                    auth.logged_in(access_info, false)
                    window.location = can.route.url({main:'wizard'})
                ).fail(()->
                    #show error here>
                    console.log('login failed')
                )
            ).fail((response)=>
                this.find('.backend_error').html(response.msg)
            )
            return false
    })
)