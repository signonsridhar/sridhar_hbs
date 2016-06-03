define(['bases/control',
        '_',
        'modules/dt_dialog/dt_dialog',
        'modules/unassigned_bundle_selector/unassigned_bundle_selector',
        'modules/config_edit_item/group/config_edit_item_group'
        'modules/config_edit_item/line/config_edit_item_line'
        'modules/add_to_call_group/add_to_call_group',
        'models/user/user',
        'models/bundle/bundle',
        'css! modules/config_edit_item/config_edit_item'
], (BaseControl,_, DTDialog, UnassignedBundleSelector, ConfigEditItemGroup, ConfigEditItemLine, AddToCallGroup, User, Bundle)->
    BaseControl.extend({
        LANG: (controller)->
            LANG = {
                errors:{
                    first_name:{}
                    last_name:{}
                    email:{}
                }
            }
            LANG.errors.first_name[VALID.ERROR.SIZE] = 'first name must be 2 to 40 characters'
            LANG.errors.first_name[VALID.ERROR.REQUIRED] = 'first name is required'
            LANG.errors.first_name[VALID.ERROR.FORMAT] = "must be 2 to 40 characters alphanumeric, and may contain the following special chars:  . , & ( ) ! ? - @ '"

            LANG.errors.last_name[VALID.ERROR.SIZE] = 'last name must be 2 to 40 characters'
            LANG.errors.last_name[VALID.ERROR.REQUIRED] = 'last name is required'
            LANG.errors.last_name[VALID.ERROR.FORMAT] = "must be 2 to 40 characters alphanumeric, and may contain the following special chars:  . , & ( ) ! ? - @ '"

            LANG.errors.email[VALID.ERROR.REQUIRED] = 'email is required'
            LANG.errors.email[VALID.ERROR.SIZE] = 'must be a valid email address with 3 to 70 characters'
            LANG.errors.email[VALID.ERROR.FORMAT] = 'must be alphanumeric, must have @ and period, must be 3 to 70 chars, and may contain following special chars: - . _ +'
            LANG.errors.email[VALID.ERROR.UNIQUE] = 'this email already exists'
            LANG.errors.email[VALID.ERROR.INVALID] = 'Invalid user name format, format should be in the form of email : user@sample.com'


            LANG
    },{
        init:(elem, options)->
            this.item = item = this.options.item
            ###this.setup_viewmodel({
                first_name: ''
                last_name: ''
                email: ''
            })###
            if item instanceof User
                console.log('rendering user', item)
                directory = this.options.directory
                this.unassigned_bundles = unassigned_bundles = directory.get_unassigned_bundles()
                if (unassigned_bundles and unassigned_bundles.length)
                    options.item.attr('show_add_line', true)

                #TODO HACK to avoid email validation on render, add email on platform changes to API
                options.item.set_validated_attrs(['first_name', 'last_name'])
                this.render('config_edit_item/config_edit_item_user',
                    {
                        item: options.item,
                        renderer:(elem, index, bundle_elem)=>
                            new ConfigEditItemLine(elem,
                                {item: bundle_elem, directory: this.options.directory, tenant_id: this.options.tenant_id})
                    })
                this.bind_view(options.item)

                this.set_validity(false)

            else if item instanceof Bundle
                directory = this.options.directory
                options.item.attr('show_add_line', false)
                options.item.attr('show_unassign_line', false)
                user = options.user = new User()
                this.render('config_edit_item/config_edit_item_bundle', {user: user})
                this.bind_view(user)
                new ConfigEditItemLine(this.element.find('.bundle_js'),
                {item: this.options.item, directory: this.options.directory, tenant_id: this.options.tenant_id})
                this.set_validity(false)
            else
                new ConfigEditItemGroup(this.element, {item: options.item})
                #this.render('config_edit_item/config_edit_item_group', {item: options.item})

        #user attribute changes
        '{item} first_name change':()->
            this.element.find('.save_user_info_js').show()
        '{item} last_name change':()->
            this.element.find('.save_user_info_js').show()
        '{item} email change':()->
            this.element.find('.save_user_info_js').show()

        #unassign user bundle
        'li.bundle_js .unassign_js click':($el)->
            idx = $el.closest('.bundle_js').data('idx')
            this.viewmodel.attr('unassign', idx + '_' + _.uniqueId())

        '{viewmodel} unassign change':()->
            unassign_idx = this.viewmodel.attr('unassign').split('_')[0]
            this.show_warning(unassign_idx)
            this.disable_other_items_except(unassign_idx)

        #remove bundle
        '.item_warning .confirm_warning_js click':($el)->
            idx = $el.data('idx')
            spliced = this.options.item.bundles.splice(idx, 1)
            if (spliced and spliced[0])
                this.options.item.remove_bundle_for_user(spliced[0].bundle_id).done(()=>
                    console.log(' unassigned item')
                    this.options.directory.load_all(this.options.tenant_id)
                ).fail(()=> #TODO remove
                    this.options.directory.load_all(this.options.tenant_id)
                )

        '.warning_container .reject_warning_js click':(e)->
            this.remove_warning()

        show_warning:(idx)->
            $warning_div = this.get_raw_html('config_edit_item/warning', {idx:idx})
            this.get_item_elements().eq(idx).find('.row_js').append($warning_div)

        get_item_elements:()->
            # user's line elements
            this.element.find('li')

        remove_warning:()->
            this.get_item_elements().find('.list_item_overlay').remove()

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
            elements = elements.not($do_not_overlay).find('.row_js').append(overlay_html)


        '.save_user_info_js click':($el,e)->
            e.stopPropagation()
            this.item.set_name()
            this.item.set_email()



        '.add_user_to_bundle_js click':($el,e)->
            e.stopPropagation()
            user_request = {
                first_name: this.options.user.attr('first_name')
                last_name: this.options.user.attr('last_name')
                email: this.options.user.attr('email')
            }
            this.item.add_user_to_bundle(user_request).done(()=>
                this.options.directory.load_all(this.options.tenant_id)
            ).fail(()=>
                this.options.directory.load_all(this.options.tenant_id)
            )

        '.assign_js click':($el)->
            unless this.assign_bundle
                this.assign_bundle = new UnassignedBundleSelector($('<div class="unassigned_bundle_selector_container_js"></div>'),
                    {'bundles':this.unassigned_bundles})
                this.assign_bundle_dialog = new DTDialog(this.element.find('.unassign_bundle_container_js'),
                    {
                        content: this.assign_bundle.element,
                        settings: {
                            height: 237,
                            width: 400,
                            autoOpen: false,
                            modal: true,
                            buttons:{
                                "Select Bundle": =>  this.select_bundle_button()
                                Cancel: => this.cancel_button()
                            },
                            open: ()->
                                $(this).parent().find('button:contains("Select Bundle")').addClass("select_bundle")
                                $(this).parent().find('button:contains("Cancel")').addClass("cancel_select_bundle")


                        }
                    })
                this.assign_bundle_dialog.show_hide_title(true)

            this.assign_bundle_dialog.open_dialog()
            this.assign_bundle.refresh()


        select_bundle_button:()->
            bundle = this.assign_bundle.get_selected()
            bundle_ids = []
            bundle_ids.push(bundle.bundle_id)
            this.item.add_bundle_for_user(bundle_ids).done(()=>
                this.options.directory.load_all(this.options.tenant_id)
            ).fail(()=>
                #TODO remove
                this.options.directory.load_all(this.options.tenant_id)
            )
            this.assign_bundle_dialog.close_dialog()

        cancel_button:() ->
            this.assign_bundle_dialog.close_dialog()

        '{item.valid} change':()->
            this.set_validity(this.options.item.valid())

        validate: ()->
            this.options.item.validate()

    })
)