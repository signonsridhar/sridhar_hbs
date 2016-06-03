define([
    'bases/control',
    'modules/captcha_form/captcha_form',
    'models/auth/auth',
    'models/user/user',
    'models/captcha/captcha',
    'css!modules/login_form/login_form'
], (BaseControl, CaptchaForm, Auth, User, Captcha)->
    BaseControl.extend({
        LANG:()->
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
        init:(elem)->

            user = this.options.user = new User()
            user.set_validated_attrs(['valid_email_format'])
            this.render('login_form/login_form', {user: this.options.user})

            this.captcha = this.options.captcha = new Captcha()
            this.captcha_form = new CaptchaForm(this.find('.captcha_cont'), {captcha: this.options.captcha})

            this.bind_view(user)
        load_captcha: ()->
            email = this.find('input[name=valid_email_format]').val()
            if not email
                this.captcha_form.remove_captcha()
            else
                this.captcha.load(email)

        'input[name=valid_email_format] blur': ($input)->
            #console.log('EMAIL', $input.val())
            this.load_captcha()

        '.login_form form submit':()->
            auth = Auth.get_auth()
            email = this.options.user.attr('valid_email_format')
            passwd = this.options.user.attr('password')
            recaptcha_response_field = this.captcha_form.get_response()
            recaptcha_challenge_field = this.captcha_form.get_challenge()

            auth.login_attempt(email, passwd, recaptcha_response_field, recaptcha_challenge_field)
            .done((access_info)=>
                #console.log('access_info', access_info, Auth.get_auth().get_authenticated_user())
                auth.logged_in(access_info)
            ).fail((response)=>
                #show error here
                this.find('.backend_error').html(response.msg)
                this.load_captcha()
                this.options.user.validity('valid_email_format', VALID.ERROR.INVALID)
            )
            false
    })
)