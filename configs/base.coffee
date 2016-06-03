packages_builder = ()->
    result = []
    bases = ['bases/control', 'bases/model', 'bases/state', 'bases/page', 'bases/model/list']
    models = ['models/product']
    result = result.concat(bases).concat(models)
    result[idx] = {name: name, location:name} for name, idx in result
    result

require_conf =
    baseUrl: ''
    packages: packages_builder()
    map:
        '*':
            css: 'libs/require-css/main',
            env:'etc/require.env'

    paths:
        Faker: [
            'libs/Faker'
        ]
        bluebird:[
            'libs/bluebird'
        ]
        jquery: [
            'libs/jquery/jquery-2.0.3.min'
        ],
        jquery_ui:[
            'libs/jquery/jquery.ui-1.11.0'
        ],
        can: [
            'libs/can/2.0.3/can.jquery'
        ],
        can_fixture:[
            'libs/can/2.0.3/can.fixture'
        ],
        _:[
            'libs/underscore/bootstrap'
        ],
        ajaxfileuploader:[
            'libs/ajaxfileuploader'
        ],
        masked_input_plugin_jquery:[
            'libs/masked_input_plugin_jquery'
        ],
        jquery_numeric:[
            'libs/jquery_numeric'
        ]

    shim:
        bluebird:
            exports: 'Promise'
        jquery_ui:
            deps:['jquery', 'css!libs/jquery/ui/jquery.ui-1.11.0']
        can:
            exports:'can'
            deps:['jquery_ui']
        can_fixture:
            exports: 'can'
            deps: ['can']
        'libs/jsurl':
            exports:'JSURL'
        _:
            exports:'_'
    deps:['pages/routes']

#if it has __karma__ means that it's being run in a test environment
#but we still need the base_config, so set that as a global variable
#if not, proceed as usual
if window.__karma__?
    window.base_config = require_conf
else
    window.require = require_conf

