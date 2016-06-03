define([
    'bases/model',
    '_',
    'env!dev:models/plan/fixture/price_models',
    'env!dev:models/plan/fixture/get_model_total_price',
    'env!dev:models/plan/fixture/get_account_applicable_service_plans'
], (BaseModel, _,PriceModels,ModelTotalPrice)->

    BaseModel.extend({
        promises:{},
        get_account_applicable_plans:(tenant_id,partner_code)->
            $.get('/bss/product?action=getaccountapplicableserviceplans', {tenantid: tenant_id,partner_code:partner_code}).then (response)=>
                chain = _.chain(response.data.packages).pluck('charges').flatten()
                product_order_id =
                    min = chain.pluck('from_number_units').min().value()
                max = chain.pluck('to_number_units').max().value()
                {min_lines:min, max_lines: max, product_id:_.pluck(response.data.packages,'product_id')[0]}

        load:()->
            if not this.promises.load
                this.promises.load = $.get('/bss/product?action=getpricemodels&partner_code=tmus')
            this.promises.load
        get_billing_periods:()->
            this.load().then (response_data)->
                _.pluck(response_data.data.packages, 'billing_period')
        get_num_of_lines_range:()->
            this.load().then((response)->
                chain = _.chain(response.data.packages).pluck('charges').flatten()
                min = chain.pluck('from_number_units').min().value()
                max = chain.pluck('to_number_units').max().value()
                [min, max]
            )
        get_minimum_lines:(product_id)->
            promise = new $.Deferred()
            this.load().then( (response)->
                packages = response.data.packages
                pack = _.find(packages, (pkg)->
                    mybool = pkg.product_id == product_id
                    return mybool
                )
                promise.resolve(pack.minimum_quantity)
            )
            return promise
        get_product_id:(billing_period)->
            promise = new $.Deferred()
            this.get_product(billing_period).then((response)->
                console.log('resolved product_id ', response.product_id)
                promise.resolve(response.product_id)
            )
            return promise

        get_model_total_price:(partner_code, line_units, product_id)->
            req = {partner_code: partner_code, line_units: line_units, product_id: product_id}
            $.get('/bss/product?action=getmodeltotalprice', req).then((resp)=>
                total = _.first(_.pluck(resp.data.charges, 'amount'))
            )

        get_product:(billing_period)->
            billing_period = parseInt(billing_period)
            console.log('billing_period type', typeof billing_period)
            this.load().then((response)->
                packages = response.data.packages
                #returns matching package/product json object
                pack = _.find(packages, (
                    pkg)->
                    mybool = pkg.billing_period == billing_period #returns true or false
                    return mybool
                )
                #BaseModel.model.call(this, pack)# is causing error
            )

    }, {
        num_of_lines: 0,
        billing_period: 0,
        init: ()->
            this.cost = can.compute(50)
            this.bind('num_of_lines', this.calculate_cost)
            this.bind('billing_period', this.calculate_cost)
            this.calculate_cost()
            #this.total_price()
        calculate_total_price:()->
            this.constructor.load().done( ()=>
                promise_product_id = this.constructor.get_product_id(this.attr('billing_period'))
                this.attr_promise('product_id', promise_product_id  )
                promise_product_id.done(()=>
                    this.attr_promise('total',
                        this.constructor.get_model_total_price('tmus', this.attr('num_of_lines'), this.attr('product_id')))
                )
            )
        calculate_cost:()->
            this.constructor.load().done( (response)=>

                pricing = _.chain(response.data.packages).where({billing_period: parseInt(this.attr('billing_period'))})
                .pluck('charges').flatten()

                pricing = pricing.find((pricing_package)=>
                    pricing_package.from_number_units <= this.attr('num_of_lines') and
                    pricing_package.to_number_units >= this.attr('num_of_lines')
                ).value()

                this.cost(pricing.amount) if pricing?
            )
    })
)