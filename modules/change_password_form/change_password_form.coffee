define([
	'bases/control',
    'models/auth/auth',
    'models/user/user',
	'css!modules/change_password_form/change_password_form'
], (BaseControl, Auth, User)->
    BaseControl.extend({
        LANG:()->
            errors = {
                pin:{},
                confirm_pin:{}
            }

            LANG = {
                errors:errors
            }

            LANG.title = 'Welcome to T-Mobile @Work, The Office Phone System'
            LANG.subtitle ='You are almost there. Please set a password.'
            LANG.pin_changed= 'Password changed'

            LANG.errors[VALID.ERROR.INVALID] = 'Failed to update password'

            LANG.errors.confirm_password = LANG.errors.password = {}
            LANG.errors.confirm_password[VALID.ERROR.EQUAL] = 'Password has to be the same'
            LANG.errors.confirm_password[VALID.ERROR.FORMAT] = 'Password must be 7 to 16 characters long, must contain at least 1 letter (a-z) (A-Z) and 1 number, and may contain special character'
            LANG

    }, {
        init:(elem, options)->
            this.options.user = this.user = new User({confirm_password:'', password:''})
            this.setup_viewmodel({
                is_pin_changed: false
            })
            this.user.set_validated_attrs(['password', 'confirm_password'])
            this.render('change_password_form/change_password_form', {user: this.user})
            this.bind_view(this.user)
            this.set_validity(false)
            this.on()

        validate: ()->
            this.user.validate()

        '{user.valid} change': ()->
            this.set_validity(this.user.valid())

        'form submit': ()->
            this.viewmodel.attr('errors.display', null)
            this.viewmodel.attr('is_pin_changed', false)
            Auth.get_auth().get_user().update_password({
                old_credential: this.user.attr('old_credential'),
                new_credential: this.user.attr('password'),
                confirm_pass:   this.user.attr('confirm_password')
            }).done(()=>
                this.viewmodel.attr('is_pin_changed', true)
            ).fail(()=>
                #show error here>
                this.viewmodel.attr('is_pin_changed', false)
                this.viewmodel.attr('errors.display', "invalid")
            )
            return false

    })
)