define(['bases/model',
        '_',
        'env!dev:models/phone/fixture/getdeviceproduct'
], (BaseModel, _, GetPhones)->
        BaseModel.extend({
            id: 'deviceid'
            TYPE:'PHONE'
            models: (data)->
                BaseModel.models.call(this, data.data.products)

            find_phone: ()->
                $.get('/bss/product?action=getdeviceproduct',{partner_code:'tmus'}).then((response_data )=>
                    mods = BaseModel.models.call(this, response_data.data.products)
                    return mods
                )
        },{})
)