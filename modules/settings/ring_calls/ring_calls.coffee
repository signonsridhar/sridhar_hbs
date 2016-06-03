define(['modules/enable_disable_form/enable_disable_form',
        'modules/toggle/toggle'
], (EnableDisableForm, Toggle)->

    EnableDisableForm.extend({
        LANG:()->
            LANG = {}
            LANG.title = 'Ring extension'
            LANG.group_calls = 'for "<%= name %>" calls:'
            LANG
    }, {
        init:(elem, options)->
            this._super(elem, options)
            extensions = this.options.settings.get_extension_choices_for_group()
            this.render('settings/ring_calls/ring_calls', {name:options.model.attr('group_name')})
            this.viewmodel.attr({
                extension: options.model.attr('member_extension_number')
                enable_phone_ring: options.model.attr('enable_phone_ring')
                groupid: options.model.attr('groupid')
                member_extensionid: options.model.attr('member_extensionid')

            })

            #this.options.model.attr('ring_calls', false)
            this.options.toggle = new Toggle(this.find('.group_ring_switch_js'), {
                model: this.viewmodel,
                attr:'enable_phone_ring'
            })

        '{viewmodel} enable_phone_ring change':()->
            #regular group set toggle switch for ring members
            req = {
                groupid: this.viewmodel.attr('groupid'),
                member_extensionid: this.viewmodel.attr('member_extensionid'),
                enable_phone_ring: this.viewmodel.attr('enable_phone_ring')
            }
            $.post('/bss/group?action=updategroupmembersettings', JSON.stringify(req))

    })
)