define(['bases/model',
        'env!dev:models/state_list/fixture/state_options'],
        (BaseModel,GetStateList)->
            BaseModel.extend({
            states:null,
            promise: $.Deferred(),
            load:()->
                #accessing the static through this.constructor.<whatever static>
                unless this.states
                    $.get('/bss/system?action=getstatelist').then((resp)=>
                        this.states = resp.data.states
                        this.promise.resolve(this.states)
                    )
                return this.promise
            }, {
            })
)