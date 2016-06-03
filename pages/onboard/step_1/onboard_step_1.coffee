define([
    'bases/page',
    'modules/admin_info_form/admin_info_form',
    'modules/company_info_form/company_info_form',
    'css! pages/onboard/step_1/onboard_step_1'
], (BasePage, AdminInfoForm, CompanyInfoForm)->
    BasePage.extend({
        init: (elem, options)->
            this.ID = 'onboard_step_1'
            this.render('onboard/step_1/onboard_step_1')

            this.options.admin_info_form = new AdminInfoForm(this.find('.admin_info_container'), {admin: options.models.admin})
            this.options.company_info_form = new CompanyInfoForm(this.find('.company_info_container'), {tenant: options.models.tenant})
            this.set_validity(false)
            this.on()

        '{admin_info_form.validity} change':()->

            validity = this.options.admin_info_form.get_validity() and this.options.company_info_form.get_validity()
            console.log 'admin info form valid is listened', this.options.admin_info_form.validity(), validity
            this.set_validity(validity)

        '{company_info_form.validity} change':()->
            console.log 'company info form valid is listened', arguments
            validity = this.options.admin_info_form.get_validity() and this.options.company_info_form.get_validity()
            this.set_validity(validity)

        on_next:()->
            return true

        show_errors: (show_errors = false)->
            #this.options.admin_info_form.show_all_errors()
            #this.options.company_info_form.show_all_errors()
    })
)