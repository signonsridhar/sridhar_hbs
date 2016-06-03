define([
    'bases/control',
    'css! modules/steps/steps'
], (BaseControl)->
    BaseControl.extend({
        init:(elem, options)->
            console.log 'option', options

            this.setup_viewmodel({
                curr:options.curr,
                steps:options.steps
            })
            this.render('steps/steps')
        set_current:(idx)->
            this.viewmodel.attr('curr', idx)
    })
)