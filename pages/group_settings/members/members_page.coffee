define([
    'bases/page',
    'models/directory/directory',
    'models/group/group',
    'modules/group_member_delete_form/group_member_delete_form',
    'modules/group_member_selector_form/group_member_selector_form',
    'css!pages/group_settings/members/members_page'
], (BasePage,Directory,Group,GroupMemberDeleteForm,AddGroupMemberForm)->
    BasePage.extend({
        LANG:()->
            LANG = {}
            LANG.arrange_sequence = 'Arrange group members by dragging names in sequence from top to bottom.'
            LANG.members = 'Members'
            LANG.save = 'Save Ringing Order'
            LANG.add_group_member = 'Add group members'
            LANG.members_empty = 'Member list is empty'
            LANG
    },{
        init: (elem, options)->

            if(this.options.models.group.groupid)
                this.setup_viewmodel({
                    group_id: this.options.models.group.groupid,
                    group_name: this.options.models.group.group_name,
                    group: this.options.models.group,
                    group_members: this.options.models.group.group_members
                })

                this.render('group_settings/members/members_page',
                    {
                        group: this.options.models.group,
                        renderer:(elem, index,member_elem)=> new GroupMemberDeleteForm(elem,
                        {
                            member:member_elem, group: this.options.models.group
                        })
                    })
                this.element.find('.member_list_sequence_js').sortable({
                    change:  (event, ui)=>
                        console.log("sequence change",event,ui)
                        this.element.find('.change_ring_order_js').removeAttr('disabled')

                    placeholder: 'sortable-placeholder'

                })
                this.bind_view(this.viewmodel)
                this.on()


        '.add_group_members_btn click':($el)->
            this.add_group_member_form = new AddGroupMemberForm($('<div class="member_selector_form_container_js"></div>'),
            {
                group_members:  this.options.models.group.group_members,
                group: this.options.models.group
            })

        '.change_ring_order_js click':()->
            member_extensions = []
            _.each(this.element.find('.member_list_sequence_js .member_item_js'),(group_member)=>
                member_extensions.push({member_extension_id: group_member.getAttribute('data-extensionid')})
            )
            this.options.models.group.change_ring_order(member_extensions).done(()=>
                console.log('change_ring_order success')
                this.element.find('.change_ring_order_js').attr('disabled','disabled')
            ).fail((resp)=>
                #show error here>
                console.log('change_ring_order failed')
                this.element.find('.change_ring_order_js').attr('disabled','disabled')
                this.element.find('.change_ring_order_status_js').removeClass('hide').addClass('show').html('Change ring order failed')

            )
            this.options.models.group.set_promise(Group.get_group_settings(this.options.models.group.attr('groupid')))

    })
)