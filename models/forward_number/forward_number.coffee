define(['bases/model',
        '_',
        'libs/validator'
], (BaseModel, _, validator)->
    BaseModel.extend({

    }, {

        init:()->
            this.setup_validations()

        validations:{
            number:()->
                number = this.attr('number')
                this.check(number, VALID.ERROR.REQUIRED).notEmpty()
                this.validity('number', VALID.YES)
        }
    })
)