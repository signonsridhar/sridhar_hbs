define([
    'bases/control',
    'models/auth/auth',
    'modules/toggle/toggle',
    'libs/ajaxfileuploader',
    'css! modules/file_uploader/file_uploader'
], (BaseControl,Auth, Toggle)->
    BaseControl.extend({
        LANG:()->
            LANG = {
                upload_file_msg:' Please select a file to upload.'
                browse_btn: 'Select mp3 audio file',
                upload_btn: 'Upload',
                file_size_limit_msg: '1MB file size upload limit.',
                audio_label: 'Audio',
                greeting_label: 'Greeting',
                no_custom_greeting: 'Until you upload a new audio greeting, the previously selected option,'
                option_used: 'will be used.'
                upload_custom_greeting: 'Upload Custom Audio Greeting'
                consider_custom_greeting_msg: 'consider including the following information when using a custom audio greeting: pressing 1 to dial an extension, pressing 9 to dial by name, pressing a number for individual call groups set up (they will have the same key as in the auto-generated IVR).'
                unsupported_content: 'Your browser does not support the audio element.'

            }
            LANG
    },{
        init: (elem, options)->

            this.setup_viewmodel({
                show_file_name:true
                has_custom_greeting: options.group.attr('has_custom_greeting')
                enable_custom_greeting: options.group.attr('enable_custom_greeting')
                group_name: options.group.attr('group_name')
            })
            this.render('file_uploader/file_uploader')

            if(options.group.attr('enable_auto_attendant'))
                this.viewmodel.attr('previous_selected_option','auto attendant greeting')
            else if (options.group.attr('enable_group_ring'))
                this.viewmodel.attr('previous_selected_option','ring call group members')


            if (options.group.has_custom_greeting)
                if(options.group.group_name != 'Main')
                    #regular group toggle switch for ring group
                    this.options.custom_greeting_switch  = new Toggle(this.find('.custom_greeting_switch_js'), {
                        model: this.viewmodel,
                        attr:'enable_custom_greeting'
                    })
                access_key = Auth.get_auth().get_access_key()
                audio_url = '/bss/group?action=getgrouprecording&groupid='+options.group.groupid+'&accesskeyid='+access_key
                this.viewmodel.attr('audio_url', audio_url)
            this.on()


        '{viewmodel} enable_custom_greeting change':()->
            #regular group set toggle switch
            if(this.options.group.group_name != 'Main' && this.options.group.attr('has_custom_greeting'))

                this.options.group.attr('enable_custom_greeting',this.viewmodel.attr('enable_custom_greeting'))
                req = {
                    groupid: this.options.group.attr('groupid')
                    enable_custom_greeting: this.options.group.attr('enable_custom_greeting')
                }
                #updating settings
                this.options.group.update_group_settings(req).done(()=>
                ).fail((resp)=>
                    console.log("setgroupsettings api failed")
                )

        'input[name="file_data"] change':($el,e)->
            e.stopPropagation()
            $button = $el.siblings('.button')
            $fakeFile = $el.siblings('.file_holder')
            file_name = this.get_selected_file_name($el)
            #valid_file = this.validate_file(file_name)
            #if(valid_file)
            $button.text('File choosen')
            $fakeFile.text(file_name)
            console.log(file_name)

        get_selected_file_name:(file_path)->
            file_path_arr = $.trim(file_path.val()).split('\\')
            file_name = file_path_arr[file_path_arr.length-1]
            return file_name

        'input[name="file_submit_button"] click':($el,ev)->
            ev.stopPropagation()
            iframe = $('<iframe name="postiframe" id="postiframe" style="display: none" />')
            form = $("form[name='upload_greetings_form']")
            access_key = Auth.get_auth().get_access_key()
            recording_get_url = "/bss/group?action=addgrouprecording&accesskeyid=#{access_key}&groupid=#{this.options.group.groupid}"
            file_data = $("input[name='file_data']").val()

            #this handles all ajaxComplete requests, handle our specific request
            $(document).ajaxComplete(
                (e, xhr, settings) =>
                    console.log('settings ', settings)
                    if (settings.url == recording_get_url)
                        if(xhr.responseText.indexOf("ERROR") !=-1)
                            console.log('ERROR')
                        else
                            json = JSON.parse($(xhr.responseText).html())
                            response_code = json.response.response_code
                            if (response_code == 100)
                                #refreshpage
                                group_id = can.route.deparam(location.hash).group_id
                                window.location.reload(true);
                                #window.location = can.route.url({ main:'group_settings',group_id:group_id })

            )
            $.ajaxFileUpload({
                url:recording_get_url,
                data:{},
                secureuri:false,
                fileElementId:'file_data',
                dataType: 'json',
            });
            return false
    })
)
