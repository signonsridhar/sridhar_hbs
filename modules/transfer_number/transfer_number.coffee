define(['bases/control',
        'models/phone_number/phone_number',
        'modules/dt_dialog/dt_dialog',
        '_'
], (BaseControl, PhoneNumber, DTDialog, _)->
    BaseControl.extend({
        init: (elem, options)->
            console.log('number transfer ', options)
            this.setup_viewmodel({
            })

            this.dialog_init()

        dialog_init: () ->
            this.render('transfer_number/transfer_number')
            this.transfer_number_dialog = new DTDialog(this.element.find('.transfer_number_container_js'),
            {
                settings: {
                    height: 337,
                    width: 400,
                    autoOpen: false,
                    modal: true,
                    buttons:{
                        "Transfer Number": =>  this.select_number_transfer_button()
                        Cancel: => this.cancel_number_transfer_button()
                    },
                    open: () ->
                        $(this).parent().find('.ui-dialog-buttonpane button:contains("Transfer Number")').addClass('transfer');
                        $(this).parent().find('.ui-dialog-buttonpane button:contains("Cancel")').addClass('cancel');

                }
            })
            this.transfer_number_dialog.show_hide_title(false)

        select_number_transfer_button:() ->
            this.transfer_number_dialog.close_dialog()
            if(this.options.is_logged_in)
                PhoneNumber.request_number_porting(this.options.tenant_id).done((response)=>
                    console.log("number porting request success")
                ).fail(()=>
                    console.log("porting request failed")
                )
                return false
            else
                this.options.tenant.attr('number_porting_enabled', true)
                this.render('transfer_number/transfer_number_selected')
                #call transfer number API

        cancel_number_transfer_button:() ->
            if(!this.options.is_logged_in)
                this.options.tenant.attr('number_porting_enabled', false)
            this.transfer_number_dialog.close_dialog()

        open_dialog:()->
            this.transfer_number_dialog.open_dialog()

        #onboarding want to keep transfer number link
        '.transfer_number_link click': () ->
            this.open_dialog()

        #onboarding cancel transfer link
        '.cancel_transfer_link click': () ->
            this.dialog_init()
    })
)


