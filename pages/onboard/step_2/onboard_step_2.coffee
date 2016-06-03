define([
    'bases/page',
    '_',
    'modules/company_main_selector/company_main_selector',
    'models/phone_number/phone_number',
    'modules/transfer_number/transfer_number',
    'models/shopping_cart/shopping_cart',
    'css! pages/onboard/step_2/onboard_step_2'
], (BasePage, _, CompanyMainSelector, PhoneNumber, TransferNumber, ShoppingCart)->
    BasePage.extend({
        init:(elem, options)->
            this.curr_tenant_uid = null
            this.set_validity(false)

            this.render('onboard/step_2/onboard_step_2')
            this.options.company_main_selector = this.company_main_selector = new CompanyMainSelector(
                this.find('.main_number_container'), {models:this.options.models})
            this.transfer_number = new TransferNumber(this.find('.transfer_number_container'),{tenant:this.options.models.tenant})

        '{models.tenant}  main_number':()->
            if(this.options.models.tenant.attr('main_number').didid)
                this.validate()


        #change in tenant information, trigger createaccount
        '{models.tenant} change': _.debounce(()->
                this.options.models.onchange_tenant_uid = _.uniqueId()
            ,300)


        validate: ()->
            this.set_validity(true)

        create_account: ()->
            shopping_order = new ShoppingCart()
            tenant = this.options.models.tenant
            admin_user = this.options.models.admin
            tenant_phone_did = this.options.models.tenant.main_number
            product_orders = this.options.models.plan.product_orders
            tenant_signup = shopping_order.get_create_account_request(tenant, admin_user, tenant_phone_did, product_orders)
            console.log('tenant_signup ', tenant_signup)
            ShoppingCart.create_account(tenant_signup).done (response_data)=>
                this.options.models.tenant.attr('account_id', response_data.shopping_cart.account_id)

        reserve_number: ()->
            this.company_main_selector.reserve_number()

        on_next:()->
            if (this.curr_tenant_uid != this.options.models.onchange_tenant_uid)
                this.curr_tenant_uid = this.options.models.onchange_tenant_uid
                return this.create_account()
            else
                return true

        on_prev: ()->
            return true


    })
)