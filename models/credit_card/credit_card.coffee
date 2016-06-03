define(['bases/model',
        '_',
        'libs/validator',
        'env!dev:models/tenant/fixture/zip_code_validation',
        'env!dev:models/credit_card/fixture/getaddcreditcardform',
        'env!dev:models/credit_card/fixture/add_credit_card_handler'
], (BaseModel, _, validator,CreditCardModel,Aria,CCHandler)->
    CreditCard = BaseModel.extend({
        MODE:{
          ARIA:'aria'
        },
        cc_form_promise: $.Deferred(),
        promise_form:(getccform_req)->
            unless this.cc_form
                $.get('/bss/account?action=getaddcreditcardform',getccform_req ).then((response_data)=>
                    #console.log 'this is getcreditcard', arguments
                    console.log('getaddcreditcardform response', response_data)

                    this.cc_form = response_data.data #resolve with cc_form data
                    this.cc_form_promise.resolve(this.cc_form)
                )
            return this.cc_form_promise

    }, {
            init: ()->
                this.setup_validations()
                this.debounced_validate_zip = _.debounce(this.validate_zipcode_server, 300)
            set_mode:(mode)->
                this.__mode = mode

            get_validation_function:(attr)->
                throw new Error('Please set mode of credit card, for ex: aria') if not this.__mode
                this.validations[this.__mode][attr]

            validations:{
                aria:{
                    cc_no:()->
                        cc_no = this.attr('cc_no')
                        this.check(cc_no, VALID.ERROR.REQUIRED).notEmpty()
                        this.check(cc_no, VALID.ERROR.FORMAT).isCreditCard()
                        this.validity('cc_no', VALID.YES)

                    CVV:()->
                        cvv = this.attr('CVV')
                        this.check(cvv, VALID.ERROR.REQUIRED).notEmpty()
                        this.check(cvv, VALID.ERROR.FORMAT).len(3,4)
                        this.validity('CVV', VALID.YES)

                    cc_exp_mm:()->
                        cc_exp_mm = this.attr('cc_exp_mm')
                        this.check(cc_exp_mm, VALID.ERROR.REQUIRED).notEmpty()
                        this.check(parseInt(cc_exp_mm), VALID.ERROR.RANGE).min(new Date().getMonth())
                        this.validity('cc_exp_mm', VALID.YES)

                    cc_exp_yyyy:()->
                        cc_exp_yyyy = this.attr('cc_exp_yyyy')
                        this.check(cc_exp_yyyy, VALID.ERROR.REQUIRED).notEmpty()
                        this.validity('cc_exp_yyyy', VALID.YES)

                    bill_first_name:()->
                        bill_first_name = this.attr('bill_first_name')
                        this.check(bill_first_name, VALID.ERROR.REQUIRED).notEmpty()
                        this.check(bill_first_name, VALID.ERROR.SIZE).len(2, 40)
                        this.check(bill_first_name, VALID.ERROR.FORMAT).regex('^[-a-zA-Z0-9.,&()!?-@\' ]*$')
                        this.validity('bill_first_name', VALID.YES)

                    bill_last_name:()->
                        bill_last_name = this.attr('bill_last_name')
                        this.check(bill_last_name, VALID.ERROR.REQUIRED).notEmpty()
                        this.check(bill_last_name, VALID.ERROR.SIZE).len(2, 40)
                        this.check(bill_last_name, VALID.ERROR.FORMAT).regex('^[-a-zA-Z0-9.,&()!?-@\' ]*$')
                        this.validity('bill_last_name', VALID.YES)

                    bill_address1:()->
                        bill_address1 = this.attr('bill_address1')
                        this.check(bill_address1, VALID.ERROR.REQUIRED).notEmpty()
                        this.check(bill_address1, VALID.ERROR.SIZE).len(3, 40)
                        this.validity('bill_address1', VALID.YES)

                    bill_address2:()->
                        bill_address2 = this.attr('bill_address2')
                        if _.isEmpty(bill_address2)
                            this.validity('bill_address2', VALID.YES)
                        else
                            this.check(bill_address2, VALID.ERROR.SIZE).len(3, 40)
                            this.validity('bill_address2', VALID.YES)

                    bill_city:()->
                        bill_city = this.attr('bill_city')
                        this.check(bill_city, VALID.ERROR.REQUIRED).notEmpty()
                        this.check(bill_city, VALID.ERROR.SIZE).len(3, 20)
                        this.validity('bill_city', VALID.YES)

                    bill_state_prov:()->
                        bill_state_prov = this.attr('bill_state_prov')
                        this.check(bill_state_prov, VALID.ERROR.REQUIRED).notEmpty()
                        this.check(bill_state_prov, VALID.ERROR.SIZE).len(2,2)
                        this.validity('bill_state_prov', VALID.YES)

                    bill_zip:()->
                        bill_zip = this.attr('bill_zip')
                        this.check(bill_zip, VALID.ERROR.REQUIRED).notEmpty()
                        this.check(bill_zip, VALID.ERROR.SIZE).isNumeric().len(5, 5)
                        this.debounced_validate_zip()

                }
            },
            validate_zipcode_server:()->
                $.get('/bss/system?action=resolveaddressbyzipcode',
                {zipcode: this.attr('bill_zip'), country: this.attr('bill_country')})
                    .then((resp)=>
                        this.validity('bill_zip', VALID.YES)
                    ).fail(()=>
                        this.validity('bill_zip', VALID.ERROR.INVALID)
                )

    })
)