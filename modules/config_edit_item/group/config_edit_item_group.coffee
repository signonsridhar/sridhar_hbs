define(['bases/control',
        '_',
        'models/user/user',
        'models/bundle/bundle',
        'models/extension/extension',
        'css! modules/config_edit_item/group/config_edit_item_group'
], (BaseControl,_, DTDialog,  User, Bundle, Extension)->
    BaseControl.extend({
        init:(elem, options)->
            this.render('config_edit_item/group/config_edit_item_group', {item: options.item})

        '.edit_group_js click':()->
            window.location = can.route.url({ main:'group_settings',group_id:this.options.item.attr('groupid') })
    })
)