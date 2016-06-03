define([
    'bases/page',
    'modules/tab/tab_header',
    'modules/item_list/editable/item_list_editable',
    'modules/left_nav/left_nav',
    'modules/config_edit_item_list/config_edit_item_list',
    'modules/dt_dialog/dt_dialog',
    'modules/add_call_group/add_call_group',
    'modules/add_new_line/add_new_line',
    'modules/transfer_number/transfer_number',
    'modules/ported_number_message/ported_number_message',
    'bases/model/list',
    'models/auth/auth',
    'models/directory/directory',
    'models/user/user',
    'models/group/group'
    '_',
    'modules/notification/notification',
    'css! pages/config/index/config_index'
], ( BasePage, TabHeader, ItemListEditable, LeftNav, ConfigEditItemList, DTDialog, AddCallGroup, AddNewLine,
     TransferNumber, PortedNumberMessage, BaseModelList, Auth, Directory, User, Group, _,Notification)->

    BasePage.extend({
        init:($elem, options)->
            user = Auth.get_auth().get_user()


            this.options.items = this.items = new BaseModelList([])
            this.options.directory = this.directory = new Directory()
            this.options.master_list = this.master_list = new BaseModelList([
            ])

            this.render('config/index/config_index')
            this.header = new TabHeader(this.find('.tab_header_container'))
            #display status
            this.status_msg = new Notification(this.find('.status_container_js'))

            this.left_nav = new LeftNav(this.find('.left_nav_container_js'),{
                ratio:[2,10],
                tabs:{
                    css:'config'
                    map:{
                        all:'All',
                        users:'Users',
                        groups:'Call Groups',
                        main:'Main Line',
                        unassigned:'Unassigned'
                    }
                    renderer:(key, value)->
                        "<span>#{value}</span>"
                    change:(key, value)->
                        can.route.attr({main:'config', sub:key})
                }
            })


            tenant_id = this.options.tenant_id = Auth.get_auth().attr('tenant_id')
            this.directory.load_all(tenant_id)

            this.config_edit_item_list = new ConfigEditItemList($('<div></div>'), {
                items: this.items,
                directory : this.options.directory,
                tenant_id: tenant_id
            })

            this.left_nav.set_content(this.config_edit_item_list)

            this.left_nav.set_active(this.get_sub())
            this.ported_msg = new PortedNumberMessage($('.ported_numbers_msg_js'),{tenant_id: tenant_id})


            this.on()
        get_sub:()->
            sub = can.route.attr('sub')
            if sub == 'index' then 'all' else sub

        '{directory} length':()->
            this.master_list = this.directory
            #this.options.items.replace(this.master_list)
            this.switch_sub(this.get_sub())

        switch_sub:(sub)->
            filter = null
            new_list = []

            switch sub

                when 'all'
                    filter = (item)-> return true
                when 'unassigned'
                    filter = (item)-> return item.attr('bundle_id') and not item.attr('is_assigned')
                when 'users'
                    filter = (item)-> return item instanceof User
                when 'main'
                    filter = (item)-> return item.get_name and item.get_name() == 'Main'
                when 'groups'
                    filter = (item)-> return item instanceof Group
                else
                    filter = (item)-> return true

            this.master_list.forEach((item, index, list)->
                new_list.push(item) if filter(item)
            )
            this.options.items.replace(new_list)

        '.add_new_line_js click':($el)->
                this.add_new_line = new AddNewLine($('<div class="add_new_line_container_js"></div>'), {})


        '.add_call_group_js click':($el)->
            this.add_call_group = new AddCallGroup($('<div class="add_call_group_container_js"></div>'), {directory:this.directory,tenant_id:this.options.tenant_id})

        '.transf_num_js click':($el)->
            unless this.transfer_number
                this.transfer_number = new TransferNumber($('<div class="transfer_number_container"></div>'), { is_logged_in: true, tenant_id:this.options.tenant_id })
            this.transfer_number.open_dialog()


    })
)