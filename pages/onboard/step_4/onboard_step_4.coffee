define(['bases/page',
        'modules/agreement/agreement',
        'modules/creditcard_info_form/creditcard_info_form',
        'models/shopping_cart/shopping_cart',
        '_',
        'css! pages/onboard/step_4/onboard_step_4'
],
    (BasePage, Agreement, CreditCardInfoForm, ShoppingCart, _)->
        BasePage.extend({
            init:(elem, options)->
                LANG = {
                    order_summary: 'Order Summary',
                    company_info: 'Company Info',
                    plan: 'Plan',
                    administrator: 'Administrator',
                    phone_number:'Phone Number'
                    sub_total: 'Subtotal'
                    tax: 'Tax'
                    total: 'Total'
                }
                this.set_validity(false)
                shopping_order = new ShoppingCart()
                shopping_cart = shopping_order.get_purchase_summary_request(options)
                this.setup_viewmodel({
                    summary:{'total_amount_after_taxes':''}
                })

                this.spinner_visibility(true)
                
                
                ShoppingCart.review_order(shopping_cart).done (response)=>
                    console.log('shopping cart', response)
                    this.set_validity(false)
                    summary = _.pick(response, ['billing_period', 'device_quantity', 'did_quantity', 'extension_quantity', 'invoice_items',
                                                'line_quantity', 'tax_amount', 'total_amount_before_taxes','total_amount_after_taxes', 'total_line_quantity'])
                    this.viewmodel.attr('summary', summary)
                    this.render('onboard/step_4/onboard_step_4', {LANG: LANG, tenant: options.models.tenant, admin: options.models.admin})
                    this.options.agreement = new Agreement(this.find('.agreement_container'), {enable:['tos', 'e911']})
                    this.on()


            validate:()->
                this.set_validity(this.options.agreement.validity())

            spinner_visibility:(is_visible)->
                if is_visible
                    this.element.append($('<div class="spinner_container"><img class="spinner" src="/etc/spinners/loading.gif" /> </div>'))
                else
                    this.element.find('.spinner').remove()

            '{agreement.validity} change':()->
                this.validate()

            on_next:()->
                return true

            on_prev:()->
                return true


        })
)