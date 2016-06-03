require(['can', '_', 'models/auth/auth', 'libs/qtip/qtip'], (can, _, Auth)->
    #setup the routes
    defaults = {
        main: 'home',
        sub: 'index',
        state: ''
    }

    can.route('/:main', defaults)
    can.route('/:main/:sub', defaults)

    page = {
        header: null #holds the header controller
        footer: null #holds the footer controller
        main: null #string of the main
        sub: null   #string of the sub
        curr: null  #previous page object on the body
    }

    $content = $('#content')
    $header = $('header')
    $footer = $('footer')

    #initialize header and footer, for now default to default header and footer

    require(['modules/header/default/header', 'modules/footer/default/footer'], (Header, Footer)->
        page.header = new Header($header)
        page.footer = new Footer($footer)
    )

    can.route.bind('change', (e, attr, how, new_val, old_val)->
        #destroy visible qtips
        $('*[data-hasqtip]').each(()->
            $el = $(this)
            $el.qtip and $el.qtip('destroy', true)
        )
        main = can.route.attr('main')
        sub = can.route.attr('sub')

        changed = {main: main, sub: sub}
        changed.main = 'plans' if changed.main == 'home'
        #console.log('changed page to ', JSON.stringify(changed))
        if page.main != changed.main

            #can.route gets chatty, for example, if sub changes, this function gets called too
            can.extend(page, changed)
            #update the page so we dont call require multiple times

            #dynamically load the page
            console.log(changed, can.route.attr())
            Auth.check(can.route.attr()).done(()->
                access_level = 'access_user'
                user = Auth.get_auth().get_user()
                if user? and user.attr('user.is_administrator')
                    access_level = 'access_admin'

                $('#content').removeClass('access_user access_admin').addClass(access_level)
                require(["pages/#{changed.main}/index/#{changed.main}_index"], (Page)->
                    page.curr.destroy() if page.curr?
                    #remove the current page
                    page.curr = new Page($content, {main: changed.main, sub: changed.sub})
                    page.curr.switch_sub(changed.sub)
                )
            ).fail(()->
                Auth.get_auth().logged_out()
            )
    )

    can.route.ready()
    location.hash = '#!/' if _.isEmpty(location.hash)

)