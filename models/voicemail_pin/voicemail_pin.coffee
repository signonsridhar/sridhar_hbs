define(['bases/model',
        '_',
        'libs/validator',
        'env!dev:models/tenant/fixture/mountain_view',
        'env!dev:models/tenant/fixture/zip_code_validation'
        'env!dev:models/tenant/fixture/update_tenant_address'
        'env!dev:models/tenant/fixture/change_tenant_name'
], (BaseModel, _, validator)->
    BaseModel.extend({

    }, {

        init:()->
            this.setup_validations()

        validations:{
            new_pin:()->
                new_pin = this.attr('new_pin')
                this.check(new_pin, VALID.ERROR.REQUIRED).notEmpty()
                this.check(new_pin, VALID.ERROR.FORMAT).isNumeric().len(4, 4)
                this.validity('new_pin', VALID.YES)
            confirm_pin:()->
                confirm_pin = this.attr('confirm_pin')
                this.check(confirm_pin, VALID.ERROR.REQUIRED).notEmpty()
                this.check(confirm_pin, VALID.ERROR.FORMAT).isNumeric().len(4, 4)
                this.validity('confirm_pin', VALID.YES)
        }


    })
)