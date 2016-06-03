define(['bases/control',
        '_',
        'models/group/group',
        'modules/toggle/toggle',
        'css!modules/auto_attendant_settings/auto_attendant_settings'
], (BaseControl,_,Group,Toggle)->
    BaseControl.extend({
        init:(elem, options)->

            this.setup_viewmodel({
                enable_company_extensions: options.group.attr('enable_company_extensions')
                enable_group_menu: options.group.attr('enable_group_menu')
                enable_company_directory: options.group.attr('enable_company_directory')
                use_in_groups_auto_attendant: options.group.attr('use_in_groups_auto_attendant')
            })

            if(options.group.group_name == 'Main')
                this.render('auto_attendant_settings/main_group',{group:this.options.group})

                this.options.dial_ext_switch  = new Toggle(this.find('.dial_ext_switch_js'), {
                    model: this.viewmodel,
                    attr:'enable_company_extensions'
                })
                this.options.group_menu_switch  = new Toggle(this.find('.group_menu_switch_js'), {
                    model:this.viewmodel,
                    attr:'enable_group_menu'
                })

                this.options.company_dir_switch  = new Toggle(this.find('.company_dir_switch_js'), {
                    model: this.viewmodel,
                    attr:'enable_company_directory'
                })
            else
                this.render('auto_attendant_settings/regular_group',{group:this.options.group})
                this.options.regular_auto_switch  = new Toggle(this.find('.regular_group_auto_switch_js'), {
                    model: this.viewmodel,
                    attr:'use_in_groups_auto_attendant'
                })

            this.on()

        '{viewmodel} enable_company_extensions change':()->
            req = {
                groupid: this.options.group.attr('groupid')
                enable_company_extensions: this.viewmodel.attr('enable_company_extensions')
            }
            this.options.group.attr('enable_company_extensions',this.viewmodel.attr('enable_company_extensions'))
            this.options.group.update_group_settings(req).done(()=>
            ).fail((resp)=>
                console.log("setgroupsettings api failed")
            )

        '{viewmodel} enable_group_menu change':()->
            req = {
                groupid: this.options.group.attr('groupid')
                enable_group_menu: this.viewmodel.attr('enable_group_menu')
            }
            this.options.group.attr('enable_group_menu',this.viewmodel.attr('enable_group_menu'))
            this.options.group.update_group_settings(req).done(()=>
            ).fail((resp)=>
                console.log("setgroupsettings api failed")
            )

        '{viewmodel} enable_company_directory change':()->
            req = {
                groupid: this.options.group.attr('groupid')
                enable_company_directory: this.viewmodel.attr('enable_company_directory')
            }
            this.options.group.attr('enable_company_directory',this.viewmodel.attr('enable_company_directory'))
            this.options.group.update_group_settings(req).done(()=>
            ).fail((resp)=>
                console.log("setgroupsettings api failed")
            )

        '{viewmodel} use_in_groups_auto_attendant change':()->
            #regular group settings
            req = {
                groupid: this.options.group.attr('groupid')
                use_in_groups_auto_attendant: this.viewmodel.attr('use_in_groups_auto_attendant')
            }
            this.options.group.attr('use_in_groups_auto_attendant',this.viewmodel.attr('use_in_groups_auto_attendant'))
            this.options.group.update_group_settings(req).done(()=>
            ).fail((resp)=>
                console.log("setgroupsettings api failed")
            )
    })
)
