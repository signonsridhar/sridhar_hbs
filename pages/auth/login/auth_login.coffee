define(['bases/page', 'modules/login_form/login_form'], (BasePage, LoginForm)->
    BasePage.extend({
        init:(elem, options)->
            this.render('auth/login/auth_login')
            this.options.login_form = new LoginForm(this.find('.login_form_container_js'), {})

    })
)