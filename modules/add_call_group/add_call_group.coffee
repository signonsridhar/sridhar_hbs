define(['bases/control',
        '_',
        'models/group/group',
        'modules/dt_dialog/dt_dialog',
        'css!modules/add_call_group/add_call_group'
], (BaseControl, _, Group,DTDialog)->
    BaseControl.extend({
        LANG: ()->
            errors = {
                group_name:{},
                extension_number:{}
            }

            LANG = {
                errors:errors
            }
            errors.group_name[VALID.ERROR.REQUIRED] = 'group name is required'
            errors.group_name[VALID.ERROR.SIZE] = 'group name is between 2-40 characters'
            errors.group_name[VALID.ERROR.FORMAT] = "must be 2 to 40 characters alphanumeric, and may contain the following special chars: . , & ( ) ! ? - @ '"

            errors.extension_number[VALID.ERROR.REQUIRED] = 'extension number is required'
            errors.extension_number[VALID.ERROR.FORMAT] = 'must be 3 digits between 200 and 999'
            errors.extension_number[VALID.ERROR.INVALID] = 'extension number is in use or reserved'
            LANG
    },{
        init: (elem, options)->
            this.setup_viewmodel({
                group_name: '',
                extension_number:''
            })
            this.options.group = this.group = new Group({tenant_id: this.options.tenant_id})
            this.group.set_validated_attrs(['group_name', 'extension_number'])
            this.add_call_group_dialog = new DTDialog($('<div class="add_call_group_dialog_container_js" title="Add Call Group"></div>'),
            {
                content: this.element,
                settings: {
                    height: 337,
                    width: 400,
                    autoOpen: false,
                    modal: true,
                    buttons:{
                        "Add Call Group": =>  this.create_call_group()
                        Cancel: => this.cancel_call_group_button()
                    },
                    open: () ->
                        $('.ui-dialog-buttonpane').find('button:contains("Add Call Group")').addClass('add');
                        $('.ui-dialog-buttonpane').find('button:contains("Cancel")').addClass('cancel');

                }
            })
            this.add_call_group_dialog.open_dialog()
            #this.add_call_group.refresh()
            this.render('add_call_group/add_call_group', {group: this.group})
            this.bind_view(this.group)

        validate: ()->
            this.options.group.validate()


        '{group.valid} change': ()->
            this.set_validity(this.options.group.valid())

        cancel_call_group_button:()->
            this.add_call_group_dialog.close_dialog()


        create_call_group:()->
            group_req ={}
            group_req.tenantid = this.group.attr('tenant_id')
            group_req.group_name = this.group.attr('group_name')
            group_req.extension_number = this.group.attr('extension_number')
            this.add_call_group_dialog.close_dialog()
            Group.add_group(group_req).done(()=>
                this.options.directory.load_all(this.options.tenant_id)
            ).fail(()=>
                console.log("add_group request failed")
            )
    })
)
