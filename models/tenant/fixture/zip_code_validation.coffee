define(['can_fixture'], (can)->

    can.fixture('GET /bss/system?action=resolveaddressbyzipcode', (req, resp)->

        switch req.data.zipcode
            when '00000'
                `{"response": {
                    "service": "resolveaddressbyzipcode",
                    "response_code": "1149",
                    "execution_time": "542",
                    "timestamp": "2013-10-05T00:22:58+0000",
                    "version": "1.0",
                    "error_message": "Address not unique"
                }}`
            else
                `{"response": {
                    "service": "resolveaddressbyzipcode",
                    "response_code": 100,
                    "execution_time": 6,
                    "timestamp": "2013-10-22T21:10:04+0000",
                    "response_data": {
                            "street_number": "",
                            "street_name": "",
                            "postal_code": "93103",
                            "state": "CA",
                            "city": "Santa Barbara",
                            "country": "US",
                            "latitude": "34",
                            "longitude": "-119",
                            "timeZone": "AMERICA_LOS_ANGELES",
                            "area_code": "93103"
                    },
                    "version": "1.0"
                }}`

    )
)