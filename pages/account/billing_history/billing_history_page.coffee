define([
    'bases/page',
    'modules/invoice_item_link/invoice_item_link',
    'css!pages/account/billing_history/billing_history_page'
], (BasePage,InvoiceItemLink)->
    BasePage.extend({
        LANG: (controller)->
            LANG = {
                statement_history: "Statement History"
                statement_date: "Statement Date"
                statement_number: "Statement Number"
                amount: "Amount"
            }
    },{
        init: (elem, options)->
            this.setup_viewmodel({
                statements: []
            })
            this.options.models.account.get_account_statement_history().done( (response)=>
                this.viewmodel.attr('statements',response)
            )

        '{viewmodel} statements change':()->
            this.render('account/billing_history/billing_history_page',
            {
                renderer:(elem, index,statement_item)=> new InvoiceItemLink(elem,{statement: statement_item,account:this.options.models.account})
            })
            this.on()

    })
)