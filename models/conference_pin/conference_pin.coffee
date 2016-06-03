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
            pin:()->
                pin = this.attr('pin')
                this.check(pin, VALID.ERROR.REQUIRED).notEmpty()
                this.check(pin, VALID.ERROR.FORMAT).isNumeric().len(4, 4)
                this.validity('pin', VALID.YES)
            confirm_pin:()->
                confirm_pin = this.attr('confirm_pin')
                this.check(confirm_pin, VALID.ERROR.REQUIRED).notEmpty()
                if this.attr('pin') == confirm_pin
                    this.validity('confirm_pin', VALID.YES)
                else
                    this.validity('confirm_pin', VALID.ERROR.EQUAL)

        }


    })
)