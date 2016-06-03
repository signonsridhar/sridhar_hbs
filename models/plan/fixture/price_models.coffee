define(['can_fixture'], (can)->
    can.fixture('GET /bss/product?action=getpricemodels&partner_code=tmus', (req, resp)->
        return `{"response": {
  "service": "getpricemodels",
  "response_code": 100,
  "execution_time": 4525,
  "timestamp": "2013-10-09T20:50:49+0000",
  "response_data": {
    "packages": [
      {
        "product_id": "10933234",
        "product_type": "servicebundle",
        "name": "T-Mobile Line Bundle Monthly (Dev)",
        "description": "TMobile Line Bundle Monthly",
        "billing_period": 1,
        "charges": [
          {
            "charge_type": "recurring",
            "amount": 50.0,
            "currency": "usd",
            "from_number_units": 1.0,
            "to_number_units": 5.0
          },
          {
            "charge_type": "recurring",
            "amount": 45.0,
            "currency": "usd",
            "from_number_units": 6.0,
            "to_number_units": 10.0
          },
          {
            "charge_type": "recurring",
            "amount": 40.0,
            "currency": "usd",
            "from_number_units": 11.0,
            "to_number_units": 15.0
          },
          {
            "charge_type": "recurring",
            "amount": 35.0,
            "currency": "usd",
            "from_number_units": 16.0,
            "to_number_units": 20.0
          }
        ]
      },
      {
        "product_id": "10933235",
        "product_type": "servicebundle",
        "name": "T-Mobile Line Bundle Prepaid Quarterly (Dev)",
        "description": "TMobile Line Bundle Prepaid Quarterly",
        "billing_period": 3,
        "charges": [
          {
            "charge_type": "recurring",
            "amount": 45.0,
            "currency": "usd",
            "from_number_units": 1.0,
            "to_number_units": 5.0
          },
          {
            "charge_type": "recurring",
            "amount": 40.0,
            "currency": "usd",
            "from_number_units": 6.0,
            "to_number_units": 10.0
          },
          {
            "charge_type": "recurring",
            "amount": 35.0,
            "currency": "usd",
            "from_number_units": 11.0,
            "to_number_units": 15.0
          },
          {
            "charge_type": "recurring",
            "amount": 30.0,
            "currency": "usd",
            "from_number_units": 16.0,
            "to_number_units": 20.0
          }
        ]
      },
      {
        "product_id": "10933236",
        "product_type": "servicebundle",
        "name": "T-Mobile Line Bundle Prepaid Semi-Annually (Dev)",
        "description": "TMobile Line Bundle Prepaid Semi-Annually",
        "billing_period": 6,
        "charges": [
          {
            "charge_type": "recurring",
            "amount": 40.0,
            "currency": "usd",
            "from_number_units": 1.0,
            "to_number_units": 5.0
          },
          {
            "charge_type": "recurring",
            "amount": 35.0,
            "currency": "usd",
            "from_number_units": 6.0,
            "to_number_units": 10.0
          },
          {
            "charge_type": "recurring",
            "amount": 30.0,
            "currency": "usd",
            "from_number_units": 11.0,
            "to_number_units": 20.0
          }
        ]
      },
      {
        "product_id": "10933237",
        "product_type": "servicebundle",
        "name": "T-Mobile Line Bundle Prepaid Annually (Dev)",
        "description": "TMobile Line Bundle Prepaid Annually",
        "billing_period": 12,
        "charges": [
          {
            "charge_type": "recurring",
            "amount": 35.0,
            "currency": "usd",
            "from_number_units": 1.0,
            "to_number_units": 5.0
          },
          {
            "charge_type": "recurring",
            "amount": 30.0,
            "currency": "usd",
            "from_number_units": 6.0,
            "to_number_units": 10.0
          },
          {
            "charge_type": "recurring",
            "amount": 25.0,
            "currency": "usd",
            "from_number_units": 11.0,
            "to_number_units": 20.0
          }
        ]
      }
    ]
  },
  "version": "1.0"
}}`

    )
)
