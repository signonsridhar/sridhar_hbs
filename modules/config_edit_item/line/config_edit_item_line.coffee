define(['bases/control',
        '_',
        'modules/add_to_call_group/add_to_call_group',
        'modules/ported_number_selector/ported_number_selector',
        'modules/dt_dialog/dt_dialog',
        'models/user/user',
        'models/bundle/bundle',
        'models/extension/extension'
], (BaseControl,_, AddToCallGroup,PortedNumberSelector,DTDialog,  User, Bundle, Extension)->
    BaseControl.extend({
        init:(elem, options)->
            this.item = this.bundle_elem = options.item
            this.setup_viewmodel(
                this.populate_proxy_helper(this.bundle_elem)
            )
            #render user line
            this.render('config_edit_item/line/config_edit_item_line')
            setTimeout(()=>
                this.bind_view(this.viewmodel)
            , 100)

        populate_proxy_helper:(item)->
            proxy_item ={}
            proxy_item.extension_number = item.attr('extensions.0.extension_number')
            proxy_item.phone_number = item.attr('extensions.0.phone_numbers.0.phonenumber')
            proxy_item.device_name = item.attr('extensions.0.devices.0.device_name')
            proxy_item.group_members = item.attr('extensions.0.group_members')
            proxy_item.show_add_line = item.attr('show_add_line')
            proxy_item.show_unassign_line = item.attr('show_unassign_line')
            proxy_item.number_porting_enabled = item.attr('number_porting_enabled')

            proxy_item

        '.port_number_js click':($el)->

            this.ported_num_search = new PortedNumberSelector($('<div class="ported_number_selector_form_container_js"></div>'),
                {
                    extension: this.options.viewmodel.attr('extension_number'),
                    phonenumberfrom: this.options.viewmodel.attr('phone_number'),
                    tenant_id :this.options.tenant_id,
                    port_number_link : $el
                })


        '.add_to_call_group_js click':($el)->
            unless this.add_to_call_group
                group_members = this.bundle_elem.extensions[0].group_members
                this.add_to_call_group = new AddToCallGroup($('<div class="add_to_call_group_container_js"></div>'),
                    {group_members:group_members, bundle_elem: this.bundle_elem})
                this.add_to_call_group_dialog = new DTDialog($('<div class="add_to_call_group_dialog_container_js" title="Add to Call Group"></div>'),
                {
                    content: this.add_to_call_group.element,
                    settings: {
                        height: 337,
                        width: 400,
                        autoOpen: false,
                        modal: true,
                        buttons:{
                            "Save": =>  this.save_call_group_membership()
                            Cancel: => this.cancel_add_to_call_group()
                        }
                    }
                })
            this.add_to_call_group_dialog.open_dialog()
            this.add_to_call_group.refresh(this.bundle_elem.extensions[0].group_members)

        save_call_group_membership:()->
            this.add_to_call_group.save_call_group_membership().done(()=>
                this.add_to_call_group_dialog.close_dialog()
                this.options.directory.load_all(this.options.tenant_id)
            ).fail(()=>
                #TODO log error
                this.add_to_call_group_dialog.close_dialog()
                this.options.directory.load_all(this.options.tenant_id)
            )

        cancel_add_to_call_group:()->
            this.add_to_call_group_dialog.close_dialog()

        '{viewmodel} extension_number change':()->
            this.element.find('.save_js').show()

        '.save_js click':()->
            from_extension = this.bundle_elem.attr('extensions.0.extension_number')
            to_extension = this.viewmodel.attr('extension_number')
            Extension.change_extension(from_extension, to_extension).done(()=>
                this.element.find('.save_js').hide()
                this.element.find('.check_js').show()
            ).fail(()=>
                #TODO remove, show error
                this.element.find('.check_js').show()
            )

    })
)
