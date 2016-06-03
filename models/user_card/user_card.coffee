define(['bases/model',
        'libs/validator',
        '_',
        'models/bundle/bundle',
        'env!dev:models/user/fixture/get_user'
],
(BaseModel,validator, _, Bundle)->
    BaseModel.extend({
        init:()->
    })
)