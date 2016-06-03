define(['bases/control',
        'models/plan/plan',
        'models/shopping_cart/shopping_cart',
        'models/directory/directory',
        'models/phone/phone',
        'models/auth/auth',
        '_',
        'modules/dt_dialog/dt_dialog',
        'modules/agreement/agreement',
        'modules/wizard_edit_form/wizard_edit_form'
        'css!modules/add_new_line/add_new_line'
], (BaseControl, Plan, ShoppingCart,Directory, Phone,Auth,_, DTDialog,Agreement,WizardItemForm)->
    BaseControl.extend({
        LANG:()->
            LANG = {
                confirm_config_msg: 'Confirm your line purchase'
                configure_bundles_note: 'Add users, select extensions, phones and phone numbers to your lines'
                configure_bundles: 'Configure your lines'
                continue: 'Continue'
                name: 'Name'
                email: 'Email'
                extension: 'Extension'
                phone: 'Phone'
                phone_number: 'Phone Number'
                done: 'Done'
                config_lines_addional_msg: 'You are configuring your lines with the information below. The phones and phone numbers you selected will be processed after confirmation.'
                additional_charges_msg: 'Additional charges',
                shipping_address_msg:'The phones will be shipped to:'
                sub_total: 'Subtotal'
                tax: 'Tax'
                total: 'Total'
                additional_fees: 'Additional charges'
                will_be_charged_msg: 'will be charged to'
                phone_number:'Phone Number'
                configured_lines: 'Configured Lines'
                you_configured_lines: 'You configured your lines'
                order_number: 'The order number for this transactions is'
                total_of: 'The total of'
                will_be_charged: 'will be charged to'
                upon_shipment_of_phones: 'upon shipment of the phones'
                receipt_sent: 'A receipt was sent to'
                confirm: 'Confirm'
                cancel: 'Cancel'
            }
            LANG

    },{
        init: (elem, options)->
            this.setup_viewmodel({
                plan_lines: {}
                summary:{'total_amount_after_taxes':''},
            })
            options.models = models = {}
            models.phone = new Phone()
            options.directory = options.models.directory = this.directory = new Directory()
            tenant_id = options.tenant_id = Auth.get_auth().attr('tenant_id')
            account_id = options.account_id = Auth.get_auth().attr('account_id')
            partner_code = options.partner_code = 'tmus'
            this.options.models.tenant = this.directory.get_tenant_info()



            this.viewmodel.attr_promise('plan_lines', Plan.get_account_applicable_plans(tenant_id,partner_code))


            this.add_new_line_dialog = new DTDialog($('<div class="add_new_line_dialog_container_js" title="Add new lines"></div>'),
            {
                content: this.element,
                settings: {
                    height: 337,
                    width: 400,
                    autoOpen: false,
                    modal: true,
                    buttons:{
                        "Add": =>  this.purchase_line_preview()
                        Cancel: => this.close_add_new_line_dialog()
                    },
                    open: () ->
                        $(this).parent().find('.ui-dialog-buttonpane button:contains("Add")').addClass('add');
                        $(this).parent().find('.ui-dialog-buttonpane button:contains("Cancel")').addClass('cancel');

                }
            })

        '{viewmodel} plan_lines change':()->
            this.add_new_line_dialog.open_dialog()
            this.render('add_new_line/add_new_line')
            this.bind_view(this.viewmodel)

        spinner_visibility:(is_visible)->
            if is_visible
                this.element.append($('<div class="spinner_container"><img class="spinner" src="/etc/spinners/loading.gif" /></div>'))
            else
                this.element.find('.spinner_container').remove()


        purchase_line_preview:()->

            product_orders = []
            product_orders.push(
                product_order_id: this.viewmodel.attr('plan_lines').product_id,
                quantity: this.viewmodel.attr('select_line')
            )

            shopping_cart = {
                account_id: this.options.account_id,
                partner_code: this.options.partner_code,
                product_orders: product_orders
            }
            console.log("purchase_line_preview",shopping_cart)
            
            this.spinner_visibility(true)

            ShoppingCart.wizard_review_order(shopping_cart).done (response)=>
                summary = _.pick(response, ['total_amount_after_taxes','total_amount_before_taxes','tax_amount','invoice_items','credit_card'])
                this.viewmodel.attr('summary', summary)
                this.add_new_line_dialog.modify_dialog_settings({
                    height: 437,
                    width: 900,
                    autoOpen: false,
                    modal: true,
                    buttons:{
                        "Confirm": =>  this.configure_new_bundles()
                        Cancel: => this.close_add_new_line_dialog()
                    }}
                )

                this.render('add_new_line/add_new_line_preview',{ tenant: this.options.models.tenant })
                if(this.viewmodel.attr('summary.total_amount_after_taxes'))
                    this.options.agreement = new Agreement(this.find('.agreement_container'), {enable:['tos', 'e911']})
                    #this.set_validity(false)


        validate:()->
            this.set_validity(this.options.agreement.validity())

        '{agreement.validity} change':()->
            this.validate()

        configure_new_bundles:()->
            product_orders = []
            product_orders.push(
                product_order_id: this.viewmodel.attr('plan_lines').product_id,
                quantity: this.viewmodel.attr('select_line')
            )
            add_bundle_request = {
                tenant_id:  this.options.tenant_id,
                product_orders: product_orders
            }
            this.close_add_new_line_dialog()
            this.element = $('.left_nav_container_js')
            this.spinner_visibility(true)
            this.directory.add_line_bundles(add_bundle_request).done((response)=>
                this.options.phone_options = {
                    zipcode: this.options.models.tenant.attr('primary_address_zip'), # TODO
                    start_offset: 0,
                    country: this.options.models.tenant.attr('primary_address_country'),
                    partnerid: this.options.models.tenant.attr('partner_id'),
                    count: 2
                }

                this.render('add_new_line/configure_new_bundles',
                {
                    bundles: this.options.models.directory,
                    renderer:(elem, index,bundle_elem)=> new WizardItemForm(elem,
                    { bundle: bundle_elem, phone_options:this.options.phone_options })
                })
                this.on()
            )
        '.continue_purchase_button_js click':()->
            this.preview_purchase_new_bundles()

        preview_purchase_new_bundles:()->
            shopping_order = new ShoppingCart()

            shopping_cart = shopping_order.get_purchase_bundle_review_request(this.options)

            console.log("preview_purchase_new_bundles",shopping_cart)
            this.spinner_visibility(true)

            ShoppingCart.wizard_review_order(shopping_cart).done (response)=>
                summary = _.pick(response, ['total_amount_after_taxes','total_amount_before_taxes','tax_amount','invoice_items','credit_card'])
                this.viewmodel.attr('summary', summary)
                this.render('add_new_line/preview_purchase_new_bundles',{ tenant: this.options.models.tenant,bundles: this.options.models.directory })
                if(this.viewmodel.attr('summary.total_amount_after_taxes'))
                    this.options.agreement = new Agreement(this.find('.agreement_container'), {enable:['tos', 'e911']})
                    #this.set_validity(false)

        '.confirm_purchase_button_js click':()->
            this.confirm_purchase_new_bundles()

        '.cancel_purchase_button_js click':()->
            console.log("cancel_purchase_button_js")
            this.add_new_line_dialog.close_dialog()


        '.done_purchase_button_js click':()->
            console.log("done")
            window.location.reload(true)


        confirm_purchase_new_bundles:()->

            bundle_req = this.options.models.directory.get_configure_bundle_request(this.options.models.directory.serialize())
            console.log("bundle_req",bundle_req)
            this.spinner_visibility(true)
            Directory.configure_company_directory(bundle_req).done (response)=>
                summary = _.pick(response, ['purchase_summary'])
                this.viewmodel.attr('summary', summary)
                this.render('add_new_line/confirm_purchase_new_bundles',{ bundles:this.options.models.directory,tenant: this.options.models.tenant})

        close_add_new_line_dialog:()->
            this.add_new_line_dialog.close_dialog()

    })
)
