define(['bases/control',
        '_',
        'models/group/group',
        'modules/toggle/toggle',
        'models/voicemail_copy/voicemail_copy',
        'css!modules/set_vm/set_vm'
], (BaseControl,_,Group,Toggle, VoicemailCopy)->
    BaseControl.extend({
        LANG:()->
            errors = {
               email:{}
            }

            LANG = {
               errors:errors
            }

            LANG.errors.email[VALID.ERROR.REQUIRED] = 'email is required'
            LANG.errors.email[VALID.ERROR.SIZE] = 'must be a valid email address with 3 to 70 characters'
            LANG.errors.email[VALID.ERROR.FORMAT] = 'email is invalid'

            LANG = {}
            LANG.send_vm_copy = 'Send copy of voicemails to email address:'
            LANG.enable_vm = 'Enable Voicemail for'
            LANG.vm_tip    = 'allows caller to leave a voicemail.'
            LANG
    },{
        init:(elem, options)->
            this.setup_viewmodel({
                voicemail_forward_email: options.group.attr("voicemail_forward_email")
                enable_voicemail_forward_email: options.group.attr("enable_voicemail_forward_email")
                group_name: options.group.attr('group_name')

            })
            console.log('###extension number', this.options.group.group_extension)
            options.voicemail_copy = this.voicemail_copy = new VoicemailCopy({
                extension:  options.group.attr('group_extension')
                email:     options.group.attr('voicemail_forward_email')
            })
            if(options.group.group_name )
                this.render('set_vm/set_vm',
                    {voicemail_copy: this.voicemail_copy})
                #this.voicemail_copy.set_validated_attrs(['email'])
                this.set_validity(false)
                this.on()

                this.options.vm_switch  = new Toggle(this.find('.vm_switch_js'), {
                    model: this.viewmodel,
                    attr:'enable_voicemail_forward_email'
                })
                this.on()

        '{viewmodel} enable_voicemail_forward_email change':()->
            this.options.group.attr('voicemail_forward_email',this.viewmodel.attr('voicemail_forward_email'))
            this.options.group.attr('enable_voicemail_forward_email',this.viewmodel.attr('enable_voicemail_forward_email'))
            this.options.group.attr('enable_voicemail',this.viewmodel.attr('enable_voicemail_forward_email'))

            req = {
                groupid: this.options.group.attr('groupid')
                voicemail_forward_email: this.options.group.attr('voicemail_forward_email')
                enable_voicemail_forward_email: this.options.group.attr('enable_voicemail_forward_email')
                enable_voicemail: this.options.group.attr('enable_voicemail')

            }
            #updating settings
            this.options.group.update_group_settings(req).done(()=>
            ).fail((resp)=>
                console.log("setgroupsettings api failed")
            )

        ###'input[name="email"] blur':($el,ev)->
            ev.stopPropagation()
            ev.preventDefault()
            this.options.group.attr("voicemail_forward_email",$el.val())###

        validate:()->
            this.options.voicemail_copy.validate()

        '{voicemail_copy.valid} change':()->
            this.set_validity(this.options.voicemail_copy.valid())

        'form submit':()->
            if(this.options.group.attr('voicemail_forward_email'))
                req = {
                    groupid: this.options.group.attr('groupid')
                    voicemail_forward_email: this.options.group.attr('voicemail_forward_email')
                }
                #updating settings
                this.options.group.update_group_settings(req).done(()=>
                ).fail((resp)=>
                    console.log("setgroupsettings api failed")
                )
            return false
    })
)