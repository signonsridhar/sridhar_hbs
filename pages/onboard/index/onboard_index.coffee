define(['bases/page',
        'bases/model/list',
        'modules/hovering_plan/hovering_plan',
        'modules/steps/steps',
        'models/partner/partner',
        'models/plan/plan',
        'models/tenant/tenant',
        'models/user/user',
        'models/credit_card/credit_card',
        '_',

        'css! pages/onboard/index/onboard_index'],
(BasePage, BaseModelList, HoveringPlan, Steps, Partner, Plan, Tenant, User,CreditCard, _)->

    BasePage.extend({
        init: (elem, options)->
            data = {
                LANG: {
                    buttons: {
                        next: 'Next'
                        prev: 'Previous'
                        complete: 'Complete'
                    },
                    steps: ["Enter Account Information", "Select a phone number", "Enter Billing Information", "Review Order", "Complete!"]
                }
            }
            this.controller_cache = {}
            window.onboard_index = this
            this.options.curr_step = this.curr_step = data.curr_step = can.compute(1)
            this.set_validity(false)

            data.total_steps = 5

            this.options.models = models = {}
            deparam = can.route.deparam(location.hash)

            models.plan = new Plan({name: '', num_of_lines: deparam.num_lines, prepaid_months: deparam.prep_mnth, total:0})
            models.plan.attr_promise('total', Plan.get_model_total_price(deparam.ptnr_code, deparam.num_lines, deparam.prd_id ))
            models.partner = new Partner()
            models.partner.set_promise(Partner.load(deparam.ptnr_code))
            models.plan.product_orders = [{product_order_id:deparam.m_id, quantity:"1"},{product_order_id:deparam.prd_id, quantity:deparam.num_lines}]


            fake_data = {
                tenant: {
                    name:'Tenant Inc',
                    email: 'sridhar@dt-hbs.com',
                    primary_address_street1:'441 camille cir',
                    primary_address_city:'san jose',
                    primary_address_state:'CA',
                    primary_address_zip:95134
                },
                admin:{
                    first_name: 'jsjsjs',
                    last_name:'asdasdad',
                    phone:4159837482,
                    email:'sapna@choochee.com',
                    confirm_email: 'sapna@choochee.com'
                }
            }
            models.tenant = new Tenant({
                primary_address_country:'US',
                account_id: '',
                number_porting_enabled: false
            })

            models.admin = new User({
                is_admin: true
            })


            models.credit_card = new CreditCard({
                bill_country:'US'
            });

            ###
            models.tenant.attr(fake_data.tenant)
            models.admin.attr(fake_data.admin)
            ###

            models.tenant.set_validated_attrs(['name', 'primary_address_street1', 'primary_address_city',
                                               'primary_address_state', 'primary_address_zip'])
            models.admin.set_validated_attrs(['first_name', 'last_name', 'phone', 'email', 'confirm_email'])
            models.credit_card.set_mode(CreditCard.MODE.ARIA)
            models.credit_card.set_validated_attrs(_.keys(models.credit_card.validations[CreditCard.MODE.ARIA]) )


            this.render('onboard/index/onboard_index', data)
            this.hovering_plan = new HoveringPlan(this.find('.hovering_plan_container_js'), models)

            this.$cache = this.find('.cache')
            this.$content_elem = this.find('.onboard_content_container_js')
            this.steps_elem = this.find('.steps_container')
            this.steps = new Steps(this.find('.steps_container_js'), {curr: 1, steps: data.LANG.steps})
            this.on()

        show_hovering_plan:(flag)->
            if flag
                this.hovering_plan.element.show().addClass('large-4')
                this.$content_elem.removeClass('large-12').addClass('large-8')
            else
                this.hovering_plan.element.hide().removeClass('large-4')
                this.$content_elem.removeClass('large-8').addClass('large-12')

        get_sub:()->
            sub = can.route.attr('sub')

        switch_sub: (sub)->
            sub = 'step_1' if sub == 'index'
            curr_step = parseInt(sub.split('_')[1])

            if(curr_step > 3)
                this.show_hovering_plan(false)
            else
                this.show_hovering_plan(true)
                this.hovering_plan.show_total(true)


            require(["pages/onboard/#{sub}/onboard_#{sub}"], (PageStep)=>
                this.curr_step(curr_step)
                this.$content_elem.children('.onboard_steps').hide()

                if this.controller_cache[sub]
                    this.options.page = this.controller_cache[sub]
                    this.$content_elem.children(".onboard_#{sub}").show()
                else
                    $onboard_cont = $("<div class='onboard_steps onboard_#{sub}'></div>")
                    this.$content_elem.append($onboard_cont)
                    this.options.page = new PageStep($onboard_cont, { models: this.options.models})
                    this.controller_cache[sub] = this.options.page
                page = this.options.page
                this.on()
                page.on_show and this.options.page.on_show()
                window.page = page
                this.set_validity(this.options.page.validity())
            )

        '{curr_step} change':()->
            this.steps.set_current(this.curr_step())

        '{page.validity} change':()->

            this.set_validity(this.options.page.validity())

        '.step_button.disabled_js click':(elem, e)->
            this.options.page.show_errors and this.options.page.show_errors()
            this.options.page.validate? and this.options.page.validate()
            return false

        '.step_button.enabled_js click': ($elem, e)->
            handle_promise = (promise)=>
                if typeof promise == "boolean"
                    return promise
                else
                    promise.done((data)=>
                        console.log('handle promise resolved ', data)
                        location.hash = $elem.attr('href')
                    ).fail((data)=>

                        if (this.options.page.handle_failure)
                            this.options.page.handle_failure(data)
                    )

                    return false
            if $elem.hasClass('next_js')
                promise = this.options.page.on_next()
                handle_promise(promise)
            else #prev_js clicked
                promise = this.options.page.on_prev()
                console.log('this.options.page :', this.options.page)
                handle_promise(promise)

    })
)