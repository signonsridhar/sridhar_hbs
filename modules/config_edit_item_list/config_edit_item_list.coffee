define(['bases/control',
        '_',
        'modules/config_edit_item/config_edit_item',
        'bases/model/list',
        'models/user/user',
        'models/phone_number/phone_number',
        'css!modules/config_edit_item_list/config_edit_item_list'
], (BaseControl,_,ConfigEditItem,BaseModelList,User,PhoneNumber)->
    BaseControl.extend({
        init:(elem, options)->
            this.setup_viewmodel({})
            this.render('config_edit_item_list/config_edit_item_list', {
                    items: options.items,
                    renderer:(elem, index,item)->
                        console.log('???config edit item tenant_id ', options.tenant_id)
                        new ConfigEditItem(elem,
                            {item: item, directory: options.directory, tenant_id: options.tenant_id, ported_phone_numbers: options.ported_phone_numbers})
                })

            this.on()

        'li.config_edit_item_js .edit_js click':($elem, e)->
            idx = $elem.closest('.config_edit_item_js').data('idx')
            this.viewmodel.attr('edit', idx + '_' + _.uniqueId())


        '{viewmodel} edit change':($el)->
            edit_idx = this.viewmodel.attr('edit').split('_')[0]
            idx = $el.data('idx')
            spliced = this.options.items.splice(idx, 1)
            if (spliced and spliced[0])
                spliced[0].edit_item().done(()->
                    console.log(' edit item')
                ).fail(()->
                    console.log(' edit item failed')
                )
        'li.config_edit_item_js .delete_js click':($elem, e)->
            idx = $elem.closest('.config_edit_item_js').data('idx')
            this.viewmodel.attr('delete', idx + '_' + _.uniqueId())

        'li.config_edit_item_js .delete_bundle_js click':($elem, e)->
            idx = $elem.closest('.config_edit_item_js').data('idx')
            this.viewmodel.attr('delete_bundle', idx + '_' + _.uniqueId())

        '{viewmodel} delete_bundle change':()->
            delete_idx = this.viewmodel.attr('delete_bundle').split('_')[0]
            this.show_warning_bundle(delete_idx)
            this.disable_other_items_except(delete_idx)

        show_warning_bundle:(idx)->
            $warning_div = this.get_raw_html('config_edit_item_list/warning_bundle', {idx:idx})
            this.get_item_elements().eq(idx).find('.overlay_js').append($warning_div)

        ' .confirm_delete_bundle_js click':($el)->
            idx = $el.data('idx')

            spliced = this.options.items.splice(idx, 1)
            if (spliced and spliced[0])
                spliced[0].delete_item(this.options.tenant_id).done(()->
                    console.log(' deleted item')
                ).fail(()->
                    console.log(' delete item failed')
                )

        '{viewmodel} delete change':()->
            delete_idx = this.viewmodel.attr('delete').split('_')[0]
            this.show_warning(delete_idx)
            this.disable_other_items_except(delete_idx)

        '.confirm_warning_js click':($el)->
            idx = $el.data('idx')
            spliced = this.options.items.splice(idx, 1)
            if (spliced and spliced[0])
                spliced[0].delete_item().done(()=>
                    console.log(' deleted item')
                    this.options.directory.load_all(this.options.tenant_id)
                ).fail(()=>
                    console.log(' delete item failed')
                    #this.options.directory.load_all(this.options.tenant_id)
                )

        '.item_warning .reject_warning_js click':(e)->
            this.remove_warning()

        show_warning:(idx)->
            $warning_div = this.get_raw_html('config_edit_item_list/warning', {idx:idx})
            this.get_item_elements().eq(idx).find('.overlay_js').append($warning_div)

        get_item_elements:()->
            this.element.find('>*>*>*')

        remove_warning:()->
            this.get_item_elements().find('.item_warning, .item_disabled').remove()

        disable_other_items_except:(except)->
            #put an invisible overlay
            this._overlay_disable_class = _.uniqueId('overlay_')
            overlay_html = "<div class='#{this._overlay_disable_class} list_item_overlay item_disabled'></div>"
            elements = this.get_item_elements()
            $do_not_overlay = $([])
            except =[except]
            $.each(except,(index, each_except)->
                $do_not_elem = elements.eq(parseInt(each_except))
                $do_not_overlay = $do_not_overlay.add($do_not_elem)
            )
            elements = elements.not($do_not_overlay).find('.overlay_js').append(overlay_html)
        enable_all_items:()->
            this.get_item_elements().find(".#{this._overlay_disable_class}").remove()



    })
)