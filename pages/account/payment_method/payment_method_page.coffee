define([
    'bases/page',
    'modules/creditcard_info_form/creditcard_info_form',
    'models/credit_card/credit_card',
    'modules/notification/notification',
    'css!pages/account/payment_method/payment_method_page'
], (BasePage,CreditCardInfoForm, CreditCard,Notification)->
    BasePage.extend({
        init: (elem, options)->
            this.setup_viewmodel({
                credit_card: {}
                tenant: this.options.models.tenant
                account: this.options.models.account
            })
            this.options.models.account.get_creditcard_for_account().done( (response)=>
                this.viewmodel.attr('credit_card',response)
            )


        '{viewmodel} credit_card change':()->
            console.log("view cc")
            this.render('account/payment_method/payment_method_page')
            this.bind_view(this.viewmodel)
            this.on()

        '.change_cc_card click':($el, e)->
            this.render('account/payment_method/add_credit_card_page')
            credit_card = new CreditCard({bill_country:'US'})
            credit_card.set_mode(CreditCard.MODE.ARIA)
            this.options.creditcard_info_form = new CreditCardInfoForm(this.element.find('.creditcard_info_container'),
                {credit_card: credit_card,tenant: this.viewmodel.attr('tenant')})
            #this.set_validity(false) TODO needed?
            this.on()

        '{creditcard_info_form.validity} change':()->
            console.log('{creditcard_info_form.validity} change', this.options.creditcard_info_form.get_validity())
            this.set_validity(this.options.creditcard_info_form.get_validity())

        '.submit_cc_form click':()->
            #this.show_errors()
            console.log("submit cc form")
            this.options.creditcard_info_form.submit_form()
            window.onAddCreditCard = (response)=>
                if(response.success == true)
                    #display status
                    $('.cc_status_info_js').hide()
                    $('.credit_card_updated_js').empty().append("credit card updated ").show().delay(5000).fadeOut('slow')
                    this.viewmodel.attr('account').get_creditcard_for_account().done( (response)=>
                        this.viewmodel.attr('credit_card',response)
                    )
                else
                    console.log("credit card not added")
                return

        show_errors: (show_errors = false)->
            this.options.creditcard_info_form.show_all_errors()

    })
)