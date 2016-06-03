define(['bases/model',
        'bases/model/list',
        '_',
        'models/extension/extension',
        'models/bundle/bundle',
        'models/user/user',
        'models/group/group',
        'models/group/main',
        'models/tenant/tenant',
        'models/phone_number/phone_number',
        'models/auth/auth',
        'env!dev:models/directory/fixture/get_company_directory'
        'env!dev:models/directory/fixture/configure_company_directory',
        'env!dev:models/directory/fixture/add_bundles'
], (BaseModel, BaseModelList,  _, Extension, Bundle, User, Group, MainLine, Tenant,PhoneNumber,Auth)->
    BaseModelList.extend({
        configure_company_directory:(bundle_request)->
            promise = new $.Deferred()
            $.post('/bss/tenant?action=configureCompanyDirectory', JSON.stringify(bundle_request)).then((response_data)->
                promise.resolve(response_data.data)
            ).fail((response_data)->
                promise.reject(response_data.data)
            )
            promise
    }, {
        load_wizard_bundles:(tenant_id)->
            $.get('/bss/tenant?action=getcompanydirectory', {tenantid: tenant_id}).then (response)=>
                bundles = response.data.bundles
                result = []
                _.each(bundles, (bundle)=>
                    result.push(new Bundle(bundle))
                )
                sorted_bundles = _.sortBy(result, (bundle_obj)->
                    return bundle_obj.extensions[0].extension_number
                )
                this.replace(sorted_bundles)
                this

        add_line_bundles:(line_request)->
            $.post('/bss/tenant?action=addbundles', JSON.stringify(line_request)).then (response)=>
                bundles = response.data.bundles
                result = []
                _.each(bundles, (bundle)=>
                    result.push(new Bundle(bundle))
                )
                this.replace(result)
                this

        get_tenant_info:()->
            auth_user = Auth.get_auth().get_user()

            tenant_info = _.pick(auth_user, ['account_id','tenant_id','partner_code','partner_id','primary_address_street1','primary_address_street2','primary_address_city','primary_address_state','primary_address_zip','primary_address_country'])
            tenant_info.admin = auth_user.user.email
            new Tenant(tenant_info)

        load_all:(tenant_id)->
            $.get('/bss/tenant?action=getcompanydirectory', {tenantid: tenant_id}).then (response)=>
                this.replace(this.parse_json_data_helper(response))
                this
        load_serialized:(directory_serialized)->
            this.replace(directory_serialized)
            this

        #returns Group, User(.group_members, .bundles)
        parse_json_data_helper:(response)->
            number_porting_enabled = response.data.number_porting_enabled
            groups = response.data.groups
            bundles = response.data.bundles
            console.log('bundles length', bundles.length)
            oss_provisioned_bundles = _.where(bundles, {status: "OSSPROVISIONED"})
            un_provisioned_bundles = _.where(bundles, {status: "UNPROVISIONED"})
            main_group = _.findWhere(groups, {group_name: "Main"})
            other_groups = _.filter(groups, (grp)->
                grp.group_name != "Main" and grp.group_name != "Conference"
            )
            result =[]
            users = _.pluck(oss_provisioned_bundles, "user")
            users = this.filter_unique_users_helper(users)
            result.push(new MainLine(main_group))
            _.each(users, (user)=>
                usr= new User(user)
                usr.attr('group_members', this.filter_user_group_membership_helper(user, groups))
                usr.attr('bundles', this.filter_user_bundles_with_porting_helper(user, oss_provisioned_bundles,number_porting_enabled))
                result.push(usr)
            )
            _.each(un_provisioned_bundles, (bundle)=>
                bundle.number_porting_enabled = number_porting_enabled
                result.push(new Bundle(bundle))
            )
            _.each(other_groups, (other_group)=>
                result.push(new Group(other_group))
            )
            result

        get_by_type:(type)->
            result = []
            result.push(item) for item in this when item.constructor.TYPE is type
            result

        ###
            get the extension number choices of the given group
        ###
        get_extension_choices_for_group:(group)->
            extensions = []
            bundles = this.get_assigned_bundles()
            query = {group_name: group.get_name()}
            console.log('bundle', bundles)
            for bundle in bundles
                extensions.push(bundle.extension_number) if _.findWhere(bundle.group_members, query).length > 0
            extensions


        get_assigned_bundles:()->
            _.difference(this, this.get_unassigned_bundles())

        get_unassigned_bundles:()->
            result = []
            _.each(this, (item)=>
                if (item instanceof Bundle)
                    result.push(item)
            )
            un_provisioned_bundles = _.where(result, {status: "UNPROVISIONED"})
            un_provisioned_bundles

        filter_unique_users_helper: (users)->
            userid_indexed_users = _.indexBy(users, "userid")
            user_list = []
            _.each userid_indexed_users, (val)->
                user_list.push(val)
            user_list

        filter_user_bundles_with_porting_helper: (user, bundles,number_porting_enabled)->
            usr_bundles = []
            _.each(bundles, (bundle)->
                bundle_user = bundle.user
                if (bundle_user.userid == user.userid)
                    bundle = _.omit(bundle, 'user')
                    bundle.number_porting_enabled = number_porting_enabled
                    usr_bundles.push(new Bundle(bundle))
            )
            _.flatten(usr_bundles)

        filter_user_group_membership_helper: (user, groups)->
            group_membership = []
            _.each(groups, (group)->
                group_members = group.members
                group_membership.push(_.filter(group_members, (group_member)->
                    return group_member.memberid == user.userid
                ))
            )
            _.flatten(group_membership)


        get_configure_bundle_request:(bundles)->
            new_bundles = []

            for bundle_elem in bundles
                extensions = bundle_elem.extensions
                extensionArr = []
                phone_numbers_arr = []
                devices_arr = []
                unless _.isEmpty(extensions)
                    extensions = extensions[0]
                    devices = extensions.devices
                    phone_numbers = extensions.phone_numbers
                    unless _.isEmpty(devices)
                        devices = devices[0]
                        devices_arr.push(
                            device_id: devices.deviceid,
                            product_sku: devices.product_sku
                        )
                    unless _.isEmpty(phone_numbers)
                        phone_numbers = phone_numbers[0]
                        if(phone_numbers.olddidid)
                            phone_numbers_arr.push(
                                did_id: phone_numbers.didid,
                                old_did_id: phone_numbers.olddidid
                            )
                        else
                            phone_numbers_arr.push(
                                did_id: phone_numbers.didid,
                                old_did_id: phone_numbers.didid
                            )
                    extensionArr.push(
                        extension_id: extensions.extensionid,
                        extension:extensions.extension_number
                        phone_numbers: phone_numbers_arr,
                        devices: devices_arr

                    )
                new_bundles.push(
                    bundle_id : bundle_elem.bundle_id,
                    user : { first_name : bundle_elem.user.first_name, last_name:  bundle_elem.user.last_name ,email:  bundle_elem.user.email }
                    extensions: extensionArr
                )
            return {bundles: new_bundles}



    })
)