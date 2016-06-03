define([
    'bases/model',
    '_',
    'env!dev:models/partner/fixture/get_partner'
], (BaseModel, _)->

    BaseModel.extend({
        promises:{},
        load:(partner_code)->
            #TODO use partner code argument
            if not this.promises.load
                this.promises.load = $.get('/bss/partner?action=getpartner', {partner_code:'tmus'}).then((response_data)=>
                    BaseModel.model.call(this, response_data.data)
                )
            this.promises.load

        get_partner_id:()->
            this.load().then((response_data)->
                partner_id=response_data.data.partner_id
            )
    },{})
)