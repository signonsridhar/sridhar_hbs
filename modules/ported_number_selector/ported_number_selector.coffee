define(['bases/control',
        'models/phone_number/phone_number',
        '_',
        'modules/dt_dialog/dt_dialog',
        'modules/ported_number_message/ported_number_message',
        'models/extension/extension'
], (BaseControl, PhoneNumber, _, DTDialog, PortedNumberMessage, Extension)->
    BaseControl.extend({
        init: (elem, options)->
            this.setup_viewmodel({
                phone_list: []
            })
            tenant_id = this.options.tenant_id
            this.viewmodel.attr_promise('phone_list', PhoneNumber.get_ported_numbers(tenant_id))

            this.ported_number_dialog = new DTDialog($('<div class="ported_num_container_js" title="Replace Number"></div>'),
            {
                content: this.element,
                settings: {
                    autoOpen: false,
                    modal: true,
                    buttons:{
                        "Select Number": =>  this.ported_number_select_button()
                        Cancel: => this.ported_number_cancel_button()
                    }
                }
            })

        '{viewmodel} phone_list change':()->
            if(this.viewmodel.attr('phone_list').length)
                this.ported_number_dialog.open_dialog()
                this.render('ported_number_selector/ported_number_selector')
                this.bind_view(this.viewmodel)
                this.$number_list = this.find('.number_list_js')


        '{viewmodel} selected change': ()->
            phone_list = this.viewmodel.attr('phone_list')
            did_obj = this.viewmodel.selected
            index = phone_list.indexOf(did_obj)
            console.log('index :', index)
            this.$number_list.find('ul').children().removeClass('selected_js')
            nth_child = this.$number_list.find('.choice_js:nth-child('+(index+1)+')')
            nth_child.addClass('selected_js')


        '.number_list_js .choice_js click':(elem)->
            index = elem.data('index')
            console.log('index ', index)
            did_obj = this.viewmodel.phone_list[index]
            console.log('did_obj ', did_obj)
            this.viewmodel.attr('selected', did_obj )

        get_selected: ()->
            this.options.viewmodel.selected

        ported_number_select_button:()->
            LANG = {
                you_are_replacing_msg: 'You are replacing'
                with_msg: 'with',
                duration_info: 'will continue to ring this line for another 30 days.'
            }
            this.ported_number_dialog.modify_dialog_settings({
                autoOpen: false,
                modal: true,
                buttons:{
                    "Replace Number": =>  this.ported_number_confirm_button()
                    Cancel: => this.ported_number_cancel_button()
                }}
            )
            this.render('ported_number_selector/ported_number_confirmation', {LANG:LANG, phonenumberfrom: this.options.phonenumberfrom})


        ported_number_confirm_button: ()->
            phone_did = this.get_selected()
            if(phone_did)
                req = {
                    tenant_id: this.options.tenant_id,
                    extension: this.options.extension,
                    old_phone_number: this.options.phonenumberfrom,
                    new_phone_number: phone_did.phonenumber
                }
                console.log(req)

                Extension.add_ported_phonenumber_for_extension(req).then(()=>
                    this.options.port_number_link.hide()
                    window.location.reload(true);
                    #this.options.phonenumberfrom = phone_did.phonenumber
                    #this.ported_msg = new PortedNumberMessage($('.ported_numbers_msg_js'),{tenant_id: this.options.tenant_id})

                ).fail(()=>
                    #TODO remove, show error
                )

            this.ported_number_dialog.close_dialog()


        ported_number_cancel_button:()->
            this.ported_number_dialog.close_dialog()


    })
)
