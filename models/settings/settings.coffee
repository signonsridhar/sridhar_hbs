define([
    'bases/model',
    'models/extension/extension',
    'models/group/group',
    'models/group/main',
    'models/tenant/tenant',
    'models/phone_number/phone_number'
    '_',
    'bluebird',
    'env!dev:models/settings/fixture/get_user'
], (BaseModel, Extension, Group, Main, Tenant,PhoneNumber, _, Promise)->

    Settings = BaseModel.extend({


    }, {
        init:(authenticated_user_raw)->
            this.attr(authenticated_user_raw)

        get_extensions_for_group:(group_name)->
            this.get_all_extensions_chained().flatten().pluck('extension').value()

        get_left_nav:(user_id)->

            #get group_members that are empty out of bundles->extensions for the me me me , return User

            me_me_me = this.get_all_extensions_chained().map((data)->
                new Extension(data)
            ).value()

            #get group members that have the given user as one of the members return Group

            groups = this.get_other_groups().map((raw_group)->
                        new Group(raw_group)
                    ).compact().value()


            #get Main
            main = this.get_main()
            me_me_me = me_me_me.concat(groups)
            me_me_me = me_me_me.concat(main) if main
            return me_me_me



        get_all_extensions_chained:()->
            _.chain(this.bundles).pluck('extensions').compact().pluck(0).flatten().compact()

        get_group_members:()->
            group_ext_unique_check = {}
            this.get_all_extensions_chained().pluck('group_members').filter( (group_members)-> group_members.length > 0)
            .map((group_members)->
                result = []
                for group_member in group_members
                    ext = group_member.group_extension
                    if not group_ext_unique_check[ext]?
                        result.push(group_member)
                        group_ext_unique_check[ext] = true
                result
            ).flatten().compact()

        get_other_groups:()->
            this.get_group_members().filter((item)->
                item.group_name != 'Conference' and item.group_name != 'Main'
            )
        get_main:()->
            raw_val = this.get_group_members().where({group_name: 'Main'}).first().value()
            if raw_val
                return new Main(raw_val)
            else
                return null

        ###
            number:
            extension:
            tenantid:
            forwarding_type: 'none', 'phone_number', 'ext', 'all'
            forwarding: enabled on or off flag
        ###
        forward_call_to_number:(data)->

            if data.country_code == 'ext'
                data.forwarding_type = 'ext'
            else
                data.forwarding_type = 'phone_number'
                #unmask non-digit literals from phone number
                data.number = data.country_code + data.number.replace(/[^\d]/g, "")

            data.forwarding = if data.forwarding then 'on' else 'off'


            if data.enabled and _.isEmpty(data.number)
                throw new Error(VALID.ERROR.REQUIRED)
            req = {
                tenant_id: data.tenantid,
                extension: data.extension,
                forwarding: data.forwarding,
                forwarding_type: data.forwarding_type,
                number: data.number,
                country_code: data.country_prefix
            }
            $.post('/bss/extension?action=setCallForwarding', JSON.stringify(req))

        ###
            tenantid:
            extension:
            email:
            forwarding: enabled on or off
        ###
        forward_call_to_email:(data)->
            data.forwarding = if data.enabled then 'on' else 'off'
            data.type = 'email'

            throw new Error(VALID.ERROR.REQUIRED) if data.enabled and _.isEmpty(data.email)
            req= {
                tenantid: data.tenantid,
                extension: data.extension,
                forwarding: data.forwarding,
                email: $.trim(data.email)
            }
            $.get('/bss/extension?action=setvmforwarding', req)

        change_user_vmpin:(data)->
            throw new Error(VALID.ERROR.EQUAL) if data.new_pin != data.confirm_pin
            req = {
                pin: data.new_pin,
                extension: data.extension,
                tenant_id: data.tenantid
            }
            $.post('/bss/extension?action=changeuservmpin', JSON.stringify(req))

        change_group_vmpin:(data)->
            throw new Error(VALID.ERROR.EQUAL) if data.new_pin != data.confirm_pin
            req = {
                group_id: data.group_id
                pin: data.new_pin
            }
            $.post('/bss/group?action=changegroupvmpin', JSON.stringify(req))


        get_dnd_flag:()->
            this.get_all_extensions_chained().first().pick('dnd_enabled').values().first().value()

        get_extension_choices_for_group:()->
            this.get_all_extensions_chained().pluck('extension_number').value()

        toggle_dnd:(flag, tenant_id)->
            #/bss/extension?action=pbxLineDnd
            promises = []
            this.get_all_extensions_chained().each((raw_ext)->
                req = {extension:raw_ext.extension_number,do_not_disturb:flag,tenant_id: tenant_id}
                promise = $.post('/bss/extension?action=enablednd',JSON.stringify(req))
                promises.push(promise)
            )

            Promise.all(promises)

        extract_tenant:()->
            raw_tenant = _.pick(this, ['primary_address_city', 'primary_address_country','primary_address_state','primary_address_street1','primary_address_zip','tenant_id', 'tenant_name'])
            raw_tenant.name = raw_tenant.tenant_name
            new Tenant(raw_tenant)

        change_moderator_pin:(req)->
            $.post("/bss/user?action=changeuserconferencebridgepin", JSON.stringify(req))

        ###
            {
              "user_id" : 10000005,
              "extension_id" : "10000020",
              "did_id" : "10000018",
              "address_street1" : "190 Ryland Street",
              "address_street2" : "apt 5110",
              "address_city":"san jose"
              "address_state" : "CA",
              "address_country" : "US",
              "address_zip":"95110"
              "special_instructions" : "get a wheel chair"
            }
        ###
        change_phone_number_location:(extras, tenant)->
            #convert tenant to data
            data = {
                user_id : extras.userid,
                extension_id : extras.extensionid,
                did_id : extras.didid,
                address_street1: tenant.primary_address_street1
                address_street2: tenant.primary_address_street2
                address_city: tenant.primary_address_city
                address_state: tenant.primary_address_state
                address_country: tenant.primary_address_country
                address_zip: tenant.primary_address_zip,
            }

            $.post('/bss/phonenumberaddress?action=updatephonenumberaddress', JSON.stringify(data))
    })

    Settings
)