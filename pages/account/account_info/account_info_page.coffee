define([
    'bases/page',
    'modules/tenant_info/tenant_info',
    'libs/qtip/qtip',
    'css!libs/qtip/qtip',
    'css!pages/account/account_info/account_info_page'
], (BasePage,TenantInfo)->
    BasePage.extend({
        init: (elem, options)->

            LANG = {
                see_rates: 'See Rates',
                cancel_plan: 'Cancel Plan',
                account: 'Account',
                expected_charge: 'Your expected recurring charges excluding usage and other fees.'
                next_payment_charged: 'Your plan will automatically renew on '
                your_fees_to_cc: 'Your fees and purchases will be charged to your credit card ending in'
                change: 'Change',
                billing_history: 'Billing History'
                your_last_payment: 'Your last payment in'
            }
            this.spinner_visibility(true)

            if(options.models.account.value('account_id'))
                this.render('account/account_info/account_info_page',{account: options.models.account, LANG:LANG})

                if(options.models.tenant)
                    this.options.tenant_info = new TenantInfo(options.rightnav ,{models: options.models})

        spinner_visibility:(is_visible)->
            if is_visible
                this.element.append($('<div class="spinner_container"><img class="spinner" src="/etc/spinners/loading2.gif" /></div>'))
            else
                this.element.find('.spinner_container').remove()

        dialogue:(content,title,account)->
            qtip_elem = this.element.find('.cancel_plan_js');
            qtip_elem.qtip({
                content: {
                    text: content,
                    title: title
                },
                position: {
                    my: 'center', at: 'center',
                    target: $(window)
                },
                show: {
                    ready: true,
                    modal: {
                        on: true,
                        blur: false
                    }
                },
                hide: false,
                style: 'dialogue qtip-light',
                events: {
                    render: (event, api) ->
                        $('button', api.elements.content).click((e) ->
                            if(this.textContent == "Deactivate Service")
                                account.cancel_account()
                            api.hide(e)
                        )
                    hide: (event, api) ->
                        api.destroy()
                }
            })

        '.cancel_plan_js click':(elem)->
            msg = "Are you sure you want to cancel your service plan? Clicking Deactivate Service below will discontinue your service at the end of your current billing period on "+this.options.models.account.attr('renewal_date')+". We will remove your billing information from our system and stop all monthly charges."
            message = $('<p />', { text: msg })

            ok = $('<button />', {
                text: 'Deactivate Service'

            })
            cancel = $('<button />', {
                text: 'Cancel'
            })
            button_container = $('<div />', {class: 'button_container'}).append(ok).append(cancel)
            this.dialogue( message.add(button_container), 'Deactivate Service Plan?' ,this.options.models.account)


    })
)