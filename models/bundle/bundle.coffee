define(['bases/model',
        'models/phone_number/phone_number',
        'models/phone/phone',
        'libs/validator',
        '_',
        'env!dev:models/bundle/fixture/add_user_with_bundles',
        'env!dev:models/bundle/fixture/delete_bundle']
,(BaseModel, PhoneNumber,Phone, validator, _)->
    BaseModel.extend({
        id:'bundleid'
        TYPE:'BUNDLE'
        MODE:{
            PROVISIONED: 'OSSPROVISIONED'
            UNPROVISIONED:'UNPROVISIONED'
        },
        attributes:{
            phone_number: (raw)->
                if raw instanceof PhoneNumber then raw else new PhoneNumber(raw)
            device:(raw)->
                if raw instanceof Phone then raw else new Phone(raw)
        }
    }, {
        delete_item: (tenant_id)->
            req = { tenantid : tenant_id, bundleid:this.attr('bundle_id')}
            $.get('/bss/tenant?action=deletebundle',req)

        add_user_to_bundle:(user_request)->
            user_with_bundles_request = {}
            bundle_ids = []
            bundle_ids.push(this.attr('bundle_id'))

            user_with_bundles_request = {
                first_name: user_request.first_name
                last_name: user_request.last_name
                email: user_request.email
                bundle_ids: bundle_ids
            }
            $.post('/bss/user?action=adduserwithbundles', JSON.stringify(user_with_bundles_request))
    })
)