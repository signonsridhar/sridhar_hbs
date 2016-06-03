define(['bases/control', 'css! modules/hovering_plan/hovering_plan'], (BaseControl)->
    BaseControl.extend({
        init: (elem, options)->
            LANG = {
                header:' YOU SELECTED:'
                work_plan: '@Work Plan'
                lines:'Lines'
                prepaid_months: 'Prepaid Months'
                info: 'Lorem ipsum and stuff',
                order_total: 'Order Total'
                tax_disclaimer : 'This total does not include taxes, discounts or promotions'
            }

            this.setup_viewmodel({
                show_total:true
            })

            this.render('hovering_plan/hovering_plan', {LANG: LANG,plan:options.plan,tenant:options.tenant})
            this.bind_view(this.viewmodel)

        show_total: (show_bool)->
            this.viewmodel.attr('show_total', show_bool)


    })
)

