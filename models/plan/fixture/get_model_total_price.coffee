define(['can_fixture'], (can)->
    can.fixture('GET /bss/product?action=getmodeltotalprice', (req, resp)->
        return `{
                    "response": {
                    "service": "getmodeltotalprice",
                    "response_code": 100,
                    "execution_time": 1332,
                    "timestamp": "2013-10-25T00:17:42+0000",
                    "response_data": {
                        "product_id": "10933235",
                        "name": "T-Mobile Line Bundle Prepaid Quarterly (Dev)",
                        "description": "TMobile Line Bundle Prepaid Quarterly",
                        "billing_period": 3,
                        "quantity": 5,
                        "minimum_quantity": 1,
                        "charges": [
                            {
                                "charge_type": "recurring",
                                "amount": 675.0,
                                "currency": "usd",
                                "from_number_units": 1.0,
                                "to_number_units": 5.0
                            }
                        ]
                    },
                    "version": "1.0"
            }
        }`
    )
)