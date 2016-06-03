define(['can_fixture'], (can)->
    can.fixture('GET /bss/product?action=getmasterplans',(req, res)->
        return {
            "response": {
                "service": "getmasterplans",
                "response_code": 100,
                "execution_time": 4791,
                "timestamp": "2013-10-23T19:24:31+0000",
                "response_data": {
                    "packages": [
                        {
                            "product_id": "10938822",
                            "product_type": "masterplan",
                            "name": "T-Mobile Extensions with Unlimited Domestic Calling Package (Dev)",
                            "description": "T-Mobile Extensions with Unlimited Domestic Calling Package",
                            "billing_period": 0,
                            "minimum_quantity": 1,
                            "toll_free_quantity": 0,
                            "regular_did_quantity": 0,
                            "device_quantity": 0,
                            "extensioin_quantity": 1,
                            "did_quantity": 2,
                            "line_quantity": 1,
                            "number_port": true,
                            "number_block": false,
                            "conference": true,
                            "charges": [
                                {
                                    "charge_type": "recurring",
                                    "amount": 0.0,
                                    "currency": "usd",
                                    "from_number_units": 1.0,
                                    "to_number_units": Infinity
                                }
                            ],
                            "products": [
                                {
                                    "product_id": "10785206",
                                    "product_type": "service",
                                    "product_sub_type": "extension",
                                    "name": "Extension Service",
                                    "description": "Extension Service",
                                    "charges": [
                                        {
                                            "charge_type": "recurring",
                                            "amount": 0.0,
                                            "currency": "usd",
                                            "from_number_units": 1.0,
                                            "to_number_units": Infinity
                                        }
                                    ]
                                },
                                {
                                    "product_id": "10787406",
                                    "product_type": "service",
                                    "product_sub_type": "conference",
                                    "name": "Conference Service",
                                    "description": "Conference Service",
                                    "charges": [
                                        {
                                            "charge_type": "recurring",
                                            "amount": 0.0,
                                            "currency": "usd",
                                            "from_number_units": 1.0,
                                            "to_number_units": Infinity
                                        }
                                    ]
                                },
                                {
                                    "product_id": "10787407",
                                    "product_type": "service",
                                    "product_sub_type": "chargeable_minutes",
                                    "name": "Chargeable Minutes",
                                    "description": "Chargeable Minutes",
                                    "charges": [
                                        {
                                            "charge_type": "usage",
                                            "amount": 0.0,
                                            "currency": "usd",
                                            "from_number_units": 1.0,
                                            "to_number_units": Infinity
                                        }
                                    ]
                                }
                            ],
                            "available_dids": [
                                {
                                    "product_id": "10933238",
                                    "product_type": "did",
                                    "product_sub_type": "toll_free_did",
                                    "name": "T-Mobile Toll Free Phone Number (Dev)",
                                    "description": "T-Mobile Toll Free Phone Number",
                                    "billing_period": 0,
                                    "minimum_quantity": 0,
                                    "toll_free_quantity": 0,
                                    "regular_did_quantity": 0,
                                    "device_quantity": 0,
                                    "extensioin_quantity": 0,
                                    "did_quantity": 0,
                                    "line_quantity": 0,
                                    "number_port": false,
                                    "number_block": false,
                                    "conference": false,
                                    "charges": [
                                        {
                                            "charge_type": "recurring",
                                            "amount": 5.0,
                                            "currency": "usd",
                                            "from_number_units": 1.0,
                                            "to_number_units": 1.0
                                        }
                                    ]
                                },
                                {
                                    "product_id": "10933239",
                                    "product_type": "did",
                                    "product_sub_type": "regular_did",
                                    "name": "T-Mobile Local Phone Number (Dev)",
                                    "description": "T-Mobile Local Phone Number",
                                    "billing_period": 0,
                                    "minimum_quantity": 0,
                                    "toll_free_quantity": 0,
                                    "regular_did_quantity": 0,
                                    "device_quantity": 0,
                                    "extensioin_quantity": 0,
                                    "did_quantity": 0,
                                    "line_quantity": 0,
                                    "number_port": false,
                                    "number_block": false,
                                    "conference": false,
                                    "charges": [
                                        {
                                            "charge_type": "recurring",
                                            "amount": 0.0,
                                            "currency": "usd",
                                            "from_number_units": 1.0,
                                            "to_number_units": 1.0
                                        }
                                    ]
                                }
                            ]
                        }
                    ]
                },
                "version": "1.0"
            }
        }
    )
)