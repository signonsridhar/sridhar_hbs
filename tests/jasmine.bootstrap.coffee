#do not add bases/* or anything that depends on can.js
define(['jquery','_', 'tests/jquery.jasmine', 'tests/matchers'], ($, _)->

    jasmine.getFixtures().fixturesPath = ''


    #automatically get the sandbox, if it doesnt exist, create one
    window.get_sandbox = ()->
        $sandbox_elem = $('#sandbox')
        $sandbox_elem = setFixtures(sandbox()) if $sandbox_elem.length == 0
        $sandbox_elem

    #this piggy backs on karma runner html2js preprocessor, in configs/test.coffee we include spec AND .html
    #as part of the deps, it will convert to path.html.js that is contained in window.__html__[path] = <template>
    window.load_fixture = (path, id)->
        path = path + '.html'
        id?= _.uniqueId('fixture_')
        $fixture = $(window.__html__[path]).attr('id', id)
        jasmine.getFixtures().appendSet($fixture)
        $fixture

    window.setup_routes = ->
        defaults = {
            main_page: 'home',
            sub_page: 'index',
            state: ''
        }
        can.route(':main_page', defaults)
        can.route(':main_page/:sub_page', defaults)
        can.route(':main_page/:sub_page/', defaults)

)