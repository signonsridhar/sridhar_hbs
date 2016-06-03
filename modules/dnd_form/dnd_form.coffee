define([
    'bases/control',
    'models/auth/auth',
    'modules/toggle/toggle',
    'css!modules/dnd_form/dnd_form'
], (BaseControl, Auth, Toggle)->
    BaseControl.extend({
        LANG:()->
            LANG = {}
            LANG.title = 'Do Not Disturb'
            LANG.info = 'Send all calls to voicemail'
            LANG
    }, {
        init:()->
            this.render('dnd_form/dnd_form')
            this.options.toggle = new Toggle(this.find('.toggle_container'), {
                model: this.viewmodel,
                attr: 'toggle'
            })
            this.options.toggle.set_value(this.options.settings.get_dnd_flag())
        '{viewmodel} change':()->
            this.options.settings.toggle_dnd(this.viewmodel.attr('toggle'), Auth.get_auth().attr('tenant_id'))
    })
)