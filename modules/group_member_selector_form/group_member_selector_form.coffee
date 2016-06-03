define(['bases/control',
        '_',
        'models/phone/phone',
        'modules/dt_dialog/dt_dialog',
        'css!modules/group_member_selector_form/group_member_selector_form'
], (BaseControl, _, Phone, DTDialog, SearchFormCss)->
    BaseControl.extend({
        init: (elem, options)->
            this.setup_viewmodel({
                group_members: this.options.group.group_members
                non_group_members : []
                selected_members: []
            })
            this.options.group.get_all_users().done (response)=>
                this.get_non_group_members(response)


        '{viewmodel} non_group_members': ()->
            if(this.viewmodel.attr('non_group_members').length)
                this.add_group_member_dialog = new DTDialog($('<div class="add_group_member_container_js" title="Add Member To Group"></div>'),
                {
                    content: this.element,
                    settings: {
                        autoOpen: false,
                        modal: true,
                        buttons:{
                            "Add": =>  this.add_group_member_button()
                            Cancel: => this.cancel_add_group_member_button()
                        },
                        open: () ->
                            $('.ui-dialog-buttonpane').find('button:contains("Add")').addClass('add');
                            $('.ui-dialog-buttonpane').find('button:contains("Cancel")').addClass('cancel');

                    }
                })
                this.add_group_member_dialog.show_hide_title(false)
                this.add_group_member_dialog.open_dialog()

                this.render('group_member_selector_form/group_member_selector_form')
                this.bind_view(this.viewmodel)

        get_non_group_members:(all_users)->
            non_group_members = []

            #get list of member extensions assigned to group
            member_extensions = _.pluck(this.viewmodel.attr('group_members').serialize() ,'member_extension_number')

            #get list of all user extensions
            all_user_extensions = _.pluck(all_users ,'member_extension_number')

            #get list of member extensions not assigned to current group
            unassigned_user_extensions = _.difference(all_user_extensions,member_extensions)

            if(unassigned_user_extensions)
                _.each(all_users, (user)=>
                    if(_.contains(unassigned_user_extensions, user.member_extension_number))
                        non_group_members.push(user)
                )
            this.viewmodel.attr('non_group_members',non_group_members)

        'input:checkbox change':($el, e)->
            $choice_elem = $el.closest('li.choice_js')
            index = $choice_elem.data('index')
            grp = this.viewmodel.non_group_members[index]
            if ($el.is(':checked'))
                member_obj = this.viewmodel.non_group_members[index]
                this.viewmodel.attr('selected_members').push(member_obj)
            else
                member_obj = this.viewmodel.non_group_members[index]
                this.viewmodel.attr('selected_members',_.without(this.viewmodel.attr('selected_members'),member_obj))

        get_selected: ()->
            this.viewmodel.attr('selected_members')

        cancel_add_group_member_button:() ->
            this.add_group_member_dialog.close_dialog()

        add_group_member_button:() ->
            group_members = []
            selected_member_obj = this.get_selected()
            $.each(selected_member_obj, (index, selected_member)->
                group_members.push({member_extensionid: selected_member.attr('member_extensionid'),enable_phone_ring: true })
            )
            member_req = {groupid: this.options.group.attr('groupid'), group_members: group_members }
            this.options.group.add_group_members(member_req).then((response)=>
                #updating group members list
                this.options.group.attr('group_members',response.group_members)
            )
            this.add_group_member_dialog.close_dialog()

    })
)