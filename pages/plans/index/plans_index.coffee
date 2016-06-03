define([
    'bases/page',
    'modules/plan_selector/big/plan_selector_big'
], (BasePage, PlanSelector)->

    BasePage.extend({}, {
        init:()->
            this.render('plans/index/plans_index')

            this.plan_selector = new PlanSelector(this.find('.plan_selector_container'))
    })
)