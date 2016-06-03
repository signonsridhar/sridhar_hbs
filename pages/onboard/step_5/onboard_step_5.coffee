define([
        'bases/page',
        'models/shopping_cart/shopping_cart',
        '_',
        'css! pages/onboard/step_5/onboard_step_5'
], (BasePage, ShoppingCart, _)->
    BasePage.extend({
        init:(elem, options)->
            LANG = {
                order_info  : 'Your order is complete'
            }
            this.setup_viewmodel({
                summary:{}
            })
            this.set_validity(true)

            shopping_order = new ShoppingCart()
            tenant_signup = shopping_order.get_signup_tenant_request(options)
            shopping_cart = shopping_order.get_purchase_summary_request(options)

            #console.log('tenant_signup', tenant_signup)
            #show spinner
            this.spinner_visibility(true)
            
            ShoppingCart.signup_tenant(tenant_signup).done (response)=>
                this.options.access_key = response.access_key
                ShoppingCart.review_order(shopping_cart).done (response)=>
                    summary = _.pick(response, ['total_amount_after_taxes'])
                    this.viewmodel.attr('summary', summary)
                    this.render('onboard/step_5/onboard_step_5',
                        {LANG: LANG, admin: options.models.admin, access_key: this.options.access_key})

        spinner_visibility:(is_visible)->
            if is_visible
                this.element.append($('<img class="spinner" src="/etc/spinners/loading.gif" />'))
            else
                this.element.find('.spinner').remove()

        '.setup_password_link_js click':()->
            window.location = can.route.url(
                { main:'setup_password',email:this.options.models.admin.email, access_key:this.options.access_key  })

    })
)