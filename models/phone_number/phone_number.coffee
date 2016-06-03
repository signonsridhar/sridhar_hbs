define(['bases/model',
        '_',
        'env!dev:models/phone_number/fixture/getportedphonenumbers',
        'env!dev:models/phone_number/fixture/getphonenumber',
        'env!dev:models/phone_number/fixture/gettollfreenumbers',
        'env!dev:models/phone_number/fixture/getphonenumberbyzipcode',
        'env!dev:models/phone_number/fixture/reserve_number',
        'env!dev:models/phone_number/fixture/unreserve_number',
        'env!dev:models/phone_number/fixture/get_conference_numbers'
        'env!dev:models/phone_number/fixture/portphonenumber'
], (BaseModel, _, GetPhoneNumbers)->
    BaseModel.extend({
        id:'phonenumber',
        TYPE:'PHONE_NUMBER'
        models: (data)->
            BaseModel.models.call(this, data.data.phone_numbers);

        get_ported_numbers:(tenantid)->
            $.get('/bss/tenant?action=getportedphonenumbers', {tenantid:tenantid}).then((response_data )=>
                mods = BaseModel.models.call(this, response_data.data.phone_numbers)
                return mods
            )

        request_number_porting:(tenantid)->
            $.get('/bss/phonenumber?action=portphonenumber', {tenantid:tenantid})

        find_local: (phoneOptions)->
            $.get('/bss/phonenumber?action=getavailablephonenumbers', phoneOptions).then((response_data )=>
                mods = BaseModel.models.call(this, response_data.data.phone_numbers)
                return mods
            )

        reserve_number: (did, partner_id, tenant_id)->
            $.post('/bss/phonenumber?action=reservephonenumber', JSON.stringify(did)).then((response_data)=>
                mod = BaseModel.model.call(this, response_data.data)
                return mod
            )


        unreserve_number: (did_id)->
            $.get('/bss/phonenumber?action=unreservephonenumber', {didid: did_id})

        find_toll: (phoneOptions)->
            $.get('/bss/phonenumber?action=gettollfreenumbers', phoneOptions).then((response_data )=>
                mods = BaseModel.models.call(this, response_data.data.phone_numbers)
                return mods
            )

        find_phone_number_by_zipcode:(phone_options)->
            request = $.get('/bss/phonenumber?action=getphonenumberbyzipcode', phone_options)
            chained_promise = request.then((response_data )=>
                phone_numbers = response_data.data.phone_numbers;
                if (phone_numbers.length)
                    phone_number = phone_numbers[0]
                    if (phone_number)
                        return this.reserve_number(phone_number, phone_options.partnerid, null)
                return null
            )
            return chained_promise

        get_conference_numbers:(phone_options)->
            $.get('/bss/phonenumber?action=getConferencePhoneNumbers', phone_options).then((response_data )=>
                mods = BaseModel.models.call(this, response_data.data.phone_numbers)
                return mods
            )

    },{})
)