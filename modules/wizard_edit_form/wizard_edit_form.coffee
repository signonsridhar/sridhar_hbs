define(['bases/control',
        '_',
        'modules/dt_dialog/dt_dialog',
        'modules/number_selector_search_form/number_selector_search_form',
        'models/phone_number/phone_number',
        'models/phone/phone',
        'modules/phone_selector_search_form/phone_selector_search_form',
        'models/directory/directory',
        'models/auth/auth'
], (BaseControl,_, DTDialog, NumberSelectorSearchForm,PhoneNumber,Phone,PhoneSelectorSearchForm,Directory,Auth)->
    BaseControl.extend({
        LANG: (controller)->
            LANG = {
                errors:{
                    first_name:{}
                    last_name:{}
                    email:{}
                    extension:{}
                }
            }

            LANG.errors.first_name[VALID.ERROR.SIZE] = 'must be between 2-40 characters'
            LANG.errors.first_name[VALID.ERROR.REQUIRED] = 'first name is required'
            LANG.errors.first_name[VALID.ERROR.FORMAT] = "must be 2 to 40 characters alphanumeric, and may contain the following special chars:  . , & ( ) ! ? - @ '"

            LANG.errors.last_name[VALID.ERROR.SIZE] = 'must be between 2-40 characters'
            LANG.errors.last_name[VALID.ERROR.REQUIRED] = 'last name is required'
            LANG.errors.last_name[VALID.ERROR.FORMAT] = "must be 2 to 40 characters alphanumeric, and may contain the following special chars:  . , & ( ) ! ? - @ '"

            LANG.errors.email[VALID.ERROR.REQUIRED] = 'email is required'
            LANG.errors.email[VALID.ERROR.SIZE] = 'must be a valid email address with 3 to 70 characters'
            LANG.errors.email[VALID.ERROR.FORMAT] = 'must be alphanumeric, must have @ and period, must be 3 to 70 chars, and may contain following special chars: - . _ +'
            LANG.errors.email[VALID.ERROR.UNIQUE] = 'this email already exists'
            LANG.errors.email[VALID.ERROR.INVALID] = 'Invalid user name format, format should be in the form of email : user@sample.com'


            LANG.errors.extension[VALID.ERROR.REQUIRED] = 'extension is required'
            LANG
    },{
        init:(elem, options)->

            this.setup_viewmodel(
                this.populate_proxy_helper(options)
            )
            this.render('wizard_edit_form/wizard_edit_form')
            this.bind_view(this.viewmodel)

            this.on()

            this.set_validity(false)

            this.loc_num_search = new NumberSelectorSearchForm($('<div class="local_number_selector_search_form_container_js"></div>'),
            {
                'partnerid': options.phone_options.partnerid, country: 'US'
            })

            this.loc_dialog = new DTDialog(this.element.find('.local_num_container_js'),
            {
                content: this.loc_num_search.element,
                settings: {
                    height: 437,
                    width: 700,
                    autoOpen: false,
                    modal: true,
                    buttons:{
                        "Select Number": =>  this.local_select_number_button()
                        Cancel: => this.local_cancel_button()
                    }
                }
            })
            this.loc_dialog.show_hide_title(false)
            this.phone_search = new PhoneSelectorSearchForm($('<div class="phone_selector_search_form_container_js"></div>'),
            {
                'partnerid': options.phone_options.partnerid, country: 'US'
            })
            this.phone_dialog = new DTDialog(this.element.find('.phone_container_js'),
            {
                content: this.phone_search.element,
                settings: {
                    height: 237,
                    width: 400,
                    autoOpen: false,
                    modal: true,
                    buttons:{
                        "Select Phone": =>  this.select_phone_button()
                    }
                }
            })
            this.phone_dialog.show_hide_title(false)

        '.main_click_js click': () ->
            this.loc_dialog.open_dialog()
            this.refresh_local()

        '.phone_options_click_js click': () ->
            this.phone_dialog.open_dialog()
            this.phone_search.refresh()

        populate_proxy_helper:(options)->
            proxy_item ={}
            item = options.bundle
            proxy_item.first_name = item.attr('user.first_name')
            proxy_item.last_name = item.attr('user.last_name')
            proxy_item.email = item.attr('user.email')
            proxy_item.extension_number = item.attr('extensions.0.extension_number')
            proxy_item.device_name = item.attr('extensions.0.devices.0.device_name')
            proxy_item.phone_number = item.attr('extensions.0.phone_numbers.0.phonenumber')
            proxy_item.old_didid = item.attr('extensions.0.phone_numbers.0.didid')
            #disable first row of wizard admin
            if(!options.index && can.route.attr('main') == 'wizard')
                proxy_item.admin_disabled = 'disabled'

            proxy_item

        '{viewmodel} first_name change':()->
            this.options.bundle.attr('user.first_name',this.viewmodel.attr('first_name'))

        '{viewmodel} last_name change':()->
            this.options.bundle.attr('user.last_name',this.viewmodel.attr('last_name'))

        '{viewmodel} email change':()->
            this.options.bundle.attr('user.email',this.viewmodel.attr('email'))

        '{viewmodel} extension_number change':()->
            this.options.bundle.attr('extensions.0.extension_number',this.viewmodel.attr('extension_number'))

        spinner_visibility:(is_visible)->
            if is_visible
                this.element.find('.phone_num_spinner').show()
            else
                this.element.find('.phone_num_spinner').hide()

        is_spinner_visible:()->
            this.element.find('.phone_num_spinner').is(":visible")

        reserve_number: (selected_did, $number_selector_dialog)->
            partner_id = this.options.phone_options.partnerid
            PhoneNumber.reserve_number(selected_did.attr(), partner_id, null).then((reserved_did)=>
                #unreserving previously selected didid
                this.unreserve_number()
                console.log(arguments)
                this.options.bundle.attr('extensions.0.phone_numbers.0',reserved_did.attr())
                this.options.bundle.attr('extensions.0.phone_numbers.0.olddidid',this.viewmodel.attr('old_didid'))
                #updating viewmodel
                this.viewmodel.attr('phone_number',reserved_did.attr('phonenumber'))
                $number_selector_dialog.close_dialog()
            ).fail((response)=>
                $number_selector_dialog.find('.backend_error').empty().html(response.msg)
                this.refresh_local()
            )

        unreserve_number: ()->
            existing_phone_number_did = this.options.bundle.attr('extensions.0.phone_numbers.0.didid')
            if( existing_phone_number_did && existing_phone_number_did !=  this.viewmodel.attr('old_didid'))
                PhoneNumber.unreserve_number(existing_phone_number_did).fail((response)=>
                    console.log("unreserve phone number failed")
                )

        local_select_number_button:() ->
            selected_phone_number_did = this.loc_num_search.get_selected()
            existing_phone_number_did = this.options.bundle.attr('extensions.0.phone_numbers.0.didid')
            if(selected_phone_number_did)
                this.reserve_number(selected_phone_number_did, this.loc_dialog)

        local_cancel_button:() ->
            this.loc_dialog.close_dialog()

        refresh_local: () ->
            if !this.is_spinner_visible()
                city = this.options.phone_options.city
                state = this.options.phone_options.state
                this.loc_num_search.refresh(city, state)
                this.loc_num_search.checkViewModelChange()

        select_phone_button:() ->
            phone_did = this.phone_search.get_selected()
            if(phone_did)
                this.options.bundle.attr('extensions.0.devices.0.device_name',phone_did.attr('name'))
                this.options.bundle.attr('extensions.0.devices.0.product_sku', phone_did.attr('sku'))
                this.options.bundle.attr('extensions.0.devices.0.productid',phone_did.attr('product_id'))
                #updating viewmodel
                this.viewmodel.attr('device_name',phone_did.attr('name'))


            this.phone_dialog.close_dialog()

    })
)