define(['bases/control',
'models/auth/auth',
'libs/qtip/qtip',
'css!modules/header/default/header'
], (BaseControl, Auth)->
    BaseControl.extend({
        LANG:()->

            top:
                help: 'Help'
                login: 'Login'
                logout: 'Logout'
            bottom:
                Home: 'home'
                'About The Program':'about'
                Benefits:'benefits'
                Contact:'contact'
            conf_numbers: 'Conference Numbers'

    },
    {
        init: ()->
            this.render('header/default/header')

            $( ".main_navigation_js" ).on( "click", ".more_numbers_js", ()->
                #more_number_js shows up in future after fetching conferencing numbers
                conf = _(window.auth.attr('conference_numbers')).pluck('phonenumber')
                c_list = $('<ul/>')
                $.each(conf, (i)->
                    li = $('<li/>')
                        .addClass('ui-menu-item')
                        .attr('role', 'menuitem')
                        .appendTo(c_list);
                    aaa = $('<a/>')
                        .addClass('ui-all')
                        .text(conf[i])
                        .appendTo(li)
                )

                $(this).qtip({
                    style: {
                        classes: 'qtip-light'
                    },
                    position: {
                        my: 'top center'
                    },
                    show: {
                        event: 'focus mouseover'
                        solo: true
                    },
                    content: {
                        title: 'Conference Numbers',
                        text: c_list[0].outerHTML
                    }
                })
            )

        '.logout click':()->
            window.auth.logged_out()

        '{window.state} header':(state, e, new_value)->
            console.log('show?....')

        '.more_numbers_js click':()->


    })
)