define(['can_fixture', 'models/auth/fixture/authenticate'], (can, FixtureAuth)->

    can.fixture("GET /bss/user?action=getuser&accesskeyid=#{FixtureAuth.valid.access_key}&userid=#{FixtureAuth.valid.user_id}", (req, res)->

        return `{"response": {
  "service": "getuser",
  "response_code": 100,
  "execution_time": 28,
  "timestamp": "2014-01-29T00:54:15+0000",
  "response_data": {
    "tenant_id": 10000007,
    "partner_id": 10000000,
    "account_id": "15046488",
    "tenant_name": "aaaa",
    "status": "active",
    "primary_address_street1": "295 bernado ave",
    "primary_address_city": "mountain view",
    "primary_address_state": "CA",
    "primary_address_country": "US",
    "primary_address_zip": "94043",
    "language": "EN",
    "timezone": "AMERICA_LOS_ANGELES",
    "conference_enabled": false,
    "number_porting_enabled": false,
    "fax_enabled": false,
    "main_number": "16508000015",
    "has_default_main_number": false,
    "user": {
      "tenantid": 10000007,
      "userid": 10000001,
      "first_name": "aaa",
      "last_name": "aaaa",
      "timezone": "AMERICA_LOS_ANGELES",
      "language": "EN",
      "conferenceBridge": 1669881,
      "conference_bridge_pin": 9682,
      "conference_enabled": true,
      "is_administrator": true,
      "email": "sudha+00@choochee.com",
      "image_present": false
    },
    "bundles": [
      {
        "bundle_id": 10000009,
        "tenant_id": 10000007,
        "status": "OSSPROVISIONED",
        "is_assigned": true,
        "extensions": [
          {
            "extensionid": 10000023,
            "tenantid": 10000007,
            "extension_number": 201,
            "vm_forwarding_email": "sudha+00@choochee.com",
            "dnd_enabled": false,
            "call_waiting_enabled": false,
            "forwarding_enabled": false,
            "vm_forwarding_enabled": false,
            "international_calls_enabled": false,
            "devices": [
              {
                "deviceid": 10000009,
                "is_assigned": false,
                "extension": 201,
                "productid": "10261667",
                "product_sku": "SKU-CSO-IP303-001",
                "status": "order_initiated",
                "device_name": "Cisco IP303 Default Device",
                "registration_date": "2014-01-28 23:24:23.0",
                "rebooted_date": "2014-01-28 23:24:23.0",
                "creation_date": "2014-01-28 23:24:23.0",
                "order_id": "5726192",
                "needs_provisoining": false
              }
            ],
            "phone_numbers": [
              {
                "didid": 40000016,
                "partner_code": "tmus",
                "phonenumber": 16508000016,
                "caller_id": 0,
                "area_code": "650",
                "country_code": "1",
                "city": "Mountain View",
                "state": "CA",
                "is_conference": false,
                "is_toll_free": false,
                "is_ported": false,
                "is_assigned": true,
                "extension": 0,
                "type": "user_line",
                "phone_number_address": {
                  "did_id": 40000016,
                  "user_id": 10000001,
                  "extension_id": 10000023
                }
              }
            ],
            "group_members": [
              {
                "groupid": 10000014,
                "group_name": "Main",
                "group_extension": 200,
                "memberid": 10000001,
                "member_email_address": "sudha+00@choochee.com",
                "member_extensionid": 10000023,
                "member_extension_number": 201,
                "member_first_name": "aaa",
                "member_last_name": "aaaa",
                "enable_phone_ring": true
              },
              {
                "groupid": 10000015,
                "group_name": "Conference",
                "group_extension": 888,
                "memberid": 10000001,
                "member_email_address": "sudha+00@choochee.com",
                "member_extensionid": 10000023,
                "member_extension_number": 201,
                "member_first_name": "aaa",
                "member_last_name": "aaaa",
                "enable_phone_ring": true
              },

              {
                "groupid": 10000081,
                "group_name": "CG1",
                "group_extension": 411,
                "memberid": 10000001,
                "member_email_address": "sudha+00@choochee.com",
                "member_extensionid": 10000023,
                "member_extension_number": 201,
                "member_first_name": "aaa",
                "member_last_name": "aaaa",
                "enable_phone_ring": true
              }
            ]
          }
        ]
      },
      {
        "bundle_id": 10000001,
        "tenant_id": 10000007,
        "status": "OSSPROVISIONED",
        "is_assigned": true,
        "extensions": [
          {
            "extensionid": 10000027,
            "tenantid": 10000007,
            "extension_number": 203,
            "vm_forwarding_email": "sudha+00@choochee.com",
            "dnd_enabled": false,
            "call_waiting_enabled": false,
            "forwarding_enabled": false,
            "vm_forwarding_enabled": false,
            "international_calls_enabled": false,
            "devices": [
              {
                "deviceid": 10000001,
                "is_assigned": false,
                "extension": 203,
                "productid": "10260668",
                "product_sku": "SKU-POL-IP5000",
                "status": "order_initiated",
                "device_name": "Polycom IP5000",
                "registration_date": "2014-01-28 23:24:23.0",
                "rebooted_date": "2014-01-28 23:24:23.0",
                "creation_date": "2014-01-28 23:24:23.0",
                "order_id": "5726192",
                "needs_provisoining": false
              }
            ],
            "phone_numbers": [
              {
                "didid": 40000021,
                "partner_code": "tmus",
                "phonenumber": 16508000021,
                "caller_id": 0,
                "area_code": "650",
                "country_code": "1",
                "city": "Mountain View",
                "state": "CA",
                "is_conference": false,
                "is_toll_free": false,
                "is_ported": false,
                "is_assigned": true,
                "extension": 0,
                "type": "user_line",
                "phone_number_address": {
                  "did_id": 40000021,
                  "user_id": 10000001,
                  "extension_id": 10000027
                }
              }
            ],
            "group_members": [
              {
                "groupid": 10000014,
                "group_name": "Main",
                "group_extension": 200,
                "memberid": 10000001,
                "member_email_address": "sudha+00@choochee.com",
                "member_extensionid": 10000027,
                "member_extension_number": 203,
                "member_first_name": "aaa",
                "member_last_name": "aaaa",
                "enable_phone_ring": true
              }
            ]
          }
        ]
      }
    ]
  },
  "version": "1.0"
}}`
    )
)