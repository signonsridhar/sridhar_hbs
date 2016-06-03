define([
    'bases/control',
    '_',
    'libs/masked_input_plugin_jquery',
    'css!modules/admin_info_form/admin_info_form'
], (BaseControl, _)->
    BaseControl.extend({
        LANG: (controller)->
            LANG = {
                errors:{
                    first_name:{}
                    last_name:{}
                    phone:{}
                    email:{}
                    confirm_email:{}
                }
            }
            LANG.errors.first_name[VALID.ERROR.SIZE] = 'first name must be 2 to 40 characters'
            LANG.errors.first_name[VALID.ERROR.REQUIRED] = 'first name is required'
            LANG.errors.first_name[VALID.ERROR.FORMAT] = "must be 2 to 40 characters alphanumeric, and may contain the following special chars:  . , & ( ) ! ? - @ '"

            LANG.errors.last_name[VALID.ERROR.REQUIRED] = 'last name is required'
            LANG.errors.last_name[VALID.ERROR.SIZE] = 'last name must be 2 to 40 characters'
            LANG.errors.last_name[VALID.ERROR.FORMAT] = "must be 2 to 40 characters alphanumeric, and may contain the following special chars:  . , & ( ) ! ? - @ '"

            ###LANG.errors.phone[VALID.ERROR.FORMAT] = 'must be 10 digits'###
            LANG.errors.phone[VALID.ERROR.REQUIRED] = 'phone number is required'

            LANG.errors.email[VALID.ERROR.REQUIRED] = 'email is required'
            LANG.errors.email[VALID.ERROR.SIZE] = 'must be a valid email address with 3 to 70 characters'
            LANG.errors.email[VALID.ERROR.FORMAT] = 'must be alphanumeric, must have @ and period, must be 3 to 70 chars, and may contain following special chars: - . _ +'
            LANG.errors.email[VALID.ERROR.UNIQUE] = 'this email already exists'
            LANG.errors.email[VALID.ERROR.INVALID] = 'Invalid user name format, format should be in the form of email : user@sample.com'

            LANG.errors.confirm_email[VALID.ERROR.REQUIRED] = 'email is required'
            LANG.errors.confirm_email[VALID.ERROR.SIZE] = 'must be a valid email address with 3 to 70 characters'
            LANG.errors.confirm_email[VALID.ERROR.FORMAT] = 'must be alphanumeric, must have @ and period, must be 3 to 70 chars, and may contain following special chars: - . _ +'
            LANG.errors.confirm_email[VALID.ERROR.UNIQUE] = 'this email already exists'
            LANG.errors.confirm_email[VALID.ERROR.INVALID] = 'Invalid user name format, format should be in the form of email : user@sample.com'
            LANG.errors.confirm_email[VALID.ERROR.EQUAL] = 'the email address you entered does not match.'

            LANG
    },
    {
        #create a valid compute whether the form is valid or not
        #the validity is changed when viewmodel changed, because viewmodel listens to errors and we can add more
        #checks too, look at {viewmodel} * change
        init:(elem, options)->
            window.admin_info_form = this
            #this.bind_model_errors_to_viewmodel('admin', options.admin)
            this.render('admin_info_form/admin_info_form', {admin:options.admin})
            this.element.find('input[name="phone"]').mask("(999) 999-9999")
            this.bind_view(options.admin)
            this.set_validity(false)


        'input[name=email] paste':($input, e)->
            e.preventDefault()
            return false

        'input[name=confirm_email] paste':($input, e)->
            e.preventDefault()
            return false

        '{admin.valid} change':()->
            this.set_validity(this.options.admin.valid())

        validate: ()->
            this.options.admin.validate()
            #this.set_validity(validity)
        ###show_all_errors:()->
            this.validate()###
    })
)