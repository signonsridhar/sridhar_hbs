define([
    'bases/page',
    'modules/country_dropdown/country_dropdown',
    'css!pages/account/rates/rates_page'
    ],
(BasePage, CountryDropdown)->
    BasePage.extend({
        init: (elem, options)->
            this.setup_viewmodel({
                country_code: null
                rates:[]
            })
            this.render('account/rates/rates_page')

            new CountryDropdown(this.find('.country_list_container'),
                model: this.viewmodel,
                attr: 'country_code'
                mode: CountryDropdown.INPUT.COUNTRY_FULL
                no_ext: true
            )
            this.viewmodel.attr('country_code', 'United States')
            this.bind_view(this.viewmodel)

        '{viewmodel} country_code':_.debounce(()->
            this.viewmodel.attr_promise('rates', this.options.models.account.get_rates_for_country(this.viewmodel.attr('country_code')))
        , 300)

    })
)