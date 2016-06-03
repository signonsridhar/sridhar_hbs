define([ 'can_fixture', 'Faker'], (can, Faker, State)->

    can.fixture('GET /bss/system?action=getstatelist', (req, res)->
        return {
        "response": {
            "execution_time": 220,
            "response_code": 100,
            "response_data": {
                "states": [{
                    "stateCode": "AL",
                    "stateName": "Alabama"
                }, {
                    "stateCode": "AK",
                    "stateName": "Alaska"
                }, {
                    "stateCode": "AS",
                    "stateName": "American Samoa"
                }, {
                    "stateCode": "AZ",
                    "stateName": "Arizona"
                }, {
                    "stateCode": "AR",
                    "stateName": "Arkansas"
                }, {
                    "stateCode": "CA",
                    "stateName": "California"
                }, {
                    "stateCode": "CO",
                    "stateName": "Colorado"
                }, {
                    "stateCode": "CT",
                    "stateName": "Connecticut"
                }, {
                    "stateCode": "DE",
                    "stateName": "Delaware"
                }, {
                    "stateCode": "DC",
                    "stateName": "District of Columbia"
                }, {
                    "stateCode": "FM",
                    "stateName": "Federated States of Micronesia"
                }, {
                    "stateCode": "FL",
                    "stateName": "Florida"
                }, {
                    "stateCode": "GA",
                    "stateName": "Georgia"
                }, {
                    "stateCode": "GU",
                    "stateName": "Guam"
                }, {
                    "stateCode": "HI",
                    "stateName": "Hawaii"
                }, {
                    "stateCode": "ID",
                    "stateName": "Idaho"
                }, {
                    "stateCode": "IL",
                    "stateName": "Illinois"
                }, {
                    "stateCode": "IN",
                    "stateName": "Indiana"
                }, {
                    "stateCode": "IA",
                    "stateName": "Iowa"
                }, {
                    "stateCode": "KS",
                    "stateName": "Kansas"
                }, {
                    "stateCode": "KY",
                    "stateName": "Kentucky"
                }, {
                    "stateCode": "LA",
                    "stateName": "Louisiana"
                }, {
                    "stateCode": "ME",
                    "stateName": "Maine"
                }, {
                    "stateCode": "MH",
                    "stateName": "Marshall Islands"
                }, {
                    "stateCode": "MD",
                    "stateName": "Maryland"
                }, {
                    "stateCode": "MA",
                    "stateName": "Massachusetts"
                }, {
                    "stateCode": "MI",
                    "stateName": "Michigan"
                }, {
                    "stateCode": "MN",
                    "stateName": "Minnesota"
                }, {
                    "stateCode": "MS",
                    "stateName": "Mississippi"
                }, {
                    "stateCode": "MO",
                    "stateName": "Missouri"
                }, {
                    "stateCode": "MT",
                    "stateName": "Montana"
                }, {
                    "stateCode": "NE",
                    "stateName": "Nebraska"
                }, {
                    "stateCode": "NV",
                    "stateName": "Nevada"
                }, {
                    "stateCode": "NH",
                    "stateName": "New Hampshire"
                }, {
                    "stateCode": "NJ",
                    "stateName": "New Jersey"
                }, {
                    "stateCode": "NM",
                    "stateName": "New Mexico"
                }, {
                    "stateCode": "NY",
                    "stateName": "New York"
                }, {
                    "stateCode": "NC",
                    "stateName": "North Carolina"
                }, {
                    "stateCode": "ND",
                    "stateName": "North Dakota"
                }, {
                    "stateCode": "MP",
                    "stateName": "Northern Mariana Islands"
                }, {
                    "stateCode": "OH",
                    "stateName": "Ohio"
                }, {
                    "stateCode": "OK",
                    "stateName": "Oklahoma"
                }, {
                    "stateCode": "OR",
                    "stateName": "Oregon"
                }, {
                    "stateCode": "PW",
                    "stateName": "Palau"
                }, {
                    "stateCode": "PA",
                    "stateName": "Pennsylvania"
                }, {
                    "stateCode": "PR",
                    "stateName": "Puerto Rico"
                }, {
                    "stateCode": "RI",
                    "stateName": "Rhode Island"
                }, {
                    "stateCode": "SC",
                    "stateName": "South Carolina"
                }, {
                    "stateCode": "SD",
                    "stateName": "South Dakota"
                }, {
                    "stateCode": "TN",
                    "stateName": "Tennessee"
                }, {
                    "stateCode": "TX",
                    "stateName": "Texas"
                }, {
                    "stateCode": "UT",
                    "stateName": "Utah"
                }, {
                    "stateCode": "VT",
                    "stateName": "Vermont"
                }, {
                    "stateCode": "VI",
                    "stateName": "Virgin Islands"
                }, {
                    "stateCode": "VA",
                    "stateName": "Virginia"
                }, {
                    "stateCode": "WA",
                    "stateName": "Washington"
                }, {
                    "stateCode": "WV",
                    "stateName": "West Virginia"
                }, {
                    "stateCode": "WI",
                    "stateName": "Wisconsin"
                }, {
                    "stateCode": "WY",
                    "stateName": "Wyoming"
                }]
            },
            "service": "getstatelist" ,
            "timestamp": "2013-10-03T18:43:50+0000",
            "version": "1.0"
        }
        }
    )

)