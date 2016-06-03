define(['bases/page',
        'modules/agreement/agreement',
        'models/directory/directory',
        '_',
        'css! pages/wizard/step_3/wizard_step_3'
],
(BasePage, Agreement,Directory, _)->
    BasePage.extend({
        LANG:()->
            LANG = {
                shipping_address_msg: 'The phones will be shipped to:'
                configured_lines: 'Configured Lines'
                you_configured_lines: 'You configured your lines'
                order_number: 'The order number for this transactions is'
                total_of: 'The total of'
                will_be_charged: 'will be charged to'
                upon_shipment_of_phones: 'upon shipment of the phones'
                receipt_sent: 'A receipt was sent to'
            }
            LANG

    },{ init:(elem, options)->
            this.setup_viewmodel({
                summary:{'total_amount_after_taxes':''}
            })
            bundle_req = options.models.directory.get_configure_bundle_request(options.models.directory.serialize())
            this.spinner_visibility(true)
            Directory.configure_company_directory(bundle_req).done (response)=>
                summary = _.pick(response, ['purchase_summary'])
                this.viewmodel.attr('summary', summary)
                this.render('wizard/step_3/wizard_step_3',{ bundles: this.options.models.directory,tenant: this.options.models.tenant})


        on_next:()->
            return true

        spinner_visibility:(is_visible)->
            if is_visible
                this.element.append($('<img class="spinner" src="/etc/spinners/loading.gif" />'))
            else
                this.element.find('.spinner').remove()

    })
)