define([
    'bases/model',
    '_',
    'env!dev:models/master_plan/fixture/getmasterplan'
], (BaseModel, _)->

    BaseModel.extend({
        promises:{},
        load:(partner_code)->
            console.log('load method called >>>')
            if not this.promises.load
                this.promises.load = $.get('/bss/product?action=getmasterplans', {partner_code:partner_code}).then((response_data)=>
                    BaseModel.model.call(this, response_data.data.packages[0])
                )
            this.promises.load

        get_master_plan_id:(partner_code)->
            this.load(partner_code).then((response_data)->
                product_ids = _.pluck(response_data.data.packages, 'product_id')
                console.log(product_ids)
                if (product_ids)
                    return master_plan_id = product_ids[0]
                else
                    return null
            )
    },{})
)