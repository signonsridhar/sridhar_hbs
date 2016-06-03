define(['bases/control',
        'bases/model/list',
        'modules/tab/tab',
        '_',
        'css!modules/left_nav/left_nav'
        ], (BaseControl, BaseModelList,  Tab, _)->
    BaseControl.extend({
    },{
        ###

        ###
        init:(elem, options)->
            ratio = this.options.ratio
            ratio = [3, 9] unless ratio?

            this.render('left_nav/left_nav', {ratio: ratio})
            this.$content = this.find('.content_js')

            this.options.left_tab = this.left_tab = new Tab(this.find('.left_navigation_js'), {
                type:'vertical'
                css:'left_nav ' + options.tabs.css
            })
            if not options.tabs.change
                options.tabs.change = (key, value)-> can.route.attr({main:key, value:value})

            this.set_tabs(options.tabs)
            this.set_content(options.content)
            this.set_active(can.route.attr('sub'))

        set_tabs:(tabs)->
            return if not tabs?
            if not tabs.renderer
                tabs.renderer = (key, value)-> can.route.link(value, {main: can.route.attr('main'), sub:key}, {className:key})
            this.left_tab.set_tabs(tabs)



        set_active:(active)->
            this.left_tab.set_active(active)

        set_content:(content)->
            this.$content.empty()
            return if not content?
            this.$content.append(if content.element? then content.element else content)

    })
)