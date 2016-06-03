define(['modules/item/view/item_view_base'], (BaseItemView)->
    BaseItemView.extend({
        init:(elem, options)->
            this._super.apply(this, arguments)
            this.render('item/view/user/item_view_user', {item: options.item})
            this.bind_view(options.item)

        'input[name="first_name"] blur, input[name="last_name"] blur':($el, e)->
            e.stopPropagation()
            this.options.item.set_name()

        '{item} first_name change':()->
            console.log('{item} name change')
        '{item} last_name change':()->
            console.log('{item} name change')


    })
)