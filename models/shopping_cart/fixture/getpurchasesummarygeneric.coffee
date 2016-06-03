define(['can_fixture'], (can)->
    can.fixture('POST /bss/order?action=getpurchasesummarygeneric',(req, res)->
        return `{
            "response": {
                "service": "getpurchasesummarygeneric",
                "response_code": 100,
                "execution_time": 1193,
                "timestamp": "2013-11-14T02:07:34+0000",
                "response_data": {
                    "amount": 753.97998046875,
                    "tax_amount": 0.0,
                    "total_amount_before_taxes": 315.0,
                    "total_amount_after_taxes": 315.0,
                    "invoice_items": [
                        {
                            "product_id": "10252267",
                            "name": "Polycom IP335",
                            "amount": 253.98,
                            "quantity": 2.0
                        },
                        {
                            "product_id": "10252867",
                            "name": "Polycom IP450",
                            "amount": 500.0,
                            "quantity": 2.0
                        }
                    ]
                },
                "version": "1.0"
            }
        }`
    )
)