define([
    'bases/control',
    'modules/state_list/state_list',
    'css!modules/company_info_form/company_info_form'
], (BaseControl, StateList)->
    BaseControl.extend({
        LANG: ()->

            errors = {
                name:{},
                primary_address_street1:{},
                primary_address_street2:{},
                primary_address_city:{},
                primary_address_state:{},
                primary_address_zip:{}
            }

            LANG = {
                errors:errors
            }

            LANG.validate_addr_error= 'Must be a valid US address'

            errors.name[VALID.ERROR.REQUIRED] = 'name is required'
            errors.name[VALID.ERROR.SIZE] = 'name is between 2-40 characters'
            errors.name[VALID.ERROR.FORMAT] = "Must be 2 to 40 characters alphanumeric, and may contain the following special chars: . , & ( ) ! ? - @ '"

            errors.primary_address_street1[VALID.ERROR.REQUIRED] = 'street is required'
            errors.primary_address_street1[VALID.ERROR.SIZE] = 'address is between 3-40 characters'
            errors.primary_address_street1[VALID.ERROR.FORMAT] = "must be 3 to 40 characters alphanumeric, and may contain the following special chars: . , & - # /"

            errors.primary_address_street2[VALID.ERROR.SIZE] = 'address is between 3-40 characters'
            errors.primary_address_street2[VALID.ERROR.FORMAT] = "must be 3 to 40 characters alphanumeric, and may contain the following special chars: . , & - # /"

            errors.primary_address_city[VALID.ERROR.REQUIRED] = 'city is required'
            errors.primary_address_city[VALID.ERROR.SIZE] = 'city is between 2-40 characters'
            errors.primary_address_city[VALID.ERROR.FORMAT] = "must be 2 to 40 characters alphanumeric, and may contain the following special chars ' - ."

            errors.primary_address_state[VALID.ERROR.REQUIRED] = 'state is required'
            errors.primary_address_state[VALID.ERROR.FORMAT] = '2 character code for state'

            errors.primary_address_zip[VALID.ERROR.REQUIRED] = 'zipcode is required'
            errors.primary_address_zip[VALID.ERROR.FORMAT] = 'a valid 5 digit zip code is required'
            errors.primary_address_zip[VALID.ERROR.INVALID] = 'a valid 5 digit zip code is required'
            LANG

    }, {
        init: (elem, options)->
            window.company_info_form = this
            this.setup_viewmodel({
                hide_tenant_name: options.hide_tenant_name
            })
            #this.bind_model_errors_to_viewmodel('tenant', options.tenant )
            this.render('company_info_form/company_info_form', {tenant:options.tenant})

#
#            StateList.load().done((response)=>
#                this.render('html/abbr_state_dropdown', {states: response, name: 'primary_address_state'}, elem.find('.state_dropdown_container'))
#                this.bind_view(options.tenant)
#                this.on()
#            )
            new StateList(this.find('.state_dropdown_container'),{
                attr: 'primary_address_state'
                model: options.tenant
            })
            this.bind_view(options.tenant)
            this.set_validity(false)

        validate: ()->
            this.options.tenant.validate()

        '{tenant.valid} change': ()->
            if (this.options.tenant.valid())
                this.viewmodel.attr('validate_addr_error', false)
                this.options.tenant.validate_address_server().done((isValid)=>
                    this.set_validity(isValid)
                    if (!isValid)
                        this.viewmodel.attr('validate_addr_error', true)
                )
            else
                this.set_validity(this.options.tenant.valid())

    })
)