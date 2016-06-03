define([
    'bases/page'
    'modules/left_nav/left_nav',
    'modules/tab/tab_header',
    'models/account/account',
    'models/credit_card/credit_card',
    'models/tenant/tenant',
    'models/auth/auth',
    'modules/notification/notification',
    '_',
    'css! pages/account/index/account_index'
], (BasePage,LeftNav,TabHeader,Account,CreditCard,Tenant,Auth,Notification,_)->

    BasePage.extend({
        init:($elem, options)->
            this.render('account/index/account_index')
            this.header = new TabHeader(this.find('.tab_header_container'))
            #display status
            this.status_msg = new Notification(this.find('.status_container_js'))

            this.left_nav = new LeftNav(this.find('.left_nav_container_js'),{
                tabs:{
                    css:'account'
                    map:{

                        account_info:'Your Plan',
                        payment_method: 'Payment Method',
                        billing_history: 'Billing History',
                        rates: 'Rates'
                    }
                    change:(key, item)->
                        can.route.attr({main: 'account', sub: key }, true)

                    renderer:(key, value)->
                        "<span>#{value}</span>"
                }
            })
            #/bss/commerce/ratetable?action=getabbreviatedrates&appid=dc1ff3c5007c4abd9a824b0dd5948515&accesskeyid=e137fdc716b94abd80306f596ad67604_5870727701_1387234472742_ChooChee&ratetableid=a171ef84826a467593f8bed15bfb9310&filter=country%3DUnited%20States&start_offset=0&count=20&_=1387234763056
            account_id = options.account_id = Auth.get_auth().attr('account_id')
            options.models = models = {}
            models.credit_card = new CreditCard()
            models.credit_card.set_mode(CreditCard.MODE.ARIA)
            models.credit_card.set_validated_attrs(_.keys(models.credit_card.validations[CreditCard.MODE.ARIA]) )

            this.account = options.account =  models.account = new Account()
            this.account.set_promise(Account.get_account_details(account_id))

            this.on()
        ###'{can.route} change':(e)->
            this.left_nav.left_tab.set_active(can.route.attr('sub'))###

        get_sub:()->
            sub = can.route.attr('sub')
            if sub == 'index' then 'account_info' else sub


        switch_sub: (sub)->
            sub = 'account_info' if sub == 'index'
            require(["pages/account/#{sub}/#{sub}_page"], (PageStep)=>
                $account_cont = $("<div class='account_container'></div>")
                this.account_page = new PageStep($account_cont, {
                    models: this.options.models,
                    rightnav: this.find('.right_nav_container_js')
                })
                this.left_nav.set_content(this.account_page)
                this.left_nav.set_active(this.get_sub())
                this.on()
            )

        '{account} account_id':_.debounce(()->
            if( this.options.models.account.attr('account_address_street1') &&
                this.options.models.account.attr('account_address_city') &&
                this.options.models.account.attr('account_address_state') &&
                this.options.models.account.attr('account_address_zip') )
                    this.options.models.account.attr('tenant_id',Auth.get_auth().attr('tenant_id'))
                    this.options.models.tenant = new Tenant({
                        primary_address_street1: this.options.models.account.attr('account_address_street1'),
                        primary_address_city: this.options.models.account.attr('account_address_city'),
                        primary_address_state: this.options.models.account.attr('account_address_state'),
                        primary_address_zip: this.options.models.account.attr('account_address_zip'),
                        primary_address_country: this.options.models.account.attr('account_address_country'),
                        name: this.options.models.account.attr('name')
                        account_id: this.options.models.account.attr('account_id'),
                        tenant_id: Auth.get_auth().attr('tenant_id')
                    })

            this.switch_sub(can.route.attr('sub'))
        , 100 )



    })
)