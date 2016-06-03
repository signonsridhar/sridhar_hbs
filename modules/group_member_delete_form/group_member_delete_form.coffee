define(['bases/control',
        '_',
        'models/group/group'
], (BaseControl,_,Group)->
    BaseControl.extend({

            init:(elem, options)->
                this.setup_viewmodel({
                    deleted_group:false
                })

                LANG = {
                    removed_grp_msg : 'You removed extension',
                    from_grp_msg : 'from this call group.'
                }
                this.render('group_member_delete_form/group_member_delete_form',{LANG: LANG, member: options.member})
                this.bind_view(this.viewmodel)
                this.on()

            '.group_member_delete_click_js click': () ->
                group_members = []
                group_members.push(this.options.member.serialize())
                groupid = this.options.member.attr('groupid')
                member_req = {groupid: groupid, group_members: group_members }
                this.options.group.delete_group_members(member_req).then((response)=>
                    this.options.group.attr('group_members',response.group_members)
                ).fail((resp)=>
                    console.log("delete group member failed")
                )




    })
)