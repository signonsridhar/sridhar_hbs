define(['modules/item/edit/item_edit_base'], (ItemEditBase)->
    ItemEditBase.extend({
        init:(elem, options)->
            console.log('options.item >>>>>>', options.item)
            this.backup_bundles = this.options.item.bundles.serialize();
            console.log('backup bundles ', this.backup_bundles, ' length', this.backup_bundles.length)
            this.render('item/edit/user/item_edit_user', {item: options.item})
            this.bind_view(options.item)

        '{item} change':()->
            console.log('edit was done')
        #unassign bundle
        'li.bundle .unassign click':($el)->
            idx = $el.closest('.bundle').data('idx')
            spliced = this.options.item.bundles.splice(idx, 1)

        'form submit':($el)->
            email = $el.find('input[name=email]').val()
            this.diff_backup()
            return false

        diff_backup:()->
            console.log('backup bundles ', this.backup_bundles.length)
            console.log('changed bundles ', this.options.item.bundles.length)

    })
)