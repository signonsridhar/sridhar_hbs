define(['bases/page', 'modules/resend_activation_form/resend_activation_form'], (BasePage, ResendActivationForm)->
    BasePage.extend({
        init:(elem, options)->
            this.render('auth/resend_activation/auth_resend_activation')
            this.options.resend_acivation_form = new ResendActivationForm(this.find('.resend_activation_container_js'), {show_link: can.route.attr('show_link')})

    })
)