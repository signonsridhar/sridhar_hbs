define([
    'bases/page'
    'models/directory/directory',
    '_',
    'modules/wizard_edit_form/wizard_edit_form'
    'css! pages/wizard/step_1/wizard_step_1'
], (BasePage, Directory,_,WizardItemForm)->

    BasePage.extend({
        init:($elem, options)->
            if(options.models.directory.length)
                options.phone_options = {
                    city : options.models.tenant.primary_address_city
                    state : options.models.tenant.primary_address_state
                    zipcode: options.models.tenant.attr('primary_address_zip'), # TODO
                    start_offset: 0,
                    country: options.models.tenant.attr('primary_address_country'),
                    partnerid: options.models.tenant.attr('partner_id'),
                    count: 2
                }

                this.render('wizard/step_1/wizard_step_1',
                    {
                        bundles: options.models.directory,
                        renderer:(elem, index,bundle_elem)=> new WizardItemForm(elem,
                            {bundle: bundle_elem, phone_options:this.options.phone_options,index:index})
                    })
                this.set_validity(true)
                this.on()

        on_next:()->
            return true

    })
)