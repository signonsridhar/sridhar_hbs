define(['bases/model',
        '_',
        'models/auth/auth',
        'env!dev:models/extension/fixture/swap_extension',
        'env!dev:models/extension/fixture/add_ported_phonenumber_for_extension'
        'env!dev:models/extension/fixture/change_extension'
], (BaseModel,_,Auth)->
    BaseModel.extend({
       FORWARD:{
           EXT:'ext',
           PHONE:'phone_number'
       }

       add_ported_phonenumber_for_extension:(req)->
           $.post('/bss/extension?action=addportedphonenumberforextension', JSON.stringify(req))

       change_extension:(from_ext, to_extension)->
           req ={}
           req.from_extension_number = from_ext
           req.tenantid = Auth.get_auth().tenant_id
           req.to_extension_number = to_extension
           $.get('/bss/extension?action=changeextension', req)
    }, {


    },{})
)