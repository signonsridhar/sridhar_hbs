define(['bases/control',
        'models/user/user',
        'css!modules/profile_settings/profile_settings'
], (BaseControl, User)->
    BaseControl.extend({
        LANG: (controller)->
            LANG = {
                errors:{
                    first_name:{}
                    last_name:{}
                    email:{}
                }
            }
            LANG.errors.first_name[VALID.ERROR.SIZE] = 'must be between 2-40 characters'
            LANG.errors.first_name[VALID.ERROR.REQUIRED] = 'first name is required'
            LANG.errors.first_name[VALID.ERROR.FORMAT] = "must be 2 to 40 characters alphanumeric, and may contain the following special chars:  . , & ( ) ! ? - @ '"

            LANG.errors.last_name[VALID.ERROR.SIZE] = 'must be between 2-40 characters'
            LANG.errors.last_name[VALID.ERROR.REQUIRED] = 'last name is required'
            LANG.errors.last_name[VALID.ERROR.FORMAT] = "must be 2 to 40 characters alphanumeric, and may contain the following special chars:  . , & ( ) ! ? - @ '"

            LANG.errors.email[VALID.ERROR.REQUIRED] = 'email is required'
            LANG.errors.email[VALID.ERROR.SIZE] = 'must be a valid email address with 3 to 70 characters'
            LANG.errors.email[VALID.ERROR.FORMAT] = 'must be alphanumeric, must have @ and period, must be 3 to 70 chars, and may contain following special chars: - . _ +'
            LANG.errors.email[VALID.ERROR.UNIQUE] = 'this email already exists'
            LANG.errors.email[VALID.ERROR.INVALID] = 'Invalid user name format, format should be in the form of email : user@sample.com'


            LANG.title='Manage Profile Settings'
            LANG.profile_changed= 'Profile changed'
            LANG.errors[VALID.ERROR.INVALID] = 'Failed to update profile'

            LANG
    },{
        init: (elem, options)->
            this.prev_email_upper = this.options.prof_user.attr('email').toUpperCase()
            this.prev_first_name_upper = this.options.prof_user.attr('first_name').toUpperCase()
            this.prev_last_name_upper = this.options.prof_user.attr('last_name').toUpperCase()
            this.setup_viewmodel({
                is_profile_changed: false
            })
            this.render('profile_settings/profile_settings', {prof_user: this.options.prof_user})
            this.bind_view(this.options.prof_user)
            this.set_validity(false)

        set_email:()->
            this.options.prof_user.set_email()

        'form submit': ()->
            promise1 = this.options.prof_user.set_name()

            if (this.prev_email_upper != this.options.prof_user.email.toUpperCase)
                promise1.then(this.set_email).then(()=>
                    this.viewmodel.attr('is_profile_changed', true)
                ).fail(()=>
                    this.viewmodel.attr('is_profile_changed', false)
                    this.viewmodel.attr('errors.display', "invalid")
                ).always(()=>
                    this.options.prof_user.valid(false)
                )
            else
                promise1.done(()=>
                    this.viewmodel.attr('is_profile_changed', true)
                ).fail(()=>
                    this.viewmodel.attr('is_profile_changed', false)
                    this.viewmodel.attr('errors.display', "invalid")
                ).always(()=>
                    this.options.prof_user.valid(false)
                )
            return false

        '{user.valid} change': ()->
            this.set_validity(this.options.prof_user.valid())

        validate: ()->
            this.options.prof_user.validate()

    })
)