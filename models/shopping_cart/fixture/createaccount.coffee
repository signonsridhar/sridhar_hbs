define([ 'can_fixture', 'Faker'], (can, Faker)->

    can.fixture('POST /bss/account?action=createaccount', (req, res)->
        return {
            "response": {
                "service": "createaccount",
                "response_code": 100,
                "execution_time": 3151,
                "timestamp": "2013-10-15T22:22:13+0000",
                "response_data": {
                    "shopping_cart": {
                        "partner_code": "tmus",
                        "account_id": "13874236",
                        "product_orders": [
                            {
                                "quantity": 1,
                                "product_order_id": 10933233
                            },
                            {
                                "quantity": 1,
                                "product_order_id": 10933234
                            }
                        ]
                    },
                    "account_id": "13874236"
                }
            }
        }
    )
)
