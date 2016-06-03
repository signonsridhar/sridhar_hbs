define(['bases/control'], (BaseControl)->
    BaseControl.extend({
        LANG:()->
            LANG = {}
            LANG.title = 'For "<%= name %>" calls, ring extension:'
            LANG
    },{
    init:(elem, options)->

        this.setup_viewmodel({
            extensions: options.settings.get_extension_choices_for_group()
        })

        this.render('settings/ring_extension/ring_extension', {name: this.options.model.get_name()})

    })
)