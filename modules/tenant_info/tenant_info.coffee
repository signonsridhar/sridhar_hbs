define([
    'bases/control',
    'modules/company_info_form/company_info_form',
    'models/auth/auth',
    'css!modules/tenant_info/tenant_info'
], (BaseControl,CompanyInfoForm, Auth)->
    BaseControl.extend({
        init: (elem, options)->

            this.setup_viewmodel({
                show_update_button:false
            })
            this.render('tenant_info/tenant_info', {tenant:options.models.tenant})

        '.change_tenant_address click':()->
            console.log("change_tenant_address")
            this.options.company_info_form = new CompanyInfoForm(this.element.find('.company_info_content'),{tenant: this.options.models.tenant})
            this.viewmodel.attr('show_update_button',true)
            this.set_validity(false)
            this.on()

        '{company_info_form.validity} change':()->
            console.log 'company info form valid is listened', arguments
            validity = this.options.company_info_form.get_validity()
            this.set_validity(validity)

        '.update_tenant_address click':($el, e)->
            e.preventDefault()

            #update tenant name
            tenant_name_request_data = {
                tenantid: this.options.models.tenant.attr('tenant_id'),
                tenantname:this.options.models.tenant.attr('name')
            }
            auth = Auth.get_auth()

            this.options.models.tenant.update_tenant_name(tenant_name_request_data).done (response)=>
                this.options.models.account.attr('name', this.options.models.tenant.attr('name'))
                auth = Auth.get_auth()
                auth.auth_user.attr('tenant_name', tenant_name_request_data.tenantname)

            #update tenant address
            tenant_request_data = {
                tenant_id: this.options.models.tenant.attr('tenant_id')
                address_street1: this.options.models.tenant.attr('primary_address_street1')
                address_street2: this.options.models.tenant.attr('primary_address_street2')
                address_city: this.options.models.tenant.attr('primary_address_city')
                address_state: this.options.models.tenant.attr('primary_address_state')
                address_zip: this.options.models.tenant.attr('primary_address_zip')
                address_country: this.options.models.account.attr('account_address_country')
            }

            this.options.models.tenant.update_tenant_address(tenant_request_data).done (response)=>
                this.options.models.account.attr('account_address_street1', this.options.models.tenant.attr('primary_address_street1'))
                this.options.models.account.attr('account_address_street2', this.options.models.tenant.attr('primary_address_street2'))
                this.options.models.account.attr('account_address_city', this.options.models.tenant.attr('primary_address_city'))
                this.options.models.account.attr('account_address_state', this.options.models.tenant.attr('primary_address_state'))
                this.options.models.account.attr('account_address_zip', this.options.models.tenant.attr('primary_address_zip'))
                this.viewmodel.attr('show_update_button', false)
                this.render('tenant_info/tenant_info', {tenant:this.options.models.tenant})
    })
)

