define(['bases/model',
        '_',
        'libs/validator',
        'env!dev:models/tenant/fixture/mountain_view',
        'env!dev:models/tenant/fixture/zip_code_validation'
        'env!dev:models/tenant/fixture/update_tenant_address'
        'env!dev:models/tenant/fixture/validate_address'
        'env!dev:models/tenant/fixture/change_tenant_name'
], (BaseModel, _, validator)->
    tenant_name_format_check = (tenant_name)->
        special_chars = ": . , & ( ) ! ? - @ '".split(' ')
        has_number = false
        has_alpha = false
        has_invalid_char = false
        len = tenant_name.length
        if len < 8 or len > 16
            return false

        for i in [0..len]
            #this.check(tenant_name, VALID.ERROR.FORMAT).regex(/^(?=.*[_$@.])(?=.*[^_$@.])[\w$@.]{8,15}$/)
            raw_val = tenant_name[i]
            int_val = parseInt(raw_val)
            #console.log('int_val', int_val)
            if !_.isNaN(int_val) and int_val >= 0 and int_val <= 9
                has_number = true
            if /^[a-zA-Z()]$/.test(raw_val)
                has_alpha = true
            console.log('invalid_char', /^[a-z0-9]+$/i.test(raw_val), special_chars.indexOf(raw_val))
            if !(/^[a-z0-9]+$/i.test(raw_val)) and special_chars.indexOf(raw_val) < 0
                has_invalid_char = true


        if !(has_alpha and has_number) or has_invalid_char
            return false
        else
            return true
    BaseModel.extend({

    }, {

        init:()->
            this.setup_validations()
            this.debounced_validate_zipcode_server = _.debounce(this.validate_zipcode, 300)

        update_tenant_address:(tenant_request_data)->
            promise = new $.Deferred()
            $.post('/bss/tenant?action=updatetenantaddress',JSON.stringify(tenant_request_data)).then((response_data)=>
                promise.resolve(response_data.data)
            ).fail((response_data)->
                promise.reject(response_data.data)
            )
            promise

        update_tenant_name:(tenant_name_request_data)->
            promise = new $.Deferred()
            $.get('/bss/tenant?action=changetenantname',tenant_name_request_data).then((response_data)=>
                promise.resolve(response_data.data)
            ).fail((response_data)->
                promise.reject(response_data.data)
            )
            promise

        validations:{
            name:()->

                name = this.attr('name')
                this.check(name, VALID.ERROR.REQUIRED).notEmpty()
                this.check(name, VALID.ERROR.SIZE).len(2, 40)
                ### if not tenant_name_format_check(name)
                    this.validity('name', VALID.ERROR.FORMAT)
                    return###
                this.check(name, VALID.ERROR.FORMAT).regex('^[-a-zA-Z0-9.,&()!?@\' ]*$')
                this.validity('name', VALID.YES)

            primary_address_street1:()->
                address = this.attr('primary_address_street1')
                this.check(address, VALID.ERROR.REQUIRED).notEmpty()
                this.check(address, VALID.ERROR.SIZE).len(3, 40)
                this.debounced_validate_street1()

            primary_address_street2:()->
                address = this.attr('primary_address_street2')
                if address
                    this.check(address, VALID.ERROR.SIZE).len(3, 40)
                    this.check(address, VALID.ERROR.FORMAT).regex('^[-a-zA-Z0-9.,&#/ ]*$')
                    this.validity('primary_address_street2', VALID.YES)

            primary_address_city:()->
                city = this.attr('primary_address_city')
                this.check(city, VALID.ERROR.REQUIRED).notEmpty()
                this.check(city, VALID.ERROR.SIZE).len(2, 40)
                this.debounced_validate_city()

            primary_address_state:()->
                state = this.attr('primary_address_state')
                this.check(state, VALID.ERROR.REQUIRED).notEmpty()
                this.check(state, VALID.ERROR.FORMAT).len(2,2)
                this.validity('primary_address_state', VALID.YES)

            primary_address_zip:()->
                zip = this.attr('primary_address_zip')
                this.check(zip, VALID.ERROR.REQUIRED).notEmpty()
                this.check(zip, VALID.ERROR.FORMAT).isNumeric().len(5, 5)
                this.debounced_validate_zip()
        }

        validate_zipcode:()->
            this.validity('primary_address_zip', VALID.YES)

        debounced_validate_street1:_.debounce(()->
            address = this.attr('primary_address_street1')
            this.check(address, VALID.ERROR.FORMAT).regex('^[-a-zA-Z0-9.,&#/ ]*$')
            this.validity('primary_address_street1', VALID.YES)
        ,300)

        debounced_validate_city:_.debounce(()->
            city = this.attr('primary_address_city')
            this.check(city, VALID.ERROR.FORMAT).regex('^[-a-zA-Z0-9.\' ]*$')
            this.validity('primary_address_city', VALID.YES)
        ,300)

        debounced_validate_zip:_.debounce(()->
            zip = this.attr('primary_address_zip')
            this.validity('primary_address_zip', VALID.YES)
        ,300)

        validate_address_server:()->
            address_request = {
                primary_address_street1: this.attr('primary_address_street1'),
                primary_address_street2: this.attr('primary_address_street2'),
                primary_address_city: this.attr('primary_address_city'),
                primary_address_state: this.attr('primary_address_state'),
                primary_address_zip:this.attr('primary_address_zip'),
                primary_address_country:this.attr('primary_address_country')
            }
            promise = new $.Deferred()
            $.post('/bss/system?action=validateaddress',JSON.stringify(address_request)).then((response_data)=>
                reponse = response_data
                mybool = (response_data.data == 'true')
                promise.resolve(mybool)
            ).fail((response_data)->
                promise.reject()
            )
            promise


    })
)