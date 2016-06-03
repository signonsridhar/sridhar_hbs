define(['bases/page',
		'css!pages/auth/index/auth_index'], (BasePage)->
    BasePage.extend({
            init:(elem)->
                this.render('auth/index/auth_index')
                this.$container = this.find('.auth_index')

        switch_sub:(sub)->
            require(["pages/auth/#{sub}/auth_#{sub}"], (Page)=>
                new Page(this.$container)
            )

    })
)