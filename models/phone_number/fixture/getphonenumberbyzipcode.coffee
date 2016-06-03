define([ 'can_fixture', 'Faker'], (can, Faker, State)->
    can.fixture('GET /bss/phonenumber?action=getphonenumberbyzipcode', (req, res)->
        return {
        "response": {
            "service": "getphonenumberbyzipcode",
            "response_code": 100,
            "execution_time": "312",
            "timestamp": "2013-10-03T13:38:38+0000",
            "version": "1.0",
            "response_data": {
                "phone_numbers": [{
                    "didid": "34faa1763c4e4e429bb60bad7c508eff",
                    "phonenumber": "(402) 413-xxxx",
                    "area_code": "402",
                    "country_code": "US",
                    "city": "LINCOLN",
                    "state": "NE",
                    "lata": "958",
                    "is_toll_free": "false",
                    "is_sms": "false",
                    "is_t38": "false",
                    "is_conference": "false",
                    "provider_id": "inetwork",
                    "owner": "inetwork",
                    "tenantid": "",
                    "caller_id_cname": "+14024135555",
                    "status": "available",
                    "status_starttime": "2013-10-02T11:21:07-0700",
                    "status_endtime": "2013-10-02T13:21:07-0700",
                    "cost_month_did": "0.0",
                    "cost_min_usage": "0.0",
                    "cost_to_acquire": "0.0",
                    "partnerid": "aa360238bbc311e181006bb07251267f",
                    "environment": "staging",
                    "reservation_token": "",
                    "is_default_conference": "false",
                    "hold_starttime": "2013-09-13T00:01:10-0700",
                    "hold_duration": 0,
                    "require_address_verification": "false",
                    "address_verification_state": "none",
                    "status_starttime_display_date_time": "Wed, Oct 2, 2013 11:21:07 AM PDT",
                    "status_endtime_display_date_time": "Wed, Oct 2, 2013 1:21:07 PM PDT",
                    "hold_starttime_display_date_time": "Fri, Sep 13, 2013 12:01:10 AM PDT",
                    "is_deprecated": false
                }]
            }
        }
        }
    )
)
