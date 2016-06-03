define(['bases/model',
        '_',
        'env!dev:models/shopping_cart/fixture/getpurchasesummary',
        'env!dev:models/shopping_cart/fixture/getpurchasesummarygeneric',
        'env!dev:models/shopping_cart/fixture/createaccount',
        'env!dev:models/credit_card/fixture/getaddcreditcardform',
        'env!dev:models/shopping_cart/fixture/signuptenant'
], (BaseModel, _, validator,PurchaseSummary,PurchaseSummaryGeneric,CreateAccount,CreditCardModel,SignupTenant)->
    BaseModel.extend({
        preview_order:null,
        account_activate: null,
        signup_activate: null,
        promise_review: $.Deferred(),
        promise_account: $.Deferred(),
        promise_signup: $.Deferred(),
        cc_form:null,
        promise: $.Deferred(),
        getcreditcardform:(getccform_req)->
            #accessing the static through this.constructor.<whatever static>
            unless this.cc_form
                $.get('/bss/account?action=getaddcreditcardform',getccform_req ).then((resp)=>
                    #console.log 'this is getcreditcard', arguments
                    #console.log(resp.data.add_creditcard_form)
                    this.cc_form = resp.data.add_creditcard_form
                    this.promise.resolve(this.cc_form)
                )
            return this.promise

        review_order:(shopping_cart)->
            #accessing the static through this.constructor.<whatever static>
            unless this.preview_order
                data = JSON.stringify(shopping_cart)
                $.post('/bss/order?action=getpurchasesummary', data).then((resp)=>
                    this.preview_order = resp.data
                    this.promise_review.resolve(this.preview_order)
                )
            return this.promise_review

        wizard_review_order:(shopping_cart)->
            promise = new $.Deferred()
            $.post('/bss/order?action=getpurchasesummarygeneric', JSON.stringify(shopping_cart)).then((response_data)->
                promise.resolve(response_data.data)
            ).fail((response_data)->
                promise.reject(response_data.data)
            )
            promise


        create_account:(tenant_signup)->
            unless this.account_activate
                data = JSON.stringify(tenant_signup)
                $.post('/bss/account?action=createaccount', data).then((resp)=>
                    this.account_activate = resp.data
                    this.promise_account.resolve(this.account_activate)
                )
            return this.promise_account

        signup_tenant:(tenant_signup)->
            #accessing the static through this.constructor.<whatever static>
            unless this.signup_activate
                console.log('shop cart tenant_signup ', tenant_signup)
                data = JSON.stringify(tenant_signup)
                $.post('/bss/tenant?action=signuptenant', data).then((resp)=>
                    this.signup_activate = resp.data
                    this.promise_signup.resolve(this.signup_activate)
                )
            return this.promise_signup

    },{
        init:()->

        get_purchase_summary_request:(options)->
            partner_code = options.models.partner.partner_code
            account_id = options.models.tenant.account_id
            product_orders = options.models.plan.product_orders
            shopping_cart = {
                account_id: account_id,
                partner_code: partner_code,
                product_orders: product_orders
            }
            return shopping_cart

        get_create_account_request: (tenant, adminUser, tenant_phone_did, product_orders)->
            usersArr = new Array()
            usersArr.push(adminUser.serialize())
            console.log('usersArr: ', usersArr)
            tenant = $.extend({}, tenant, {main_number: tenant_phone_did.serialize()} )
            tenant.attr('email', adminUser.email)
            signup_request= {}
            signup_request.partner_code='tmus'
            signup_request.tenant=tenant.serialize()
            signup_request.tenant = $.extend({}, signup_request.tenant, {users: usersArr} )
            signup_request.product_orders = product_orders
            console.log('signup_request createaccount ', signup_request)
            return signup_request

        get_signup_tenant_request: (options)->
            tenant = options.models.tenant
            admin_user = options.models.admin
            tenant_phone_did = options.models.tenant.main_number
            product_orders = options.models.plan.product_orders
            signup_request = this.get_create_account_request(tenant, admin_user,
                tenant_phone_did, product_orders)
            signup_request.account_id = options.models.tenant.attr('account_id')
            signup_request.number_porting_enabled = options.models.tenant.number_porting_enabled
            return signup_request

        get_configure_review_request:(options)->
            partner_code = 'tmus'
            account_id = options.models.tenant.account_id
            bundles = options.models.directory.serialize()
            product_orders = []
            for bundle_elem in bundles
                extensions = bundle_elem.extensions
                unless _.isEmpty(extensions)
                    extensions = extensions[0]
                    devices = extensions.devices
                    unless _.isEmpty(devices)
                        devices = devices[0]
                        if(product_orders.length)
                            has_product = _.findWhere(product_orders, {product_order_id: devices.productid})
                        if(has_product)
                            _.findWhere(product_orders, {product_order_id: devices.productid}).quantity++
                        else
                            product_orders.push(
                                product_order_id: devices.productid,
                                product_sku: devices.product_sku,
                                quantity: 1
                            )
            shopping_cart = {
                account_id: account_id,
                partner_code: partner_code,
                product_orders: product_orders
            }
            return shopping_cart

        get_purchase_bundle_review_request:(options)->
            partner_code = options.partner_code
            account_id = options.account_id
            bundles = options.models.directory.serialize()
            product_orders = []
            for bundle_elem in bundles
                extensions = bundle_elem.extensions
                unless _.isEmpty(extensions)
                    extensions = extensions[0]
                    devices = extensions.devices
                    unless _.isEmpty(devices)
                        devices = devices[0]
                        if(product_orders.length)
                            has_product = _.findWhere(product_orders, {product_order_id: devices.productid})
                        if(has_product)
                            _.findWhere(product_orders, {product_order_id: devices.productid}).quantity++
                        else
                            product_orders.push(
                                product_order_id: devices.productid,
                                product_sku: devices.product_sku,
                                quantity: 1
                            )
            shopping_cart = {
                account_id: account_id,
                partner_code: partner_code,
                product_orders: product_orders
            }
            return shopping_cart
    })
)
