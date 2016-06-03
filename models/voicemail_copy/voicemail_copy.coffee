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
            email:()->
                email = this.attr('email')
                this.check(email, VALID.ERROR.REQUIRED).notEmpty()
                this.check(email, VALID.ERROR.SIZE).len(3, 70)
                this.check(email, VALID.ERROR.FORMAT).regex('^\\s*[a-z A-Z0-9+_. -]+@[a-zA-Z0-9.-]+\\s*$')
                this.validity('email', VALID.YES)
        }


    })
)