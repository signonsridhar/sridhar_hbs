define([
    'bases/model',
    '_',
    'models/user/user',
    'env!dev:models/group/fixture/get_group_byid',
    'env!dev:models/group/fixture/set_group_settings',
    'env!dev:models/group/fixture/delete_group',
    'env!dev:models/group/fixture/add_group_recording',
    'env!dev:models/group/fixture/get_group_recording',
    'env!dev:models/group/fixture/add_group_members',
    'env!dev:models/group/fixture/delete_group_members',
    'env!dev:models/group/fixture/add_group',
    'env!dev:models/group/fixture/get_groups',
    'env!dev:models/group/fixture/change_ring_order',
    'env!dev:models/directory/fixture/get_company_directory'
], (BaseModel,_, User)->
    BaseModel.extend({
        id:'groupid'
        TYPE:'GROUP',
        delete_item:()->
            $.get('/bss/group?action=deletegroup', {groupid: this.attr('groupid')})
        add_group:(group)->
            $.post('/bss/group?action=addgroup', JSON.stringify(group))

        get_groups:(tenant_id)->
            $.get('/bss/group?action=getgroups', {tenantid: tenant_id}).then((response_data)=>
                mods = BaseModel.models.call(this, response_data.data.call_groups)
                mods
            )
        get_group_settings:(groupid)->
            $.get('/bss/group?action=getgroupbyid', {groupid: groupid}).then((response_data)=>
                BaseModel.model.call(this, response_data.data)
            )
    },{
        init:()->
            this.setup_validations()
            this.debounced_validate_extension_number_server= _.debounce(this.validate_extension_number_server, 300)

        validate_extension_number_server:()->
            $.get('/bss/extension?action=validateExtension',
            {tenantid: this.attr('tenant_id'), extension: this.attr('extension_number')})
            .then((resp)=>
                    if (resp.data == "true")
                        this.validity('extension_number', VALID.YES)
                    else
                        this.validity('extension_number', VALID.ERROR.INVALID)
                ).fail(()=>
                    this.validity('extension_number', VALID.ERROR.INVALID)
                )

        validations:{
            group_name:()->
                group_name = this.attr('group_name')
                this.check(group_name, VALID.ERROR.REQUIRED).notEmpty()
                this.check(group_name, VALID.ERROR.SIZE).len(2,40)
                this.check(group_name, VALID.ERROR.FORMAT).regex('^\\s*[a-z A-Z0-9+_. -]+[a-zA-Z0-9.-]+\\s*')
                this.validity('group_name', VALID.YES)

            extension_number:()->
                extension_number = this.attr('extension_number')
                this.check(extension_number, VALID.ERROR.REQUIRED).notEmpty()
                this.check(extension_number, VALID.ERROR.FORMAT).isNumeric()
                this.check(extension_number, VALID.ERROR.FORMAT).min(200).max(999)
                this.debounced_validate_extension_number_server()
        }

        delete_item:()->
            $.get('/bss/group?action=deletegroup', {groupid: this.attr('groupid')})
        get_id:()-> this.attr('groupid')
        get_name:()-> this.attr('group_name')
        get_enable_custom_greeting_flag:()-> this.attr('enable_custom_greeting')
        add_group_members:(group_request)->
            promise = new $.Deferred()
            $.post('/bss/group?action=addgroupmembers', JSON.stringify(group_request)).then((response_data)->
                promise.resolve(response_data.data)
            ).fail((response_data)->
                promise.reject(response_data.data)
            )
            promise

        delete_group_members:(group_request)->
            promise = new $.Deferred()
            $.post('/bss/group?action=deletegroupmembers', JSON.stringify(group_request)).then((response_data)->
                promise.resolve(response_data.data)
            ).fail((response_data)->
                promise.reject(response_data.data)
            )
            promise

        update_group_settings:(group_request)->
            promise = new $.Deferred()
            $.post('/bss/group?action=setgroupsettings', JSON.stringify(group_request)).then((response_data)->
                promise.resolve(response_data.data)
            ).fail((response_data)->
                promise.reject(response_data.data)
            )
            promise

        change_ring_order:(member_extensions)->
            $.post('/bss/group?action=changeringorder', JSON.stringify({groupid: this.attr('groupid'),member_extensions: member_extensions}))

        get_all_users:()->
            $.get('/bss/tenant?action=getcompanydirectory', {tenantid: this.attr('tenantid')}).then (response)=>
                groups = response.data.groups
                bundles = response.data.bundles
                console.log('bundles length', bundles.length)
                oss_provisioned_bundles = _.where(bundles, {status: "OSSPROVISIONED"})
                result =[]
                _.each(oss_provisioned_bundles, (bundle)=>
                    if(bundle.extensions)
                        bundle.user.member_extensionid = bundle.extensions[0].extensionid
                        bundle.user.member_extension_number = bundle.extensions[0].extension_number
                        bundle.user.member_first_name = bundle.user.first_name
                        bundle.user.member_last_name = bundle.user.last_name
                        result.push( bundle.user)
                )
                result

        add_group_recording:(recording)->
            $.post('/bss/group?action=addgrouprecording', {groupid: this.attr('groupid'),recording:recording})

        delete_group_recording:()->
            $.get('/bss/group?action=deletegroup', {groupid: this.attr('groupid')})

        get_group_recording:()->
            $.get('/bss/group?action=getgrouprecording', {groupid: this.attr('groupid')})

    })
)