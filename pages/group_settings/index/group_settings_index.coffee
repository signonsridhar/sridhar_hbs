define([
    'bases/page'
    'modules/tab/tab_header',
    'modules/left_nav/left_nav',
    'bases/model/list',
    'models/user/user',
    'models/group/group',
    'modules/notification/notification',
    '_',
    'css! pages/group_settings/index/group_settings_index'
], (BasePage, TabHeader, LeftNav, BaseModelList, User, Group,Notification,_)->

    BasePage.extend({
        init:($elem, options)->
            this.controller_cache = {}
            this.render('group_settings/index/group_settings_index')
            this.header = new TabHeader(this.find('.tab_header_container'))
            #display status
            this.status_msg = new Notification(this.find('.status_container_js'))
            this.left_nav = new LeftNav(this.find('.left_nav_container_js'),{
                tabs:{
                    css:'group_settings'
                    map:{
                        call_settings:'Call Settings',
                        members:'Members'
                    }
                    change:(key, item)->
                        can.route.attr({main: 'group_settings', sub: key, group_id: can.route.deparam(location.hash).group_id}, true)

                    renderer:(key, value)->
                        "<span>#{value}</span>"
                }
            })

            group_id = can.route.deparam(location.hash).group_id
            options.models = models = {}
            this.group = options.group =  models.group = new Group()
            this.group.set_promise(Group.get_group_settings(group_id))
            this.on()

        '{group} groupid':_.debounce(()->
            this.switch_sub(can.route.attr('sub'))
        , 100)

        get_sub:()->
            sub = can.route.attr('sub')
            if sub == 'index' then 'call_settings' else sub

        switch_sub: (sub)->
            sub = 'call_settings' if sub == 'index'

            require(["pages/group_settings/#{sub}/#{sub}_page"], (PageStep)=>
                $group_settings_cont = $("<div class='group_container'></div>")

                this.group_settings_page = new PageStep($group_settings_cont, {
                    models: this.options.models
                })

                this.left_nav.set_content(this.group_settings_page)
                this.left_nav.set_active(this.get_sub())
                this.on()

            )


    })
)