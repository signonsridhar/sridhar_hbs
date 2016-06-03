define(['bases/page',
        'modules/agreement/agreement',
        'models/shopping_cart/shopping_cart',
        'models/directory/directory',
        '_',
        'css! pages/wizard/step_2/wizard_step_2'
],
(BasePage, Agreement, ShoppingCart,Directory, _)->
    BasePage.extend({
        init:(elem, options)->
            LANG = {
                confirm_config_msg: 'Confirm your line configurations'
                config_lines_addional_msg: 'You are configuring your lines with the information below. The phones and phone numbers you selected will be processed after confirmation.'
                additional_charges_msg: 'Additional charges',
                shipping_address_msg:'The phones will be shipped to:'
                sub_total: 'Subtotal'
                tax: 'Tax'
                total: 'Total'
                configured_lines: 'Configured Lines'
                additional_fees: 'Additional charges'
                will_be_charged_msg: 'will be charged to'
            }
            this.set_validity(false)
            shopping_order = new ShoppingCart()
            shopping_cart = shopping_order.get_configure_review_request(options)
            this.setup_viewmodel({
                summary:{'total_amount_after_taxes':''}
            })
            this.spinner_visibility(true)

            ShoppingCart.wizard_review_order(shopping_cart).done (response)=>
                summary = _.pick(response, ['total_amount_after_taxes','total_amount_before_taxes','tax_amount','invoice_items','credit_card'])
                this.viewmodel.attr('summary', summary)
                this.render('wizard/step_2/wizard_step_2',{ bundles: options.models.directory ,tenant: options.models.tenant, LANG: LANG })
                if(this.viewmodel.attr('summary.total_amount_after_taxes'))
                    this.options.agreement = new Agreement(this.find('.agreement_container'), {enable:['tos', 'e911']})
                this.on()



        spinner_visibility:(is_visible)->
            if is_visible
                this.element.append($('<div class="spinner_container"><img class="spinner" src="/etc/spinners/loading.gif" /></div>'))
            else
                this.element.find('.spinner').remove()

        validate:()->
            this.set_validity(this.options.agreement.validity())

        '{agreement.validity} change':()->
            this.validate()

        on_next:()->
            return true

        on_prev:()->
            return true


    })
)