define(['bases/model',
        'env!dev:models/country_list/fixture/country_options'],
(BaseModel,GetStateList)->
    BaseModel.extend({
        countries:null,
        promise: $.Deferred(),
        load:()->
            #accessing the static through this.constructor.<whatever static>
            unless this.countries
                $.get('/bss/system?action=getcountrylist').then((resp)=>
                    this.countries = resp.data.countries
                    this.promise.resolve(this.countries)
                )
            return this.promise
    }, {
    })
)