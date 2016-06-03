define(['bases/control',
        'modules/dt_dialog/dt_dialog',
        'modules/number_selector_search_form/number_selector_search_form',
        'models/phone_number/phone_number',
        'css!modules/company_main_selector/company_main_selector'
], (BaseControl, DTDialog, NumberSelectorSearchForm,  PhoneNumber,  MainCss)->
    BaseControl.extend({
        init: (elem, options)->
            console.log('main selector options init ', options)
            this.phone = new PhoneNumber({format_phone_number:'(xxx)xxx xxxx'})
            this.setup_viewmodel({
            })
            this.render('company_main_selector/company_main_selector', {
                phone: this.phone
            })
            phone_options = {
                zipcode: this.options.models.tenant.primary_address_zip, # TODO
                start_offset: 0,
                country: this.options.models.tenant.primary_address_country,
                partnerid: this.options.models.partner.partner_id,
                count: 1
            }
            #similar to $.extend works on this instance phone model defined above
            #and overrides the values with the raw data from set_promise
            find_promise = PhoneNumber.find_phone_number_by_zipcode(phone_options)
            this.phone.set_promise(find_promise)
            find_promise.done((reserved_did)=>
                if (reserved_did)
                    this.options.models.tenant.attr('main_number', reserved_did.attr())
                    format_ph_num = reserved_did.attr('phonenumber').toString()
                    format_ph_num = format_ph_num.replace(/\d(\d\d\d)(\d\d\d)(\d\d\d\d)/, "($1) $2-$3")
                    this.phone.attr('format_phone_number', format_ph_num)
            ).fail(()=>
                console.log('reserved did failed')
            ).always(()=>
                this.spinner_visibility(false)
            )


            this.loc_num_search = new NumberSelectorSearchForm($('<div class="local_number_selector_search_form_container_js"></div>'),
                {'partnerid': phone_options.partnerid, country: this.options.models.tenant.primary_address_country})
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
            #tollfree dialog
            this.toll_num_search = new NumberSelectorSearchForm($('<div class="toll_number_selector_search_form_container_js"></div>'),
                {'partnerid': phone_options.partnerid, country: this.options.models.tenant.primary_address_country})
            this.toll_dialog = new DTDialog(this.element.find('.toll_num_container_js'),
            {
                content: this.toll_num_search.element,
                settings: {
                    height: 437,
                    width: 700,
                    autoOpen: false,
                    modal: true,
                    buttons:{
                        "Select Number": =>  this.toll_select_number_button()
                        Cancel: => this.toll_cancel_button()
                    }
                }
            })
            this.toll_dialog.show_hide_title(false)
            this.toll_num_search.show_hide_search_form(true)#hide

        spinner_visibility:(is_visible)->
            if is_visible
                this.element.find('.phone_num_spinner').show()
            else
                this.element.find('.phone_num_spinner').hide()

        is_spinner_visible:()->
            this.element.find('.phone_num_spinner').is(":visible")

        reserve_number: (selected_did, $number_selector_dialog, is_toll_free)->
            partner_id = this.options.models.partner.partner_id
            PhoneNumber.reserve_number(selected_did.attr(), partner_id, null).then((reserved_did)=>
                this.unreserve_number()
                #clean the phone attributes and then set the values
                this.phone.attr({},true).attr(reserved_did.serialize())
                console.log('>>>>>> reserved did ',reserved_did, ' tenant main ', this.options.models.tenant.attr('main_number'))
                reserved_did and this.options.models.tenant.attr('main_number', reserved_did.attr())
                console.log('>> tenant main ', this.options.models.tenant.attr('main_number'))
                $number_selector_dialog.close_dialog()
            ).fail((response)=>
                $number_selector_dialog.find('.backend_error').empty().html(response.msg)
                if(is_toll_free)
                    this.refresh_toll()
                else
                    this.refresh_local()
            )



        unreserve_number: ()->
            main_number_did = this.options.models.tenant.value('main_number').didid
            PhoneNumber.unreserve_number(main_number_did).fail((response)=>
                console.log("unreserve phone number failed")
            )

        local_select_number_button:() ->
            phone_did = this.loc_num_search.get_selected()
            if(phone_did)
                this.reserve_number(phone_did, this.loc_dialog, false)

        toll_select_number_button:() ->
            phone_did = this.toll_num_search.get_selected()
            if(phone_did)
                this.reserve_number(phone_did, this.toll_num_search,true)

        local_cancel_button:() ->
            this.loc_dialog.close_dialog()

        toll_cancel_button:() ->
            this.toll_dialog.close_dialog()

        refresh_local: () ->
            if !this.is_spinner_visible()
                city = this.options.models.tenant.primary_address_city
                state = this.options.models.tenant.primary_address_state
                this.loc_num_search.refresh(city, state)
                this.loc_num_search.checkViewModelChange()

        refresh_toll: ()->
            if !this.is_spinner_visible()
                this.toll_num_search.refresh_toll()

        '.main_click_js click': () ->
            this.loc_dialog.open_dialog()
            this.refresh_local()

        '.main_toll_click_js click': () ->
            this.toll_dialog.open_dialog()
            this.refresh_toll()


    })
)