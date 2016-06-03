define([
    'bases/control',
    'libs/qtip/qtip',
    'css!modules/qtip/qtip'
], (BaseControl)->
    BaseControl.extend({
        init:(elem, options)->
            debugger
            this.options = options
            this.tool_tip = this.element.qtip(this.options)
            this.api = this.element.qtip('api')


        show_hide_title:(hide)->
            ###if hide
                this.element.parent('.qtip_class').addClass('no_title_js')
            else
                this.element.parent('.qtip_class').removeClass('no_title_js')###

        open_qtip: ()->
            this.api.toggle(true)

        close_qtip: ()->
            this.api.toggle(false)

        modify_qtip_settings:(settings)->
            this.element.qtip(settings)

    })
)