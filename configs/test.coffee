include = (filename, onload) ->
    head = document.getElementsByTagName("head")[0]
    script = document.createElement("script")
    script.src = filename
    script.type = "text/javascript"
    script.onload = script.onreadystatechange = ->
        if script.readyState
            if script.readyState is "complete" or script.readyState is "loaded"
                script.onreadystatechange = null
                onload() if onload
        else
            onload() if onload

    head.appendChild script

include('/base/configs/base.js',  ()->
    #console.log 'FILES', window.__karma__.files
    tests = []
    base_config = window.base_config
    tests.push(file) for file of window.__karma__.files when file.indexOf('spec/') >= 0 or file.indexOf('.html') >= 0
    #console.log 'TESTS', tests

    base_config.paths['jasmine.bootstrap'] = ['tests/jasmine.bootstrap']
    base_config.shim['jasmine.bootstrap'] = {deps:['jquery']}

    #everything starts with can, so piggy back on that so we dont need to include manually every time
    base_config.shim['can'].deps.push('jasmine.bootstrap')
    base_config.baseUrl ='/base'
    tests = tests.concat(base_config.deps) if base_config.deps? and base_config.length > 0
    base_config.deps = tests
    old_callback = base_config.callback
    base_config.callback = ->
        old_callback() if old_callback?
        window.__karma__.start()

    require.config(base_config)
)