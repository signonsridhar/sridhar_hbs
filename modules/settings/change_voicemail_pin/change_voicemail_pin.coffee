define(['bases/control', 'models/auth/auth', 'models/voicemail_pin/voicemail_pin'],
(BaseControl, Auth, VoiceMailPin)->
    BaseControl.extend({
        LANG:()->

            errors = {
                new_pin:{},
                confirm_pin:{}
            }

            LANG = {
                errors:errors
            }
            errors.new_pin[VALID.ERROR.REQUIRED] = 'new pin is required'
            errors.new_pin[VALID.ERROR.FORMAT] = 'must be 4 digits'
            errors.confirm_pin[VALID.ERROR.REQUIRED] = 'confirm pin is required'
            errors.confirm_pin[VALID.ERROR.FORMAT] = 'must be 4 digits'

            LANG.title = 'Change voicemail PIN for ext <%= ext %> to:'
            LANG.info = 'Voicemail PIN must be a 4 digit number'
            LANG.enter_pin = 'Enter new PIN'
            LANG.confirm_pin = 'Confirm PIN'
            LANG.change = 'Change'
            LANG
    },{
        init:(elem, options)->
            this.options.voicemail_pin = options.voicemail_pin = new VoiceMailPin({
                extension : this.options.model.attr('extension_number')
            })
            this.render('settings/change_voicemail_pin/change_voicemail_pin',
                {voicemail_pin: options.voicemail_pin} )
            this.bind_view(options.voicemail_pin)
            this.options.voicemail_pin.set_validated_attrs(['new_pin', 'confirm_pin'])
            this.set_validity(false)

        validate: ()->
            this.options.voicemail_pin.validate()


        '{voicemail_pin.valid} change': ()->
            this.set_validity(this.options.voicemail_pin.valid())

        'form submit':()->
            raw_data = this.options.voicemail_pin.serialize()
            raw_data.tenantid = Auth.get_auth().attr('tenant_id')
            try
                if(this.options.models && this.options.models.group.attr('groupid'))
                    raw_data.group_id = this.options.models.group.attr('groupid')
                    this.options.settings.change_group_vmpin(raw_data).then(()=>
                        this.options.model.attr('pin', raw_data.new_pin)
                    )
                else
                    this.viewmodel.attr('errors.pin', null)
                    this.options.settings.change_user_vmpin(raw_data).then(()=>
                        this.options.model.attr('pin', raw_data.new_pin)
                    )
            catch e
                msg = ''
                switch e.message
                    when VALID.ERROR.EQUAL
                        msg = 'please retype the pin'

                this.viewmodel.attr('errors.pin', msg)

            return false

    })
)