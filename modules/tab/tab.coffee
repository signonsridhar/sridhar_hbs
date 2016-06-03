define([
    'bases/control',
    'css! modules/tab/tab'
],(BaseControl)->
    BaseControl.extend({
    }, {
        ###
            type: see set_type
            tabs: see set_tabs
            css: will be appended as css classes of the container for further styling

        ###
        init:(elem, options)->

            this.setup_viewmodel()
            this.active = this.options.active = can.compute()

            this.set_tabs(options.tabs)
            this.set_css(options.css)
            this.set_type(options.type)
            this.render("tab/tab", {active: this.active})
        ###
            format of tabs is:
            {
                map:{
                    tab_1: 'Tab One'
                }
                renderer: (key, value)->
                    return <a href="">key</a>

            }
        ###
        ###
        type: one of these 'default', 'vertical', etc (http://foundation.zurb.com/old-docs/f3/tabs.php)
        ###
        set_type:(type = 'default')->
            this.viewmodel.attr('type', type)
        set_tabs: (tabs)->
            return if not tabs?
            this.tabs = tabs
            this.viewmodel.attr('tabs',  tabs)
        set_css:(css)->
            this.viewmodel.attr('css', css)
        '{active} change':()->
            can.trigger(this, 'change', {active: this.viewmodel.attr('active')})
        set_active:(tab)->
            this.find("input[type=radio]").prop('checked', false).filter("[value='#{tab}']").prop('checked', true)

        'input[type="radio"] change':(elem)->
            $label_container = $(elem).next()
            tabs = this.viewmodel.attr().tabs
            key = $label_container.data('key')
            tabs.change(key, tabs.map[key])
    })
)
