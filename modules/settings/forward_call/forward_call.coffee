define([
    'modules/enable_disable_form/enable_disable_form',
    'models/extension/extension',
    'modules/country_dropdown/country_dropdown',
    'modules/toggle/toggle',
    'models/auth/auth',
    'models/forward_number/forward_number',
    'libs/masked_input_plugin_jquery',
    'css!modules/settings/forward_call/forward_call'
], (EnableDisableForm, Extension, CountryDropdown, Toggle, Auth, ForwardNumber)->

    EnableDisableForm.extend({
        LANG:()->
            errors = {
                number:{}
            }

            LANG = {
                errors:errors
            }

            errors.number[VALID.ERROR.REQUIRED] = 'Number is required'


            LANG.title = 'Forward calls for extension <%= ext %> to:'
            LANG.call_forward_changed= 'Call Forwarding changed'
            LANG.errors[VALID.ERROR.INVALID] = 'Failed to update call forwarding'
            LANG
    },{
        init:(elem, options)->
            console.log('options.model', options)
            this._super(elem, options)
            this.options.forward_num = this.forward_num = new ForwardNumber({'number': options.model.attr('forwarding_number')})

            country_code = options.model.attr('forwarding_number_prefix') #91
            country_prefix = options.model.attr('forwarding_number_country') #US, skew it other way
            this.render('settings/forward_call/forward_call', {forward_num: this.forward_num})
            this.viewmodel.attr({
                is_call_forward_changed: false
                extension: options.model.attr('extension_number')
                enabled: options.model.attr('forwarding_enabled')
                number: options.model.attr('forwarding_number')
                country_prefix: country_prefix
                country_code: if country_code then country_code else 'ext'}
            )



            country_dropdown = new CountryDropdown(this.find('.country_container_js'), {
                model: this.viewmodel
                attr:'country_code'
                mode: CountryDropdown.INPUT.COUNTRY_PHONE_CODE
            })

            this.bind_view(this.forward_num)
            this.set_validity(false)

            this.options.toggle = new Toggle(this.find('.toggle_container_js'), {
                model:this.viewmodel
                attr:'enabled'
            })
            this.on()

        handle_mask:()->
            input_number = this.element.find('input[name="number"]')
            val = this.find('select').val()
            if ( val != 'ext')
                input_number.attr("placeholder", "Phone Number")
                if (val == '1' || val == '+1')
                    input_number.mask("(999) 999-9999")
                else
                    input_number.unmask()
            else
                input_number.attr('placeholder', 'Please enter extension')
                input_number.unmask()

        'input[name="number"] click':()->
            this.handle_mask()

        'select change':()->
            this.handle_mask()
        '{viewmodel} country_code change':()->
            debugger
            console.log('*****viewmodel country_code changed')
            this.handle_mask()



        form_submit:()->
            debugger
            this.viewmodel.attr('errors.number_required', null)
            this.viewmodel.attr('errors.display', null)
            try
                data = _.pick(this.viewmodel.attr(),'enabled', 'number','extension', 'country_prefix')
                data.country_code = this.find('select').val()
                data.forwarding = data.enabled
                data.tenantid = Auth.get_auth().attr('tenant_id')
                data.number = this.forward_num.attr('number')
                if (!data.number?)
                    this.validate()
                    return
                this.options.settings.forward_call_to_number(data).done(()=>
                    this.viewmodel.attr('is_call_forward_changed', true)
                ).fail(()=>
                    this.viewmodel.attr('is_call_forward_changed', false)
                    this.viewmodel.attr('errors.display', "invalid")
                ).always(()=>
                    this.options.forward_num.valid(false)
                )
            catch e
                this.viewmodel.attr('errors.number_required', e.message)

        'form submit':()->
            this.form_submit()
            return false

        validate: ()->
            this.forward_num.validate()

        '{forward_num.valid} change': ()->
            this.set_validity(this.forward_num.valid())

        'input:radio change':()->
            console.log('second ...')
            this.form_submit()


    })
)