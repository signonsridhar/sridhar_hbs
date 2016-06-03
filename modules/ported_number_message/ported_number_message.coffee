define(['bases/control',
        '_',
        'models/phone_number/phone_number'
        'css! modules/ported_number_message/ported_number_message'
], (BaseControl,_,PhoneNumber)->
    BaseControl.extend({
        init:(elem, options)->
            this.setup_viewmodel({
                count_of_ported_numbers: 0
            })
            LANG = {
                ported_numbers_available: 'The phone numbers you requested to transfer are now available. Replace'
                phone_number: 'phone number'
                phone_numbers: 'phone numbers'
                existing_lines: 'in your existing lines.'

            }
            this.viewmodel.attr_promise('phone_list', PhoneNumber.get_ported_numbers(options.tenant_id))
            this.render('ported_number_message/ported_number_message', {LANG: LANG})
            this.on()


        '{viewmodel} phone_list change':()->
            if(this.viewmodel.attr('phone_list').length)
                this.viewmodel.attr('count_of_ported_numbers',this.viewmodel.attr('phone_list').length)

    })
)