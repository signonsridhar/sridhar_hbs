define(['bases/page' ,
    'bases/control',
    'modules/creditcard_info_form/creditcard_info_form',
    'models/shopping_cart/shopping_cart',
    '_',
    'css! pages/onboard/step_3/onboard_step_3'
], (BasePage,BaseControl,CreditCardInfoForm,ShoppingCart, _)->
    BasePage.extend({
    #create a valid compute whether the form is valid or not
    #the validity is changed when viewmodel changed, because viewmodel listens to errors and we can add more
    #checks too, look at {viewmodel} * change
        init:(elem, options)->

            this.render('onboard/step_3/onboard_step_3')
            this.options.creditcard_info_form = new CreditCardInfoForm(this.find('.creditcard_info_container'),{credit_card:options.models.credit_card,tenant: options.models.tenant,admin:options.models.admin})
            this.set_validity(true)
            this.on()

        '{creditcard_info_form.validity} change':()->
            console.log('{creditcard_info_form.validity} change', this.options.creditcard_info_form.get_validity())
            this.set_validity(this.options.creditcard_info_form.get_validity())

        on_next:()->
            this.options.creditcard_info_form.on_next()
            this.options.creditcard_info_form.submit_form()

        on_show:()->
            #this.options.creditcard_info_form.render_iframe()


        show_errors: (show_errors = false)->
            this.options.creditcard_info_form.show_all_errors()

        handle_failure: (data)->
            this.options.creditcard_info_form.handle_failure(data)
            #this.options.creditcard_info_form.render_iframe()
            #this.options.creditcard_info_form.show_server_error(data)

            ###, 1000 )###

    })
)