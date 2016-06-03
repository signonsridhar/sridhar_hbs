define(['modules/item/view/item_view_base'], (BaseItemView)->
    BaseItemView.extend({
        init:(elem, options)->
            this._super.apply(this, arguments)
            this.render('item/view/group/item_view_group', {item: options.item})
    })
)