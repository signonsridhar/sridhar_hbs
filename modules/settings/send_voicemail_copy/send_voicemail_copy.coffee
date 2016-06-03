define(['modules/enable_disable_form/enable_disable_form',
        'modules/toggle/toggle',
        'models/auth/auth',
        'models/voicemail_copy/voicemail_copy'
], (EnableDisableForm, Toggle,Auth, VoicemailCopy)->
    EnableDisableForm.extend({
       LANG:()->
           errors = {
               email:{}
           }

           LANG = {
               errors:errors
           }

           LANG.errors.email[VALID.ERROR.REQUIRED] = 'email is required'
           LANG.errors.email[VALID.ERROR.SIZE] = 'must be a valid email address with 3 to 70 characters'
           LANG.errors.email[VALID.ERROR.FORMAT] = 'must be alphanumeric, must have @ and period, must be 3 to 70 chars, and may contain following special chars: - . _ +'
           LANG.errors.email[VALID.ERROR.UNIQUE] = 'this email already exists'
           LANG.errors.email[VALID.ERROR.INVALID] = 'Invalid user name format, format should be in the form of email : user@sample.com'


           LANG.title = 'Send copy of voicemails for extension <%= ext %> to:'
           LANG
    }, {
        init:(elem, options)->

            this._super(elem, options)
            options.voicemail_copy = new VoicemailCopy({
                extension:  options.model.attr('extension_number')
                email:     options.model.attr('email')
            })
            this.render('settings/send_voicemail_copy/send_voicemail_copy',
                {voicemail_copy: options.voicemail_copy})
            this.bind_view(options.voicemail_copy)
            #console.log('hererere', options.model.attr())
            this.viewmodel.attr({
                enabled:    options.model.attr('vm_forwarding_enabled')
            })

            this.options.toggle = new Toggle(this.find('.toggle_container_js'), {
                model: this.viewmodel
                attr: 'enabled'
            })
            this.options.voicemail_copy.set_validated_attrs(['email'])
            this.set_validity(false)

        'form submit':()->
            try
                data = this.options.voicemail_copy.attr()
                data.enabled = this.viewmodel.attr('enabled')
                data.tenantid = Auth.get_auth().attr('tenant_id')
                this.options.settings.forward_call_to_email(data)
                is_error = false
            catch e
                is_error = true

            this.viewmodel.attr('errors.email_required', is_error)
            return false
    })
)