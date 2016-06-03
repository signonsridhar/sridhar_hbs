define(['modules/item_list/item_list',
        '_',
        'bases/model/list',
        'models/user/user'
], (ItemList, _, BaseModelList, User)->
    ItemList.extend({
        ###
            items: list of items to render
            renderer: function that gets called on each element that will be rendered
            multi_edit: bool, whether user can edit multiple
        ###
        init:(elem, options)->
            this.setup_viewmodel({
                edit:[]
            })
            this.render('item_list/editable/item_list_editable', {items:options.items, renderer:options.renderer})

        'li.item .edit click':($elem, e)->
            idx = $elem.closest('.item').data('idx')
            this.set_edit_mode(idx)
        'li.item .delete click':($elem, e)->
            idx = $elem.closest('.item').data('idx')
            this.viewmodel.attr('delete', idx + '_' + _.uniqueId())

        '{viewmodel} edit change':()->
            edit_idx = this.viewmodel.attr('edit')
            this.disable_other_items_except(edit_idx)


        '{viewmodel} delete change':()->
            delete_idx = this.viewmodel.attr('delete').split('_')[0]
            this.show_warning(delete_idx)
            this.disable_other_items_except(delete_idx)

        '.item_warning .confirm_warning_js click':($el)->
            idx = $el.data('idx')
            spliced = this.options.items.splice(idx, 1)
            if (spliced and spliced[0])
                spliced[0].delete_item().done ()->
                    console.log(' deleted item')

        '.item_warning .reject_warning_js click':(e)->
            this.remove_warning()


        set_edit_mode:(idx)->
            idx = [idx] if not _.isArray(idx)
            if this.options.multi_edit
                this.viewmodel.attr('edit').push(idx)
            else
                this.viewmodel.attr('edit').replace(idx)
                
        remove_edit_mode:(idx)->
            idx = [idx] if not _.isArray(idx)
            edit_indexes = this.viewmodel.attr('edit').serialize()
            edit_indexes.splice(i, 1) for index, i in idx when edit_indexes.indexOf(index) >= 0
            this.viewmodel.attr('edit', edit_indexes)

        get_item_elements:()->
            this.element.find('>*>*>*')

        show_warning:(idx)->
            $warning_div = this.get_raw_html('item_list/editable/warning', {idx:idx})
            this.get_item_elements().eq(idx).append($warning_div)
        remove_warning:()->
            this.get_item_elements().find('.item_warning').remove()
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
            elements = elements.not($do_not_overlay).append(overlay_html)
        enable_all_items:()->
            this.get_item_elements().find(".#{this._overlay_disable_class}").remove()
    })
)