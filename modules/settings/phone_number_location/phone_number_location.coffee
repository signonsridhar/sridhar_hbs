define(['bases/control',
        'models/tenant/tenant',
        'models/auth/auth',
        'modules/company_info_form/company_info_form'
], (BaseControl, Tenant, Auth, CompanyInfoForm)->
    BaseControl.extend({
       LANG:()->
           LANG = {}
           LANG.info = 'This address will be sent to Emergency Services when you dial 911 from this number.'
           LANG
    }, {
        init:(elem, options)->
            this.render('settings/phone_number_location/phone_number_location')
            this.options.tenant = options.settings.extract_tenant()
            this.options.e911address = this.options.model.attr('phone_numbers')[0].attr('phone_number_address')

            raw_tenant = _.pick(this.options.e911address, ['address_city', 'address_country', 'address_state', 'address_street1', 'address_zip']);
            this.options.tenant.attr('primary_address_street1',raw_tenant.address_street1)
            this.options.tenant.attr('primary_address_street2',raw_tenant.address_street2)
            this.options.tenant.attr('primary_address_city',raw_tenant.address_city)
            this.options.tenant.attr('primary_address_state',raw_tenant.address_state)
            this.options.tenant.attr('primary_address_zip',raw_tenant.address_zip)



            this.company_info_form = new CompanyInfoForm(this.find('.company_info_container_js'),{tenant: this.options.tenant,hide_tenant_name:true})
            this.on()

        'submit':()->

            extras = {
                didid: this.options.model.attr('phone_numbers')[0].didid
                userid: Auth.get_auth().get_user_id(),
                extensionid: this.options.model.attr('extensionid')
            }

            this.options.settings.change_phone_number_location(extras, this.options.tenant)
            return false

    })
)