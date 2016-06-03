define(['bases/control'], (BaseControl)->
    BaseControl.extend({
        init:(elem, options)->
            this.render('item_list/item_list', {items:options.items, renderer:options.renderer})
    })
)