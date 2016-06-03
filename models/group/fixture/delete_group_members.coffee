define(['can_fixture'], (can)->
    can.fixture('POST /bss/group?action=deletegroupmembers', (req, resp)->
        return `{
           "response":{
              "service":"deletegroupmembers",
              "response_code":100,
              "execution_time":43,
              "timestamp":"2013-11-14T18:03:43+0000",
              "response_data":{
                 "groupid":10000083,
                 "tenantid":10000045,
                 "group_name":"Main",
                 "group_call_type":"ivr",
                 "voicemail_forward_email":"sudha+3@choochee.com",
                 "enable_voicemail_forward_email":true,
                 "enable_voicemail":true,
                 "allow_member_forward":false,
                 "enable_group_ring":false,
                 "enable_custom_greeting":false,
                 "enable_auto_attendant":true,
                 "enable_group_menu":true,
                 "enable_company_directory":true,
                 "enable_company_extensions":true,
                 "enable_dnd":false,
                 "extensions":[
                    {
                       "extensionid":10000963,
                       "tenantid":10000045,
                       "extension_number":200,
                       "vm_forwarding_email":"sudha+3@choochee.com",
                       "dnd_enabled":false,
                       "call_waiting_enabled":false,
                       "forwarding_enabled":false,
                       "vm_forwarding_enabled":true,
                       "international_calls_enabled":false,
                       "devices":[

                       ],
                       "phone_numbers":[
                          {
                             "didid":20000486,
                             "partner_code":"tmus",
                             "phonenumber":18328000486,
                             "caller_id":0,
                             "area_code":"832",
                             "country_code":"1",
                             "city":"Houston",
                             "state":"TX",
                             "is_conference":false,
                             "is_toll_free":false,
                             "is_assigned":true,
                             "extension":0,
                             "type":"main_line",
                             "phone_number_address":{
                                "did_id":20000486,
                                "user_id":10000046,
                                "extension_id":10000963,
                                "address_street1":"295 N Bernado Ave",
                                "address_street2":"295 N Bernado Ave",
                                "address_city":"Mountain view",
                                "address_state":"CA",
                                "address_country":"US",
                                "address_zip":"94043"
                             }
                          }
                       ],
                       "group_members":[

                       ]
                    }
                 ],
                 "members":[
                    {
                       "groupid":10000083,
                       "group_name":"Main",
                       "mebmer_extensionid":10000957,
                       "member_extension_number":202,
                       "enable_phone_ring":true
                    }
                 ]
              },
              "version":"1.0"
           }
        }`
    )
)