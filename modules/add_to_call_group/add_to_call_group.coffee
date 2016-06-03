define(['bases/control',
        '_',
        'bases/model',
        'models/auth/auth',
        'models/group/group'
], (BaseControl, _, BaseModel, Auth, Group)->
    BaseControl.extend({
        init: (elem, options)->
            this.setup_viewmodel({
                all_group_list:[]
            })
            this.render('add_to_call_group/add_to_call_group')
            this.bind_view(this.viewmodel)

        save_call_group_membership:()->
            promise = new $.Deferred()
            promises = []
            this.all_grp_no_conf = this.viewmodel.attr('all_group_list')
            member_extensionid =  this.options.bundle_elem.extensions[0].extensionid
            $.each(this.add_items, (index, grp)->
                add_grp_req ={}
                add_grp_req.groupid = grp.groupid
                add_grp_req.group_members = []
                add_grp_req.group_members.push({member_extensionid: member_extensionid, enable_phone_ring:true})
                promises.push(grp.add_group_members(add_grp_req))
            )

            $.each(this.delete_items, (index, grp)->
                del_grp_req ={}
                del_grp_req.groupid = grp.groupid
                del_grp_req.group_members = []
                del_grp_req.group_members.push({member_extensionid: member_extensionid, enable_phone_ring:true})
                promises.push(grp.delete_group_members(JSON.stringify(del_grp_req)))
            )
            $.when.apply($, promises).done(() ->
                console.log('>>>>>promises done')
                promise.resolve()
            ).fail(()->
                console.log('>>>>>promises failed')
                promise.reject()
            )
            promise


        'input:checkbox change':($el, e)->
            $choice_elem = $el.closest('li.choice_js')
            index = $choice_elem.data('index')
            grp = this.viewmodel.all_group_list[index]
            if ($el.is(':checked'))
                unless (_.findWhere(this.group_members, {groupid: grp.groupid}))
                    this.add_items.push(grp)
                #filter out the group from delete_items
                _.filter(this.delete_items,(item)->
                    if (item.groupid == grp.groupid)
                        false
                    true
                )
            else
                if (_.findWhere(this.group_members, {groupid: grp.groupid}))
                    this.delete_items.push(grp)
                #filter out the group from add_items
                _.filter(this.add_items,(item)->
                    if (item.groupid == grp.groupid)
                        false
                    true
                )

        refresh:(group_members)->
            this.delete_items = []
            this.add_items = []
            this.group_members = group_members
            tenant_id = Auth.get_auth().attr('tenant_id')
            promise_groups = Group.get_groups(tenant_id)
            this.viewmodel.attr_promise('all_group_list', promise_groups )
            promise_groups.done(()=>
                no_conf_group_list = _.filter(this.viewmodel.attr('all_group_list'), (group)->
                    group.attr('group_name') != 'Conference'
                )
                this.viewmodel.all_group_list.replace(no_conf_group_list)
                $elem = this.element.find(':checkbox')
                console.log('this.element checkboxes ', $elem, ' ', this.group_members)
                _.each(this.group_members, (mem)=>
                    mem_id =  mem.attr('groupid')
                    $elem.filter(()->
                        attr_val = parseInt($(this).attr('value'))
                        attr_val == mem_id
                    ).attr("checked","true")
                )
            )



    })
)
