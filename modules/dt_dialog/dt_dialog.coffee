define([
    'bases/control',
    'css!modules/dt_dialog/dt_dialog'
], (BaseControl)->
    BaseControl.extend({
        init:(elem, options)->
            this.element.html(options.content)
            options.settings.dialogClass = 'dt_dialog'
            this.element.dialog(options.settings)

        show_hide_title:(hide)->
            if hide
                this.element.parent('.dt_dialog').addClass('no_title_js')
            else
                this.element.parent('.dt_dialog').removeClass('no_title_js')

        open_dialog: ()->
            this.element.dialog("open")

        close_dialog: ()->
            this.element.dialog('close')

        modify_dialog_settings:(settings)->
            this.element.dialog(settings)

    })
)