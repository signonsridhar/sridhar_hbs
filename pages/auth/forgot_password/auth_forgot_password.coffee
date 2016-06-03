define(['bases/page', 'modules/forgot_password_form/forgot_password_form'],
(BasePage, ForgotPasswordForm)->
    BasePage.extend({
        init:(elem, options)->
            this.render('auth/forgot_password/auth_forgot_password')

            new ForgotPasswordForm(this.find('.forgot_password_container_js'))
    })
)
