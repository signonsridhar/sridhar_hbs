define([
    'bases/page'
    'models/group/group',
    'modules/set_vm/set_vm',
    'modules/file_uploader/file_uploader',
    'modules/settings/change_voicemail_pin/change_voicemail_pin',
    'modules/set_group_ring/set_group_ring',
    'modules/auto_attendant_settings/auto_attendant_settings',
    'models/auth/auth',
    'models/settings/settings',
    'modules/tab/tab',
    '_'
], (BasePage,Group,SetVM,EnableCustomGreeting,ChangeVMPin,EnableGroupRing,EnableAutoAttendant,Auth,Settings,Tab)->

    BasePage.extend({
        init:($elem, options)->
            this.setup_viewmodel({
            })
            if(options.models.group.value('group_name'))
                this.viewmodel.attr('group_name',options.models.group.attr('group_name'))
                this.render('group_settings/call_settings/call_settings_page')
                this.on()

                if(options.models.group.value('group_name') == 'Main')
                    this.viewmodel.attr("is_main_group",true)

                    this.options.group_options = new Tab(this.find('.main_group_tabs_container_js'), {
                        type:'call_settings_horizontal',
                        tabs:{
                            group: options.models.group
                            map:{

                                enable_auto_attendant:['Use Auto-Attendant Greeting',EnableAutoAttendant]
                                enable_custom_greeting: ['Use Custom Greeting',EnableCustomGreeting]
                                enable_group_ring: ['Ring Call Group Members',EnableGroupRing]
                            }
                            change:(key, item)=>
                                other_keys = _.without(["enable_auto_attendant","enable_custom_greeting","enable_group_ring"],key)

                                #hide other tabs
                                _.each other_keys, (key_map, map_item)=>
                                    this.element.find('.'+key_map+ '_container_js').hide()

                                #show selected tab
                                this.element.find('.'+key+ '_container_js').show()
                                this.key = new item[1](this.element.find('.'+key+ '_container_js'),{group:options.models.group})


                                #if no greetings, no api call
                                if(!options.models.group.attr('has_custom_greeting') && key == "enable_custom_greeting")
                                    return;

                                _.each other_keys, (key_map, map_item)=>
                                    options.models.group.attr(key_map,false)
                                #setting selected option to true
                                options.models.group.attr(key,true)
                                req = {
                                    groupid: options.models.group.attr('groupid')
                                    enable_auto_attendant: options.models.group.attr('enable_auto_attendant')
                                    enable_custom_greeting: options.models.group.attr('enable_custom_greeting')
                                    enable_group_ring: options.models.group.attr('enable_group_ring')
                                }

                                #updating settings
                                options.models.group.update_group_settings(req).done(()=>
                                ).fail((resp)=>
                                    console.log("setgroupsettings api failed")
                                )
                            renderer:(key, value)=>
                                "<span>#{value[0]}</span>"
                        }

                    })
                    if(options.models.group.attr('enable_auto_attendant'))
                        this.options.group_options.set_active('enable_auto_attendant')
                        this.key = new EnableAutoAttendant(this.element.find('.enable_auto_attendant_container_js'),{group:options.models.group})

                    else if(options.models.group.attr('enable_custom_greeting'))
                        this.options.group_options.set_active('enable_custom_greeting')
                        this.key = new EnableCustomGreeting(this.element.find('.enable_custom_greeting_container_js'),{group:options.models.group})

                    else if(options.models.group.attr('enable_group_ring'))
                        this.options.group_options.set_active('enable_group_ring')
                        this.key = new EnableGroupRing(this.element.find('.enable_group_ring_container_js'),{group:options.models.group})

                else
                    this.auto_attendant_option = new EnableAutoAttendant(this.find('.enable_auto_attendant_container_js'),{group:options.models.group})
                    this.upload_greetings = new EnableCustomGreeting(this.find('.enable_custom_greeting_container_js'),{group:options.models.group})
                    this.set_group_ring = new EnableGroupRing(this.find('.enable_group_ring_container_js'),{group:options.models.group})

                this.set_vm = new SetVM(this.find('.enable_vm_forward_email_container_js'),{group:options.models.group})
                #this part is for reusing module change_voicemail_pin
                window.settings = this.settings = this.options.settings = new Settings(Auth.get_auth().get_user().serialize())
                if(this.options.models.group.attr('extensions'))
                    BaseModel = can.Model.extend({},{})
                    this.options.model = new BaseModel({extension_number: this.options.models.group.attr('extensions.0.extension_number')})
                    this.change_vm_pin = new ChangeVMPin(this.find('.vmpin_container_js'),this.options)


    })
)