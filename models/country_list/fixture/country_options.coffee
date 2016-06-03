define([ 'can_fixture', 'Faker'], (can, Faker, State)->

    can.fixture('GET /bss/system?action=getcountrylist', (req, res)->
        return {
            "response": {
                "execution_time": 220,
                "response_code": 100,
                "response_data": {
                    "countries": [
                        {
                            "countryCode": "AF",
                            "countryName": "Afghanistan",
                            "countryPhoneNumberCode": "+93"
                        },
                        {
                            "countryCode": "AL",
                            "countryName": "Albania",
                            "countryPhoneNumberCode": "+355"
                        },
                        {
                            "countryCode": "DZ",
                            "countryName": "Algeria",
                            "countryPhoneNumberCode": "+213"
                        },
                        {
                            "countryCode": "AS",
                            "countryName": "American Samoa",
                            "countryPhoneNumberCode": "+1684"
                        },
                        {
                            "countryCode": "AD",
                            "countryName": "Andorra",
                            "countryPhoneNumberCode": "+376"
                        },
                        {
                            "countryCode": "AO",
                            "countryName": "Angola",
                            "countryPhoneNumberCode": "+244"
                        },
                        {
                            "countryCode": "AI",
                            "countryName": "Anguilla",
                            "countryPhoneNumberCode": "+1264"
                        },
                        {
                            "countryCode": "AQ",
                            "countryName": "Antarctica",
                            "countryPhoneNumberCode": "+672"
                        },
                        {
                            "countryCode": "AG",
                            "countryName": "Antigua and Barbuda",
                            "countryPhoneNumberCode": "+1268"
                        },
                        {
                            "countryCode": "AR",
                            "countryName": "Argentina",
                            "countryPhoneNumberCode": "+54"
                        },
                        {
                            "countryCode": "AM",
                            "countryName": "Armenia",
                            "countryPhoneNumberCode": "+374"
                        },
                        {
                            "countryCode": "AW",
                            "countryName": "Aruba",
                            "countryPhoneNumberCode": "+297"
                        },
                        {
                            "countryCode": "AC",
                            "countryName": "Ascension Island",
                            "countryPhoneNumberCode": "+247"
                        },
                        {
                            "countryCode": "AU",
                            "countryName": "Australia",
                            "countryPhoneNumberCode": "+61"
                        },
                        {
                            "countryCode": "AT",
                            "countryName": "Austria",
                            "countryPhoneNumberCode": "+43"
                        },
                        {
                            "countryCode": "AZ",
                            "countryName": "Azerbaijan",
                            "countryPhoneNumberCode": "+994"
                        },
                        {
                            "countryCode": "BS",
                            "countryName": "Bahamas",
                            "countryPhoneNumberCode": "+1242"
                        },
                        {
                            "countryCode": "BH",
                            "countryName": "Bahrain",
                            "countryPhoneNumberCode": "+973"
                        },
                        {
                            "countryCode": "BD",
                            "countryName": "Bangladesh",
                            "countryPhoneNumberCode": "+880"
                        },
                        {
                            "countryCode": "BB",
                            "countryName": "Barbados",
                            "countryPhoneNumberCode": "+1246"
                        },
                        {
                            "countryCode": "BY",
                            "countryName": "Belarus",
                            "countryPhoneNumberCode": "+375"
                        },
                        {
                            "countryCode": "BE",
                            "countryName": "Belgium",
                            "countryPhoneNumberCode": "+32"
                        },
                        {
                            "countryCode": "BZ",
                            "countryName": "Belize",
                            "countryPhoneNumberCode": "+501"
                        },
                        {
                            "countryCode": "BJ",
                            "countryName": "Benin",
                            "countryPhoneNumberCode": "+229"
                        },
                        {
                            "countryCode": "BM",
                            "countryName": "Bermuda",
                            "countryPhoneNumberCode": "+1441"
                        },
                        {
                            "countryCode": "BT",
                            "countryName": "Bhutan",
                            "countryPhoneNumberCode": "+975"
                        },
                        {
                            "countryCode": "BO",
                            "countryName": "Bolivia",
                            "countryPhoneNumberCode": "+591"
                        },
                        {
                            "countryCode": "BA",
                            "countryName": "Bosnia and Herzegowina",
                            "countryPhoneNumberCode": "+387"
                        },
                        {
                            "countryCode": "BW",
                            "countryName": "Botswana",
                            "countryPhoneNumberCode": "+267"
                        },
                        {
                            "countryCode": "BR",
                            "countryName": "Brazil",
                            "countryPhoneNumberCode": "+55"
                        },
                        {
                            "countryCode": "BN",
                            "countryName": "Brunei Darussalam",
                            "countryPhoneNumberCode": "+673"
                        },
                        {
                            "countryCode": "BG",
                            "countryName": "Bulgaria",
                            "countryPhoneNumberCode": "+359"
                        },
                        {
                            "countryCode": "BF",
                            "countryName": "Burkina Faso",
                            "countryPhoneNumberCode": "+226"
                        },
                        {
                            "countryCode": "BI",
                            "countryName": "Burundi",
                            "countryPhoneNumberCode": "+257"
                        },
                        {
                            "countryCode": "KH",
                            "countryName": "Cambodia",
                            "countryPhoneNumberCode": "+855"
                        },
                        {
                            "countryCode": "CM",
                            "countryName": "Cameroon",
                            "countryPhoneNumberCode": "+237"
                        },
                        {
                            "countryCode": "CA",
                            "countryName": "Canada",
                            "countryPhoneNumberCode": "+1"
                        },
                        {
                            "countryCode": "CV",
                            "countryName": "Cape Verde",
                            "countryPhoneNumberCode": "+238"
                        },
                        {
                            "countryCode": "KY",
                            "countryName": "Cayman Islands",
                            "countryPhoneNumberCode": "+1345"
                        },
                        {
                            "countryCode": "CF",
                            "countryName": "Central African Republic",
                            "countryPhoneNumberCode": "+236"
                        },
                        {
                            "countryCode": "TD",
                            "countryName": "Chad",
                            "countryPhoneNumberCode": "+235"
                        },
                        {
                            "countryCode": "CL",
                            "countryName": "Chile",
                            "countryPhoneNumberCode": "+56"
                        },
                        {
                            "countryCode": "CN",
                            "countryName": "China",
                            "countryPhoneNumberCode": "+86"
                        },
                        {
                            "countryCode": "CX",
                            "countryName": "Christmas Island",
                            "countryPhoneNumberCode": "+61"
                        },
                        {
                            "countryCode": "CC",
                            "countryName": "Cocos (Keeling) Islands",
                            "countryPhoneNumberCode": "+61"
                        },
                        {
                            "countryCode": "CO",
                            "countryName": "Colombia",
                            "countryPhoneNumberCode": "+57"
                        },
                        {
                            "countryCode": "KM",
                            "countryName": "Comoros",
                            "countryPhoneNumberCode": "+269"
                        },
                        {
                            "countryCode": "CG",
                            "countryName": "Congo",
                            "countryPhoneNumberCode": "+242"
                        },
                        {
                            "countryCode": "CD",
                            "countryName": "Congo -Democractic Republic",
                            "countryPhoneNumberCode": "+243"
                        },
                        {
                            "countryCode": "CK",
                            "countryName": "Cook Islands",
                            "countryPhoneNumberCode": "+682"
                        },
                        {
                            "countryCode": "CR",
                            "countryName": "Costa Rica",
                            "countryPhoneNumberCode": "+506"
                        },
                        {
                            "countryCode": "CI",
                            "countryName": "Cote D'Ivoire",
                            "countryPhoneNumberCode": "+225"
                        },
                        {
                            "countryCode": "HR",
                            "countryName": "Croatia",
                            "countryPhoneNumberCode": "+385"
                        },
                        {
                            "countryCode": "CU",
                            "countryName": "Cuba",
                            "countryPhoneNumberCode": "+53"
                        },
                        {
                            "countryCode": "CY",
                            "countryName": "Cyprus",
                            "countryPhoneNumberCode": "+357"
                        },
                        {
                            "countryCode": "CZ",
                            "countryName": "Czech Republic",
                            "countryPhoneNumberCode": "+420"
                        },
                        {
                            "countryCode": "DK",
                            "countryName": "Denmark",
                            "countryPhoneNumberCode": "+45"
                        },
                        {
                            "countryCode": "DJ",
                            "countryName": "Djibouti",
                            "countryPhoneNumberCode": "+253"
                        },
                        {
                            "countryCode": "DM",
                            "countryName": "Dominica",
                            "countryPhoneNumberCode": "+1767"
                        },
                        {
                            "countryCode": "DO",
                            "countryName": "Dominican Republic",
                            "countryPhoneNumberCode": "+1809"
                        },
                        {
                            "countryCode": "EC",
                            "countryName": "Ecuador",
                            "countryPhoneNumberCode": "+593"
                        },
                        {
                            "countryCode": "EG",
                            "countryName": "Egypt",
                            "countryPhoneNumberCode": "+20"
                        },
                        {
                            "countryCode": "SV",
                            "countryName": "El Salvador",
                            "countryPhoneNumberCode": "+503"
                        },
                        {
                            "countryCode": "GQ",
                            "countryName": "Equatorial Guinea",
                            "countryPhoneNumberCode": "+240"
                        },
                        {
                            "countryCode": "ER",
                            "countryName": "Eritrea",
                            "countryPhoneNumberCode": "+291"
                        },
                        {
                            "countryCode": "EE",
                            "countryName": "Estonia",
                            "countryPhoneNumberCode": "+372"
                        },
                        {
                            "countryCode": "ET",
                            "countryName": "Ethiopia",
                            "countryPhoneNumberCode": "+251"
                        },
                        {
                            "countryCode": "FK",
                            "countryName": "Falkland Islands (Malvinas)",
                            "countryPhoneNumberCode": "+500"
                        },
                        {
                            "countryCode": "FO",
                            "countryName": "Faroe Islands",
                            "countryPhoneNumberCode": "+298"
                        },
                        {
                            "countryCode": "FJ",
                            "countryName": "Fiji",
                            "countryPhoneNumberCode": "+679"
                        },
                        {
                            "countryCode": "FI",
                            "countryName": "Finland",
                            "countryPhoneNumberCode": "+358"
                        },
                        {
                            "countryCode": "FR",
                            "countryName": "France",
                            "countryPhoneNumberCode": "+33"
                        },
                        {
                            "countryCode": "PF",
                            "countryName": "French Polynesia",
                            "countryPhoneNumberCode": "+689"
                        },
                        {
                            "countryCode": "TF",
                            "countryName": "French Southern Territories"
                        },
                        {
                            "countryCode": "GA",
                            "countryName": "Gabon",
                            "countryPhoneNumberCode": "+241"
                        },
                        {
                            "countryCode": "GM",
                            "countryName": "Gambia",
                            "countryPhoneNumberCode": "+220"
                        },
                        {
                            "countryCode": "GE",
                            "countryName": "Georgia",
                            "countryPhoneNumberCode": "+995"
                        },
                        {
                            "countryCode": "DE",
                            "countryName": "Germany",
                            "countryPhoneNumberCode": "+49"
                        },
                        {
                            "countryCode": "GH",
                            "countryName": "Ghana",
                            "countryPhoneNumberCode": "+233"
                        },
                        {
                            "countryCode": "GI",
                            "countryName": "Gibraltar",
                            "countryPhoneNumberCode": "+350"
                        },
                        {
                            "countryCode": "GR",
                            "countryName": "Greece",
                            "countryPhoneNumberCode": "+30"
                        },
                        {
                            "countryCode": "GL",
                            "countryName": "Greenland",
                            "countryPhoneNumberCode": "+299"
                        },
                        {
                            "countryCode": "GD",
                            "countryName": "Grenada",
                            "countryPhoneNumberCode": "+1473"
                        },
                        {
                            "countryCode": "GP",
                            "countryName": "Guadeloupe",
                            "countryPhoneNumberCode": "+590"
                        },
                        {
                            "countryCode": "GU",
                            "countryName": "Guam",
                            "countryPhoneNumberCode": "+1671"
                        },
                        {
                            "countryCode": "GT",
                            "countryName": "Guatemala",
                            "countryPhoneNumberCode": "+502"
                        },
                        {
                            "countryCode": "GN",
                            "countryName": "Guinea",
                            "countryPhoneNumberCode": "+224"
                        },
                        {
                            "countryCode": "GW",
                            "countryName": "Guinea-bissau",
                            "countryPhoneNumberCode": "+245"
                        },
                        {
                            "countryCode": "GY",
                            "countryName": "Guyana",
                            "countryPhoneNumberCode": "+592"
                        },
                        {
                            "countryCode": "HT",
                            "countryName": "Haiti",
                            "countryPhoneNumberCode": "+509"
                        },
                        {
                            "countryCode": "HN",
                            "countryName": "Honduras",
                            "countryPhoneNumberCode": "+504"
                        },
                        {
                            "countryCode": "HK",
                            "countryName": "Hong Kong",
                            "countryPhoneNumberCode": "+852"
                        },
                        {
                            "countryCode": "HU",
                            "countryName": "Hungary",
                            "countryPhoneNumberCode": "+36"
                        },
                        {
                            "countryCode": "IS",
                            "countryName": "Iceland",
                            "countryPhoneNumberCode": "+354"
                        },
                        {
                            "countryCode": "IN",
                            "countryName": "India",
                            "countryPhoneNumberCode": "+91"
                        },
                        {
                            "countryCode": "ID",
                            "countryName": "Indonesia",
                            "countryPhoneNumberCode": "+62"
                        },
                        {
                            "countryCode": "IR",
                            "countryName": "Iran",
                            "countryPhoneNumberCode": "+98"
                        },
                        {
                            "countryCode": "IQ",
                            "countryName": "Iraq",
                            "countryPhoneNumberCode": "+964"
                        },
                        {
                            "countryCode": "IE",
                            "countryName": "Ireland",
                            "countryPhoneNumberCode": "+353"
                        },
                        {
                            "countryCode": "IL",
                            "countryName": "Israel",
                            "countryPhoneNumberCode": "+972"
                        },
                        {
                            "countryCode": "IT",
                            "countryName": "Italy",
                            "countryPhoneNumberCode": "+39"
                        },
                        {
                            "countryCode": "JM",
                            "countryName": "Jamaica",
                            "countryPhoneNumberCode": "+1876"
                        },
                        {
                            "countryCode": "JP",
                            "countryName": "Japan",
                            "countryPhoneNumberCode": "+81"
                        },
                        {
                            "countryCode": "JO",
                            "countryName": "Jordan",
                            "countryPhoneNumberCode": "+962"
                        },
                        {
                            "countryCode": "KZ",
                            "countryName": "Kazakhstan",
                            "countryPhoneNumberCode": "+7"
                        },
                        {
                            "countryCode": "KE",
                            "countryName": "Kenya",
                            "countryPhoneNumberCode": "+254"
                        },
                        {
                            "countryCode": "KI",
                            "countryName": "Kiribati",
                            "countryPhoneNumberCode": "+686"
                        },
                        {
                            "countryCode": "KW",
                            "countryName": "Kuwait",
                            "countryPhoneNumberCode": "+965"
                        },
                        {
                            "countryCode": "KG",
                            "countryName": "Kyrgyzstan",
                            "countryPhoneNumberCode": "+996"
                        },
                        {
                            "countryCode": "LA",
                            "countryName": "Laos",
                            "countryPhoneNumberCode": "+856"
                        },
                        {
                            "countryCode": "LV",
                            "countryName": "Latvia",
                            "countryPhoneNumberCode": "+371"
                        },
                        {
                            "countryCode": "LB",
                            "countryName": "Lebanon",
                            "countryPhoneNumberCode": "+961"
                        },
                        {
                            "countryCode": "LS",
                            "countryName": "Lesotho",
                            "countryPhoneNumberCode": "+266"
                        },
                        {
                            "countryCode": "LR",
                            "countryName": "Liberia",
                            "countryPhoneNumberCode": "+231"
                        },
                        {
                            "countryCode": "LI",
                            "countryName": "Liechtenstein",
                            "countryPhoneNumberCode": "+423"
                        },
                        {
                            "countryCode": "LT",
                            "countryName": "Lithuania",
                            "countryPhoneNumberCode": "+370"
                        },
                        {
                            "countryCode": "LU",
                            "countryName": "Luxembourg",
                            "countryPhoneNumberCode": "+352"
                        },
                        {
                            "countryCode": "MO",
                            "countryName": "Macau",
                            "countryPhoneNumberCode": "+853"
                        },
                        {
                            "countryCode": "MK",
                            "countryName": "Macedonia",
                            "countryPhoneNumberCode": "+389"
                        },
                        {
                            "countryCode": "MG",
                            "countryName": "Madagascar",
                            "countryPhoneNumberCode": "+261"
                        },
                        {
                            "countryCode": "MW",
                            "countryName": "Malawi",
                            "countryPhoneNumberCode": "+265"
                        },
                        {
                            "countryCode": "MY",
                            "countryName": "Malaysia",
                            "countryPhoneNumberCode": "+60"
                        },
                        {
                            "countryCode": "MV",
                            "countryName": "Maldives",
                            "countryPhoneNumberCode": "+960"
                        },
                        {
                            "countryCode": "ML",
                            "countryName": "Mali",
                            "countryPhoneNumberCode": "+223"
                        },
                        {
                            "countryCode": "MT",
                            "countryName": "Malta",
                            "countryPhoneNumberCode": "+356"
                        },
                        {
                            "countryCode": "MH",
                            "countryName": "Marshall Islands",
                            "countryPhoneNumberCode": "+692"
                        },
                        {
                            "countryCode": "MR",
                            "countryName": "Mauritania",
                            "countryPhoneNumberCode": "+222"
                        },
                        {
                            "countryCode": "MU",
                            "countryName": "Mauritius",
                            "countryPhoneNumberCode": "+230"
                        },
                        {
                            "countryCode": "YT",
                            "countryName": "Mayotte"
                        },
                        {
                            "countryCode": "MX",
                            "countryName": "Mexico",
                            "countryPhoneNumberCode": "+52"
                        },
                        {
                            "countryCode": "FM",
                            "countryName": "Micronesia Federated States of",
                            "countryPhoneNumberCode": "+691"
                        },
                        {
                            "countryCode": "MD",
                            "countryName": "Moldova",
                            "countryPhoneNumberCode": "+373"
                        },
                        {
                            "countryCode": "MC",
                            "countryName": "Monaco",
                            "countryPhoneNumberCode": "+377"
                        },
                        {
                            "countryCode": "MN",
                            "countryName": "Mongolia",
                            "countryPhoneNumberCode": "+976"
                        },
                        {
                            "countryCode": "MS",
                            "countryName": "Montserrat",
                            "countryPhoneNumberCode": "+1664"
                        },
                        {
                            "countryCode": "MA",
                            "countryName": "Morocco",
                            "countryPhoneNumberCode": "+212"
                        },
                        {
                            "countryCode": "MZ",
                            "countryName": "Mozambique",
                            "countryPhoneNumberCode": "+258"
                        },
                        {
                            "countryCode": "MM",
                            "countryName": "Myanmar",
                            "countryPhoneNumberCode": "+95"
                        },
                        {
                            "countryCode": "NA",
                            "countryName": "Namibia",
                            "countryPhoneNumberCode": "+264"
                        },
                        {
                            "countryCode": "NR",
                            "countryName": "Nauru",
                            "countryPhoneNumberCode": "+674"
                        },
                        {
                            "countryCode": "NP",
                            "countryName": "Nepal",
                            "countryPhoneNumberCode": "+977"
                        },
                        {
                            "countryCode": "NL",
                            "countryName": "Netherlands",
                            "countryPhoneNumberCode": "+31"
                        },
                        {
                            "countryCode": "AN",
                            "countryName": "Netherlands Antilles",
                            "countryPhoneNumberCode": "+599"
                        },
                        {
                            "countryCode": "NC",
                            "countryName": "New Caledonia",
                            "countryPhoneNumberCode": "+687"
                        },
                        {
                            "countryCode": "NZ",
                            "countryName": "New Zealand",
                            "countryPhoneNumberCode": "+64"
                        },
                        {
                            "countryCode": "NI",
                            "countryName": "Nicaragua",
                            "countryPhoneNumberCode": "+505"
                        },
                        {
                            "countryCode": "NE",
                            "countryName": "Niger",
                            "countryPhoneNumberCode": "+227"
                        },
                        {
                            "countryCode": "NG",
                            "countryName": "Nigeria",
                            "countryPhoneNumberCode": "+234"
                        },
                        {
                            "countryCode": "NU",
                            "countryName": "Niue",
                            "countryPhoneNumberCode": "+683"
                        },
                        {
                            "countryCode": "NF",
                            "countryName": "Norfolk Island",
                            "countryPhoneNumberCode": "+672"
                        },
                        {
                            "countryCode": "KP",
                            "countryName": "North Korea",
                            "countryPhoneNumberCode": "+850"
                        },
                        {
                            "countryCode": "MP",
                            "countryName": "Northern Mariana Islands",
                            "countryPhoneNumberCode": "+1670"
                        },
                        {
                            "countryCode": "NO",
                            "countryName": "Norway",
                            "countryPhoneNumberCode": "+47"
                        },
                        {
                            "countryCode": "OM",
                            "countryName": "Oman",
                            "countryPhoneNumberCode": "+968"
                        },
                        {
                            "countryCode": "PK",
                            "countryName": "Pakistan",
                            "countryPhoneNumberCode": "+92"
                        },
                        {
                            "countryCode": "PW",
                            "countryName": "Palau",
                            "countryPhoneNumberCode": "+680"
                        },
                        {
                            "countryCode": "PA",
                            "countryName": "Panama",
                            "countryPhoneNumberCode": "+507"
                        },
                        {
                            "countryCode": "PG",
                            "countryName": "Papua New Guinea",
                            "countryPhoneNumberCode": "+675"
                        },
                        {
                            "countryCode": "PY",
                            "countryName": "Paraguay",
                            "countryPhoneNumberCode": "+595"
                        },
                        {
                            "countryCode": "PE",
                            "countryName": "Peru",
                            "countryPhoneNumberCode": "+51"
                        },
                        {
                            "countryCode": "PH",
                            "countryName": "Philippines",
                            "countryPhoneNumberCode": "+51"
                        },
                        {
                            "countryCode": "PN",
                            "countryName": "Pitcairn",
                            "countryPhoneNumberCode": "+870"
                        },
                        {
                            "countryCode": "PL",
                            "countryName": "Poland",
                            "countryPhoneNumberCode": "+48"
                        },
                        {
                            "countryCode": "PT",
                            "countryName": "Portugal",
                            "countryPhoneNumberCode": "+351"
                        },
                        {
                            "countryCode": "PR",
                            "countryName": "Puerto Rico",
                            "countryPhoneNumberCode": "+1"
                        },
                        {
                            "countryCode": "QA",
                            "countryName": "Qatar",
                            "countryPhoneNumberCode": "+974"
                        },
                        {
                            "countryCode": "RO",
                            "countryName": "Romania",
                            "countryPhoneNumberCode": "+40"
                        },
                        {
                            "countryCode": "RU",
                            "countryName": "Russia",
                            "countryPhoneNumberCode": "+7"
                        },
                        {
                            "countryCode": "RW",
                            "countryName": "Rwanda",
                            "countryPhoneNumberCode": "+250"
                        },
                        {
                            "countryCode": "SH",
                            "countryName": "Saint Helena",
                            "countryPhoneNumberCode": "+290"
                        },
                        {
                            "countryCode": "KN",
                            "countryName": "Saint Kitts and Nevis",
                            "countryPhoneNumberCode": "+1869"
                        },
                        {
                            "countryCode": "LC",
                            "countryName": "Saint Lucia",
                            "countryPhoneNumberCode": "+1758"
                        },
                        {
                            "countryCode": "PM",
                            "countryName": "Saint Pierre and Miquelon",
                            "countryPhoneNumberCode": "+508"
                        },
                        {
                            "countryCode": "VC",
                            "countryName": "Saint Vincent and the Grenadines",
                            "countryPhoneNumberCode": "+1784"
                        },
                        {
                            "countryCode": "WS",
                            "countryName": "Samoa",
                            "countryPhoneNumberCode": "+685"
                        },
                        {
                            "countryCode": "SM",
                            "countryName": "San Marino",
                            "countryPhoneNumberCode": "+378"
                        },
                        {
                            "countryCode": "ST",
                            "countryName": "Sao Tome and Principe",
                            "countryPhoneNumberCode": "+239"
                        },
                        {
                            "countryCode": "SA",
                            "countryName": "Saudi Arabia",
                            "countryPhoneNumberCode": "+966"
                        },
                        {
                            "countryCode": "SN",
                            "countryName": "Senegal",
                            "countryPhoneNumberCode": "+221"
                        },
                        {
                            "countryCode": "CS",
                            "countryName": "Serbia and Montenegro",
                            "countryPhoneNumberCode": "+381"
                        },
                        {
                            "countryCode": "SC",
                            "countryName": "Seychelles",
                            "countryPhoneNumberCode": "+248"
                        },
                        {
                            "countryCode": "SL",
                            "countryName": "Sierra Leone",
                            "countryPhoneNumberCode": "+232"
                        },
                        {
                            "countryCode": "SG",
                            "countryName": "Singapore",
                            "countryPhoneNumberCode": "+65"
                        },
                        {
                            "countryCode": "SK",
                            "countryName": "Slovakia",
                            "countryPhoneNumberCode": "+421"
                        },
                        {
                            "countryCode": "SI",
                            "countryName": "Slovenia",
                            "countryPhoneNumberCode": "+386"
                        },
                        {
                            "countryCode": "SB",
                            "countryName": "Solomon Islands",
                            "countryPhoneNumberCode": "+677"
                        },
                        {
                            "countryCode": "SO",
                            "countryName": "Somalia",
                            "countryPhoneNumberCode": "+252"
                        },
                        {
                            "countryCode": "ZA",
                            "countryName": "South Africa",
                            "countryPhoneNumberCode": "+27"
                        },
                        {
                            "countryCode": "KR",
                            "countryName": "South Korea",
                            "countryPhoneNumberCode": "+82"
                        },
                        {
                            "countryCode": "ES",
                            "countryName": "Spain",
                            "countryPhoneNumberCode": "+34"
                        },
                        {
                            "countryCode": "LK",
                            "countryName": "Sri Lanka",
                            "countryPhoneNumberCode": "+94"
                        },
                        {
                            "countryCode": "SD",
                            "countryName": "Sudan",
                            "countryPhoneNumberCode": "+249"
                        },
                        {
                            "countryCode": "SR",
                            "countryName": "Suriname",
                            "countryPhoneNumberCode": "+597"
                        },
                        {
                            "countryCode": "SJ",
                            "countryName": "Svalbard"
                        },
                        {
                            "countryCode": "SZ",
                            "countryName": "Swaziland",
                            "countryPhoneNumberCode": "+268"
                        },
                        {
                            "countryCode": "SE",
                            "countryName": "Sweden",
                            "countryPhoneNumberCode": "+46"
                        },
                        {
                            "countryCode": "CH",
                            "countryName": "Switzerland",
                            "countryPhoneNumberCode": "+41"
                        },
                        {
                            "countryCode": "SY",
                            "countryName": "Syria",
                            "countryPhoneNumberCode": "+963"
                        },
                        {
                            "countryCode": "TW",
                            "countryName": "Taiwan",
                            "countryPhoneNumberCode": "+886"
                        },
                        {
                            "countryCode": "TJ",
                            "countryName": "Tajikistan",
                            "countryPhoneNumberCode": "+992"
                        },
                        {
                            "countryCode": "TZ",
                            "countryName": "Tanzania",
                            "countryPhoneNumberCode": "+255"
                        },
                        {
                            "countryCode": "TH",
                            "countryName": "Thailand",
                            "countryPhoneNumberCode": "+66"
                        },
                        {
                            "countryCode": "TG",
                            "countryName": "Togo",
                            "countryPhoneNumberCode": "+228"
                        },
                        {
                            "countryCode": "TK",
                            "countryName": "Tokelau",
                            "countryPhoneNumberCode": "+690"
                        },
                        {
                            "countryCode": "TO",
                            "countryName": "Tonga",
                            "countryPhoneNumberCode": "+676"
                        },
                        {
                            "countryCode": "TT",
                            "countryName": "Trinidad and Tobago",
                            "countryPhoneNumberCode": "+1868"
                        },
                        {
                            "countryCode": "TN",
                            "countryName": "Tunisia",
                            "countryPhoneNumberCode": "+216"
                        },
                        {
                            "countryCode": "TR",
                            "countryName": "Turkey",
                            "countryPhoneNumberCode": "+90"
                        },
                        {
                            "countryCode": "TM",
                            "countryName": "Turkmenistan",
                            "countryPhoneNumberCode": "+993"
                        },
                        {
                            "countryCode": "TC",
                            "countryName": "Turks and Caicos Islands",
                            "countryPhoneNumberCode": "+1649"
                        },
                        {
                            "countryCode": "TV",
                            "countryName": "Tuvalu",
                            "countryPhoneNumberCode": "+688"
                        },
                        {
                            "countryCode": "UG",
                            "countryName": "Uganda",
                            "countryPhoneNumberCode": "+256"
                        },
                        {
                            "countryCode": "UA",
                            "countryName": "Ukraine",
                            "countryPhoneNumberCode": "+380"
                        },
                        {
                            "countryCode": "AE",
                            "countryName": "United Arab Emirates",
                            "countryPhoneNumberCode": "+971"
                        },
                        {
                            "countryCode": "GB",
                            "countryName": "United Kingdom",
                            "countryPhoneNumberCode": "+44"
                        },
                        {
                            "countryCode": "US",
                            "countryName": "United States",
                            "countryPhoneNumberCode": "+1"
                        },
                        {
                            "countryCode": "UY",
                            "countryName": "Uruguay",
                            "countryPhoneNumberCode": "+598"
                        },
                        {
                            "countryCode": "UZ",
                            "countryName": "Uzbekistan",
                            "countryPhoneNumberCode": "+998"
                        },
                        {
                            "countryCode": "VU",
                            "countryName": "Vanuatu",
                            "countryPhoneNumberCode": "+678"
                        },
                        {
                            "countryCode": "VA",
                            "countryName": "Vatican City State (Holy See)",
                            "countryPhoneNumberCode": "+39"
                        },
                        {
                            "countryCode": "VE",
                            "countryName": "Venezuela",
                            "countryPhoneNumberCode": "+58"
                        },
                        {
                            "countryCode": "VN",
                            "countryName": "Vietnam",
                            "countryPhoneNumberCode": "+84"
                        },
                        {
                            "countryCode": "VG",
                            "countryName": "Virgin Islands (British)",
                            "countryPhoneNumberCode": "+1284"
                        },
                        {
                            "countryCode": "VI",
                            "countryName": "Virgin Islands (U.S.)",
                            "countryPhoneNumberCode": "+1284"
                        },
                        {
                            "countryCode": "WF",
                            "countryName": "Wallis and Futuna Islands",
                            "countryPhoneNumberCode": "+681"
                        },
                        {
                            "countryCode": "EH",
                            "countryName": "Western Sahara"
                        },
                        {
                            "countryCode": "YE",
                            "countryName": "Yemen",
                            "countryPhoneNumberCode": "+967"
                        },
                        {
                            "countryCode": "ZR",
                            "countryName": "Zaire",
                            "countryPhoneNumberCode": "+243"
                        },
                        {
                            "countryCode": "ZM",
                            "countryName": "Zambia",
                            "countryPhoneNumberCode": "+260"
                        },
                        {
                            "countryCode": "ZW",
                            "countryName": "Zimbabwe",
                            "countryPhoneNumberCode": "+263"
                        }
                    ]
                },
                "service": "getstatelist" ,
                "timestamp": "2013-10-03T18:43:50+0000",
                "version": "1.0"
            }
        }
    )

)