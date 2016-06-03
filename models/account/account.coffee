define([
    'bases/model',
    'models/invoice/invoice',
    'env!dev:models/account/fixture/get_account',
    'env!dev:models/account/fixture/get_creditcard'
    'env!dev:models/account/fixture/get_account_statement_history'
    'env!dev:models/account/fixture/get_account_statement'
    'env!dev:models/account/fixture/get_rate'
    'env!dev:models/tenant/fixture/cancel_tenant'
], (BaseModel,Invoice)->
    BaseModel.extend({
        get_account_details:(account_id)->
            $.get('/bss/account?action=getaccount', {account_id: account_id}).then((response_data)=>
                #debugger
                #console.log("I have a dream",response_data)
                BaseModel.model.call(this, response_data.data)
            )
    },{
        get_id:()-> this.attr('account_id')

        get_account_statement_history:()->
            $.get('/bss/account?action=getaccountstatementhistory', {tenant_id: this.attr('tenant_id')}).then((response_data)=>
                statements = response_data.data.statements
                result = []
                _.each(statements, (invoice)=>
                    result.push(new Invoice(invoice))
                )
                result
            )

        get_account_statement:(req)->
            $.get('/bss/account?action=getAccountStatement', req)

        get_creditcard_for_account:()->
            $.get('/bss/account?action=getcreditcard', {account_id: this.attr('account_id')}).then((response_data)=>
                response_data.data.creditcards[0]
            )

        get_rates_for_country:(country)->
            $.get("/bss/rate?action=getratetable&filter=partnerid=10000000;country=#{country}").then((response)->
                return response.data.rates
            )

        cancel_account:()->
            $.get('/bss/tenant?action=canceltenant', {tenantid: this.attr('tenant_id')})
    })
)