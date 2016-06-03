define(['can_fixture'], (can)->

    raw_data = `{

        'United States': {
                "response": {
                "service": "getratetable",
                "response_code": 100,
                "execution_time": 20,
                "timestamp": "2013-12-17T21:46:57+0000",
                "response_data": {
                    "rates": [
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "American Samoa",
                        "ratepermin": "0.104"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Anguilla",
                        "ratepermin": "0.196"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Anguilla-Cellular",
                        "ratepermin": "0.322"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Anguilla-Info",
                        "ratepermin": "1.598"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Antigua and Barbuda",
                        "ratepermin": "0.207"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Bahamas",
                        "ratepermin": "0.069"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Bahamas-Info",
                        "ratepermin": "1.598"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Barbados",
                        "ratepermin": "0.149"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Barbados-Cellular",
                        "ratepermin": "0.38"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Barbados-Mobile-CW",
                        "ratepermin": "0.299"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Bermuda",
                        "ratepermin": "0.126"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Bermuda-Info",
                        "ratepermin": "1.598"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "British Virgin Islands",
                        "ratepermin": "0.38"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "British Virgin Islands-Info",
                        "ratepermin": "1.598"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Canada",
                        "ratepermin": "0.023"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Canada-Info",
                        "ratepermin": "1.598"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Canada-The Northwest Territories B",
                        "ratepermin": "0.322"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Cayman Islands",
                        "ratepermin": "0.126"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Cayman Islands-Cellular",
                        "ratepermin": "0.287"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Cayman Islands-Info",
                        "ratepermin": "1.598"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Cayman Islands-Special Services",
                        "ratepermin": "0.287"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Dominica",
                        "ratepermin": "0.368"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Dominica-Info",
                        "ratepermin": "1.598"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Dominican Republic",
                        "ratepermin": "0.058"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Dominican Republic-Cellular",
                        "ratepermin": "0.299"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Dominican Republic-Info",
                        "ratepermin": "1.598"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Dominican Republic-Mobile-Centennial",
                        "ratepermin": "0.138"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Dominican Republic-Mobile-Orange",
                        "ratepermin": "0.138"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Dominican Republic-Mobile-Orange",
                        "ratepermin": "0.299"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Dominican Republic-Mobile-Tricom",
                        "ratepermin": "0.126"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Dominican Republic-Mobile-Tricom",
                        "ratepermin": "0.299"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Dominican Republic-Mobile-Verizon",
                        "ratepermin": "0.126"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Dominican Republic-Mobile-Verizon",
                        "ratepermin": "0.299"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Dominican Republic-Overlay-Mobile-Centenni",
                        "ratepermin": "0.138"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Dominican Republic-Overlay-Mobile-Centenni",
                        "ratepermin": "0.299"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Dominican Republic-Overlay-Mobile-Centennia",
                        "ratepermin": "0.299"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Dominican Republic-Overlay-Mobile-Orange",
                        "ratepermin": "0.126"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Dominican Republic-Overlay-Mobile-Orange",
                        "ratepermin": "0.299"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Dominican Republic-Overlay-Mobile-Verizon",
                        "ratepermin": "0.126"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Dominican Republic-Overlay-Mobile-Verizon",
                        "ratepermin": "0.299"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Dominican Republic-Santago",
                        "ratepermin": "0.299"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Dominican Republic-Santo Domingo",
                        "ratepermin": "0.299"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Dominican Republic-Special Services",
                        "ratepermin": "0.299"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Grenada",
                        "ratepermin": "0.196"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Grenada-Cellular",
                        "ratepermin": "0.368"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Grenada-Info",
                        "ratepermin": "1.598"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Grenada-Mobile-Digcel",
                        "ratepermin": "0.31"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Grenada-Mobile-Other",
                        "ratepermin": "0.299"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Grenada-Special Services",
                        "ratepermin": "0.368"
                    },
                    {
                        "countrycode": "1",
                        "country": "Canada",
                        "description": "Guam",
                        "ratepermin": "0.058"
                    }
                    ]
                },
                "version": "1.0"
            }
        },

        'Indonesia': {
                "response": {
                "service": "getratetable",
                "response_code": 100,
                "execution_time": 19,
                "timestamp": "2013-12-17T21:41:46+0000",
                "response_data": {
                    "rates": [
                    {
                        "countrycode": "62",
                        "country": "Indonesia",
                        "description": "Indonesia",
                        "ratepermin": "0.126"
                    },
                    {
                        "countrycode": "62",
                        "country": "Indonesia",
                        "description": "Indonesia-Cellular",
                        "ratepermin": "0.172"
                    },
                    {
                        "countrycode": "62",
                        "country": "Indonesia",
                        "description": "Indonesia-Jakarta",
                        "ratepermin": "0.058"
                    },
                    {
                        "countrycode": "62",
                        "country": "Indonesia",
                        "description": "Indonesia-Mobile-Indosat",
                        "ratepermin": "0.172"
                    },
                    {
                        "countrycode": "62",
                        "country": "Indonesia",
                        "description": "Indonesia-Mobile-Telkomsel",
                        "ratepermin": "0.172"
                    },
                    {
                        "countrycode": "62",
                        "country": "Indonesia",
                        "description": "Indonesia-Mobile-XL",
                        "ratepermin": "0.172"
                    },
                    {
                        "countrycode": "62",
                        "country": "Indonesia",
                        "description": "Indonesia-Surabaya",
                        "ratepermin": "0.058"
                    }
                    ]
                },
                "version": "1.0"
            }
        }

    }`
    for country_code, response of raw_data
        do(country_code, response)->
            can.fixture("/bss/rate?action=getratetable&filter=partnerid=10000000;country=#{country_code}",(req, res)->
                return response
            )
)