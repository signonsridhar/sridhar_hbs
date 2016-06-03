define([ 'can_fixture', 'Faker'], (can, Faker, Tenant)->
    data = {
        tenants:[]
        users:[]
    }
    for i in [0..10]
        data.tenants.push {
            tenant_name: Faker.Company.companyName()
        }

    can.fixture('GET /tenants', (req, res)->
        return data.tenants
    )

)