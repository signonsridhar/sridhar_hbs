define(['bases/control',
        '_',
        'models/group/group',
        'modules/toggle/toggle',
        'modules/tab/tab',
        'css!modules/set_group_ring/set_group_ring'
], (BaseControl,_,Group,Toggle,Tab)->
    BaseControl.extend({
        LANG:()->
            LANG = {
                allow_member_forward: 'Allow users to forward calls from'
                arrange_sequence: 'Arrange Sequence'
                ringing_members: 'Ringing Members'
                sequential: 'Sequential'
                parallel:'Parallel'
            }
            LANG
    },{
        init:(elem, options)->


            this.setup_viewmodel({
                enable_group_ring: options.group.attr("enable_group_ring")
                allow_member_forward : options.group.attr('allow_member_forward')
                group_call_type: options.group.attr('group_call_type')
                group_name: options.group.attr('group_name')
            })

            this.render('set_group_ring/set_group_ring')
            this.options.group_type = new Tab(this.find('.group_type_tab_container_js'), {
                type:'ringing_members_horizontal',
                tabs:{
                    group: this.options.group
                    map:{

                        simultaneous:'Parallel',
                        sequential: 'Sequential'
                    }
                    change:(key, item)=>
                        this.viewmodel.attr('group_call_type',key)
                        this.options.group.attr('group_call_type',key)
                        req = {
                            groupid: this.options.group.attr('groupid')
                            group_call_type: this.options.group.attr('group_call_type')
                        }
                        #updating settings
                        options.group.update_group_settings(req).done(()=>
                        ).fail((resp)=>
                            console.log("setgroupsettings api failed")
                        )
                    renderer:(key, value)->
                        "<span>#{value}</span>"
                }

            })
            this.options.group_type.set_active(this.options.group.attr('group_call_type'))

            if(options.group.group_name != 'Main')
                #regular group toggle switch for ring group
                this.options.ring_switch  = new Toggle(this.find('.ring_switch_js'), {
                    model: this.viewmodel,
                    attr:'enable_group_ring'
                })
                this.on()


        'input[name=allow_member_forward] change':($el,e)->
            e.preventDefault()
            e.stopPropagation()
            if($el.is(':checked'))
                this.viewmodel.attr('allow_member_forward',true)
            else
                this.viewmodel.attr('allow_member_forward',false)

        '{viewmodel} allow_member_forward change':()->
            this.options.group.attr('allow_member_forward',this.viewmodel.attr('allow_member_forward'))
            req = {
                groupid: this.options.group.attr('groupid')
                allow_member_forward: this.options.group.attr('allow_member_forward')
            }
            #updating settings
            this.options.group.update_group_settings(req).done(()=>
            ).fail((resp)=>
                console.log("setgroupsettings api failed")
            )


        '{viewmodel} enable_group_ring change':()->
            #regular group set toggle switch for ring members
            if(this.options.group.group_name != 'Main')
                this.options.group.attr('enable_group_ring',this.viewmodel.attr('enable_group_ring'))
                req = {
                    groupid: this.options.group.attr('groupid')
                    enable_group_ring: this.options.group.attr('enable_group_ring')
                }
                #updating settings
                this.options.group.update_group_settings(req).done(()=>
                ).fail((resp)=>
                    console.log("setgroupsettings api failed")
                )

        '.arrange_sequence click':($el,e)->
            e.preventDefault()
            e.stopPropagation()
            can.route.attr({main: 'group_settings', sub: 'members' }, true)


    })
)