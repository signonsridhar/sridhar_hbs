define([
    'bases/control',
    'http://www.google.com/recaptcha/api/js/recaptcha_ajax.js'

], (BaseControl, Captcha)->

    BaseControl.extend({
        init:(elem, options)->
            if not this.options.captcha?
                throw Exception('please provide captcha')

            window.captcha = this.options.captcha
            id =  this.element.attr('id')
            if not id?
                id = _.uniqueId('captcha_')
                this.element.attr('id', id)
            this.id = id

        'input[name=recaptcha_response_field] keypress':($input)->
            this.options.captcha.attr('recaptcha_response_field', $input.val())

        '{captcha} update change': ()->
            already_has_captcha = this.element.find('input[name="recaptcha_response_field"]').length
            public_key = this.options.captcha.attr('key')

            if this.options.captcha.attr('is_locked')
                this.show_locked_out()
            else #not locked out
                if already_has_captcha and public_key
                    Recaptcha.reload()
                else if public_key
                    Recaptcha.create(public_key, this.id)
                else
                    this.remove_captcha()

        show_locked_out: ()->
            this.remove_captcha()
            window.location = can.route.url({ main:'error',sub:'account_locked'})

        remove_captcha: ()-> Recaptcha.destroy()
        get_challenge:()-> Recaptcha.get_challenge()
        get_response:()-> Recaptcha.get_response()

    })

)