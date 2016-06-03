define([ 'can_fixture', 'Faker'], (can, Faker, State)->
    can.fixture('GET /bss/product?action=getdeviceproduct', (req, res)->
        return {
            "response":{
                "service":"getdeviceproduct",
                "response_code":100,
                "execution_time":3178,
                "timestamp":"2013-11-02T00:13:49+0000",
                "response_data":{
                    "products":[
                        {
                            "product_id":"10252267",
                            "product_type":"device",
                            "product_sub_type":"phone_device",
                            "name":"Polycom IP335",
                            "description":"SoundPoint IP 335, 2-line SIP desktop phone",
                            "sku":"SKU-POL-000001",
                            "model":"polycom",
                            "fulfillment_source":"scansource",
                            "fulfillment_provider_sku":"POL-220012375001",
                            "charges":[
                                {
                                    "amount":122.99,
                                    "currency":"usd"
                                }
                            ]
                        },
                        {
                            "product_id":"10252867",
                            "product_type":"device",
                            "product_sub_type":"phone_device",
                            "name":"Polycom IP450",
                            "description":"Polycom IP450",
                            "sku":"SKU-POL-000002",
                            "model":"polycom",
                            "fulfillment_source":"scansource",
                            "fulfillment_provider_sku":"POL-220012450001",
                            "charges":[
                                {
                                    "amount":250.0,
                                    "currency":"usd"
                                }
                            ]
                        },
                        {
                            "product_id":"10260667",
                            "product_type":"device",
                            "product_sub_type":"phone_device",
                            "name":"Polycom IP550",
                            "description":"Polycom IP550",
                            "sku":"SKU-POL-000003",
                            "model":"polycom",
                            "fulfillment_source":"scansource",
                            "fulfillment_provider_sku":"POL-220012550001",
                            "charges":[
                                {
                                    "amount":50.0,
                                    "currency":"usd"
                                }
                            ]
                        },
                        {
                            "product_id":"10260668",
                            "product_type":"device",
                            "product_sub_type":"phone_device",
                            "name":"Polycom IP5000",
                            "description":"Polycom IP5000",
                            "sku":"SKU-POL-000004",
                            "model":"polycom",
                            "fulfillment_source":"scansource",
                            "fulfillment_provider_sku":"POL-220030900025WPWR",
                            "charges":[
                                {
                                    "amount":449.99,
                                    "currency":"usd"
                                }
                            ]
                        },
                        {
                            "product_id":"10260669",
                            "product_type":"device",
                            "product_sub_type":"phone_device",
                            "name":"Cisco IP 303",
                            "description":"Cisco IP 303",
                            "sku":"SKU-CSO-000001",
                            "model":"cisco",
                            "fulfillment_source":"scansource",
                            "fulfillment_provider_sku":"CSO-220012375001",
                            "charges":[
                                {
                                    "amount":90.0,
                                    "currency":"usd"
                                }
                            ]
                        },
                        {
                            "product_id":"10261667",
                            "product_type":"device",
                            "product_sub_type":"phone_device",
                            "name":"Cisco IP303 Default Device",
                            "description":"Cisco IP303 Default Device (Free)",
                            "sku":"SKU-CSO-000002",
                            "model":"cisco",
                            "fulfillment_source":"scansource",
                            "fulfillment_provider_sku":"CSO-220012375001",
                            "charges":[
                                {
                                    "amount":0.0,
                                    "currency":"usd"
                                }
                            ]
                        }
                    ]
                },
                "version":"1.0"
            }
        }
    )
)