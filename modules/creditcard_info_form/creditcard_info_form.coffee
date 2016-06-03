define(['bases/control',
        '_',
        'modules/state_list/state_list',
        'models/credit_card/credit_card',
        'models/auth/auth',
        'models/user/user',
        'env!dev:models/credit_card/fixture/aria_post'
],
(BaseControl,_,StateList,CreditCard, Auth, User)->
    BaseControl.extend({
        LANG:()->
            LANG = {}
            errors = {
                cc_no:{}
                CVV:{}
                cc_exp_mm:{}
                cc_exp_yyyy:{}
                bill_first_name:{}
                bill_last_name:{}
                bill_address1:{}
                bill_address2:{}
                bill_city:{}
                bill_state_prov:{}
                bill_zip:{}
            }
            errors.cc_no[VALID.ERROR.REQUIRED] = 'CC number required'
            errors.cc_no[VALID.ERROR.FORMAT] = 'must be a valid credit card number'

            errors.CVV[VALID.ERROR.REQUIRED] = 'CVV number is required'
            errors.CVV[VALID.ERROR.FORMAT] = 'must be a valid CVV number'

            errors.cc_exp_mm[VALID.ERROR.REQUIRED] = 'month is required'

            errors.cc_exp_yyyy[VALID.ERROR.REQUIRED] = 'year is required'

            errors.bill_first_name[VALID.ERROR.SIZE] = 'first name must be 2 to 40 characters'
            errors.bill_first_name[VALID.ERROR.REQUIRED] = 'first name is required'
            errors.bill_first_name[VALID.ERROR.FORMAT] = "must be 2 to 40 characters alphanumeric, and may contain the following special chars:  . , & ( ) ! ? - @ '"

            errors.bill_last_name[VALID.ERROR.SIZE] = 'last name is between 2-40 characters'
            errors.bill_last_name[VALID.ERROR.REQUIRED] = 'last name is required'
            errors.bill_last_name[VALID.ERROR.FORMAT] = "must be 2 to 40 characters alphanumeric, and may contain the following special chars:  . , & ( ) ! ? - @ '"

            errors.bill_address1[VALID.ERROR.REQUIRED] = 'billing address is required'
            errors.bill_address1[VALID.ERROR.SIZE] = 'billing address is between 3-40 characters'

            errors.bill_address2[VALID.ERROR.SIZE] = 'address is between 3-40 characters'

            errors.bill_city[VALID.ERROR.REQUIRED] = 'city is required'
            errors.bill_city[VALID.ERROR.SIZE] = 'city is between 3-20 characters'

            errors.bill_state_prov[VALID.ERROR.REQUIRED] = 'state is required'
            errors.bill_state_prov[VALID.ERROR.SIZE] = 'state is 2 characters'

            errors.bill_zip[VALID.ERROR.REQUIRED] = 'ZIP is required'
            errors.bill_zip[VALID.ERROR.SIZE] = 'ZIP is 5 digit numeric'

            LANG.errors = errors
            LANG

        DATA_MAP:{
            TENANT:{
                bill_address1:'primary_address_street1',
                bill_address2: 'primary_address_street2',
                bill_city: 'primary_address_city',
                bill_state_prov: 'primary_address_state',
                bill_postal_cd: 'primary_address_zip'
            }
            USER:{
                bill_first_name:'first_name',
                bill_last_name: 'last_name'
            }
        }

    },{
        init: (elem, options)->
            if not this.options.admin and Auth.get_auth()
                this.options.admin = new User({
                    'first_name': Auth.get_auth().auth_user.user.first_name,
                    'last_name': Auth.get_auth().auth_user.user.last_name,
                })
            this.cc_form_cache = undefined
            this.cc_submit_promise = new $.Deferred()
            this.getccform_req = {account_id:options.tenant.account_id,partner_code:'tmus'} #TODO partner_code
            this.promise_form().done (cc_form)=>
                this.cc_form = cc_form
                this.render_iframe()
            window.onAddCreditCard = (response)=>
                if(response.dp_response.success == true)
                    this.cc_submit_promise.resolve()
                    return
                else
                    #this.cc_submit_promise.reject(response.dp_response.errors[0])
                    this.handle_failure(response.dp_response.errors)
                            
        promise_form: ()->
            CreditCard.promise_form(this.getccform_req)


                
        render_iframe: ()->
            console.log('#### render IFRAME')

            this.frame = this.element.contents()
            if (this.cc_form_cache)
                frame_doc = this.frame.get(0)
                frame_doc.open()
                frame_doc.write('<html><head><title></title><link rel="stylesheet" type="text/css" href="modules/creditcard_info_form/creditcard_info_form.css"><link rel="stylesheet" type="text/css" href="libs/foundation-4.3.2.custom/css/foundation.css"><link rel="stylesheet" type="text/css" href="libs/foundation-4.3.2.custom/css/normalize.css"></head><body style="overflow:hidden;"></body></html>')
                frame_doc.close()
                cssLink = '<link rel="stylesheet" type="text/css" href="modules/creditcard_info_form/creditcard_info_form.css"><link rel="stylesheet" type="text/css" href="libs/foundation-4.3.2.custom/css/foundation.css"><link rel="stylesheet" type="text/css" href="libs/foundation-4.3.2.custom/css/normalize.css">'
                $('head', frame_doc).append(cssLink)
                this.$frame_body = $frame_body = this.frame.find('body')
                $frame_body.empty().append(this.cc_form_cache)
            else
                frame_doc = this.frame.get(0)
                frame_doc.open()
                console.log('here 1')
                frame_doc.write('<html><head><title></title><link rel="stylesheet" type="text/css" href="modules/creditcard_info_form/creditcard_info_form.css"><link rel="stylesheet" type="text/css" href="libs/foundation-4.3.2.custom/css/foundation.css"><link rel="stylesheet" type="text/css" href="libs/foundation-4.3.2.custom/css/normalize.css"></head><body style="overflow:hidden;"></body></html>')
                console.log('here 2')
                frame_doc.close()
                this.$frame_body = this.frame.find('body')
                frame = this.element.contents()
                this.$frame_body = $frame_body = this.frame.find('body')
                $frame_body.empty().append(this.cc_form)

                #TODO hack remove after platform changes
                $frame_body.find('input.is_tenant_address_js').attr('name', 'same_as_tenant').val(1);

                this.render('creditcard_info_form/cc_exp_year',{}, this.element.find('.cc_exp_year_js'))
                new StateList($frame_body.find('.state_dropdown_container'),{
                    attr: 'bill_state_prov',
                    model: this.options.credit_card
                })
                this.cc_form_cache = $frame_body.html()
            this.bind_view(this.options.credit_card,this.$frame_body)
            this.on()

            ###StateList.load().done (response)=>
                debugger
                this.render('html/abbr_state_options', {states:response}, this.element.find('.cc_address_state_js'))###


        '{credit_card.valid} change':()->
            console.log('{credit_card.valid} change', this.options.credit_card.valid())
            this.set_validity(this.options.credit_card.valid())

        '{credit_card} validity':(e)->
            validity_hash = this.options.credit_card.get_validity_object()
            LANG = this.constructor.LANG()
            $contents = this.element.contents()
            for attr, validity of validity_hash
                $el = $contents.find('input[name="'+attr+'"]')
                $contents.find(".#{attr}_error_js").html(VALID.render(LANG.errors, this.options.credit_card, attr, $el, this.element))

        extract_values_from_mapping:()->
            result = {}
            for type, mapping of this.constructor.DATA_MAP
                model_key = if type == 'USER' then 'admin' else 'tenant'
                console.log('model_key', model_key)
                for cc_attr, other_attr of mapping
                    result[cc_attr] =  this.options[model_key].value(other_attr)

            result

        '{credit_card} same_as_tenant change': ()->
            same_as_tenant = this.options.credit_card.attr('same_as_tenant')
            $cc_form = this.element.contents().find('form')
            values = this.extract_values_from_mapping()
            for cc_attr, value of values
                value = '' if  _.isEmpty(same_as_tenant)
                this.options.credit_card.attr(cc_attr, value)

        submit_form: ()->

            $form = this.element.contents().find('form')
            $form.submit()
            return this.cc_submit_promise

        '{credit_card} cc_no change':()->
            this.identifyCCType()

        identifyCCType: ()->
            $cc_form = this.element.contents().find('form')
            visa_prefix=new RegExp("^4")
            amex_prefix=new RegExp("^3[47]")
            master_prefix=new RegExp("^5[1-5]")
            discover_prefix=new RegExp("^6")
            cc_number = this.options.credit_card.attr('cc_no')
            $cc_form.find('.cc_type_select_js li i').removeClass('card_selected').addClass('card_selectable')
            if(visa_prefix.test(cc_number))
                $cc_form.find('.cc_type_select_js i.visa_js').removeClass('card_selectable').addClass('card_selected')
                $cc_form.find('.cvv_visa_js').removeClass('ccv_hidden')
                $cc_form.find('.cvv_amex_js').addClass('ccv_hidden')
                this.set_cc_no_max_length($cc_form, 16, 3)
            else if(master_prefix.test(cc_number))
                $cc_form.find('.cc_type_select_js i.master_js').removeClass('card_selectable').addClass('card_selected')
                $cc_form.find('.cvv_visa_js').removeClass('ccv_hidden')
                $cc_form.find('.cvv_amex_js').addClass('ccv_hidden')
                this.set_cc_no_max_length($cc_form, 16, 3)
            else if(amex_prefix.test(cc_number))
                $cc_form.find('.cc_type_select_js i.amex_js').removeClass('card_selectable').addClass('card_selected')
                $cc_form.find('.cvv_visa_js').addClass('ccv_hidden')
                $cc_form.find('.cvv_amex_js').removeClass('ccv_hidden')
                this.set_cc_no_max_length($cc_form, 16, 4)
            else if(discover_prefix.test(cc_number))
                $cc_form.find('.cc_type_select_js i.discover_js').removeClass('card_selectable').addClass('card_selected')
                $cc_form.find('.cvv_amex_js').addClass('ccv_hidden')
                $cc_form.find('.cvv_visa_js').removeClass('ccv_hidden')
                this.set_cc_no_max_length($cc_form, 16, 3)
            else
                $cc_form.find(".cc_type_select_js i").each(()->
                    $(this).removeClass("card_selected").addClass("card_selectable")
                )
                this.set_cc_no_max_length($cc_form, 16, 4)

        set_cc_no_max_length:($cc_form, cc_no_max_length, cc_cvv_max_length)->
            $cc_form.find('input[name="cc_no"]').attr("maxlength",cc_no_max_length)
            $cc_form.find('input[name="CVV"]').attr("maxlength",cc_cvv_max_length)
        on_next: ()->
            console.log('removing server errors')
            this.$frame_body.find('.server_error_js').remove()
        show_server_error: (errors)->
            items = []
            error_msgs = _.pluck(errors, 'error_message')
            $.each(error_msgs, (i, msg) ->
                items.push('<li>' + msg + '</li>')
            )
            err_str = $('<p class="server_error_js">').html($('<ul></ul>').append( items.join('') ))
            this.element.contents().find('body').find('.creditcard_container').prepend(err_str)
        handle_failure:(errors)->
            this.render_iframe()
            this.show_server_error(errors)
            #reinitialize form submit promise
            this.cc_submit_promise = new $.Deferred()

    })
)
