define(['bases/control',
        '_'
], (BaseControl,_)->
    BaseControl.extend({
        init:(elem, options)->
            if(options.statement.attr('statement_number'))
                this.setup_viewmodel({
                    statement_number: options.statement.attr('statement_number'),
                    statement_date: _date(options.statement.attr('creation_date')).format("MMMM DD, YYYY")
                    statement_url: "#{window.location.host}/bss/account?action=getAccountStatement&tenant_id=#{options.account.attr('tenant_id')}&statement_number=#{options.statement.attr('statement_number')}"
                })

                this.render('invoice_item_link/invoice_item_link')
                this.bind_view(this.viewmodel)
                this.on()

        '.invoice_link click':()->
            this.options.account.get_account_statement({tenant_id:this.options.account.attr('tenant_id'),statement_number:this.options.statement.attr('statement_number')}).done (response)=>
                w = window.open()
                w.document.body.innerHTML = response.data
    })
)