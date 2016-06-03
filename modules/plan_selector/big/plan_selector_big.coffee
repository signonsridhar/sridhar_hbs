define([
    'bases/control'
    'models/plan/plan',
    'models/master_plan/master_plan',
    'modules/slider/slider'
    'css!modules/plan_selector/big/plan_selector_big',
], (BaseControl, Plan, MasterPlan, Slider)->
    BaseControl.extend({
        init: (elem, options)->
            console.log('plan_selector init options ', options)
            LANG = {
                title: 'ONE SIMPLE PLAN'
                benefits: [
                    'Unlimited Domestic Calls',
                    'Direct Line for Every User',
                    'Unlimited Access to All Features',
                    'Free Cisco Desktop Phone'
                ],
                per_month_per_user: 'PER MONTH PER USER',
                intro_price: 'Introductory Price'
                reg_price:'*Regular Price: $65 per month per line'
                num_of_lines: 'NO. OF LINES'
                prepaid_months: 'PREPAID',
                order_total: 'ORDER TOTAL'
            }
            data = {}
            data.LANG = LANG
            options.master_plan = new MasterPlan()
            options.master_plan.set_promise( MasterPlan.load('tmus') )
            options.plan = data.plan = new Plan({num_of_lines:3, billing_period:1, product_id: ''})
            data.plan.calculate_total_price()
            options.slider_value = can.compute(data.plan.value('num_of_lines'))

            this.setup_viewmodel({
                billing_periods: []
            })
            this.viewmodel.attr_promise('billing_periods', Plan.get_billing_periods())
            this.viewmodel.attr_promise('num_of_lines_range', Plan.get_num_of_lines_range())


            this.render('plan_selector/big/plan_selector_big', {LANG: LANG, plan: options.plan})

            this.setup_sliders(1, 20)
            #this.on()

        '{slider_value} change':(value_compute, e, new_value, old_value)->
            this.options.plan.attr('num_of_lines', new_value)

        '{viewmodel} num_of_lines_range change':()->
            range = this.viewmodel.attr('num_of_lines_range')
            this.setup_sliders(range[0], range[1])

        '{viewmodel} billing_periods change':()->
            this.bind_view(this.options.plan)

        '{plan} num_of_lines change':()->
            this.options.plan.attr_promise('total', Plan.get_model_total_price('tmus',
                this.options.plan.attr('num_of_lines'), this.options.plan.attr('product_id' )))

        '{plan} product_id change':()->
            console.log('#####changed')
            this.handle_billing_change()
            this.options.plan.attr_promise('total', Plan.get_model_total_price('tmus',
                this.options.plan.attr('num_of_lines'), this.options.plan.attr('product_id' )))
        '{plan} billing_period change':()->
            promise_product_id = Plan.get_product_id(this.options.plan.attr('billing_period'))
            this.options.plan.attr_promise('product_id', promise_product_id  )
            promise_product_id.done(()=>
                this.handle_billing_change()
            )
        handle_billing_change:()->
            promise_minimum_lines = Plan.get_minimum_lines(this.options.plan.attr('product_id'))
            this.options.plan.attr_promise('minimum_lines', promise_minimum_lines  )
            promise_minimum_lines.done(()=>
                range = this.viewmodel.attr('num_of_lines_range')
                this.setup_sliders(this.options.plan.attr('minimum_lines'), range[1] )
            )

        setup_sliders:(min, max)->
            $num_of_lines = this.find('.slider_container .slider')
            this.num_of_lines = new Slider($num_of_lines, {value: this.options.slider_value, min: min, max: max})

        '.get_it_now_container a click': ($elem, e)->
            location.hash='/onboard/step_1' + can.route.param({ptnr_code:'tmus', m_id: this.options.master_plan.attr('product_id'), prd_id:this.options.plan.attr('product_id'), num_lines: this.options.plan.attr('num_of_lines'), prep_mnth: this.options.plan.attr('billing_period')})
            return false

    })
)