define({
    #checks whether the passed environment is the same as the global env variable
    #ex: !env:dev /modules/blalala this will only get included if there's window.env == dev
    load:(name, parentRequire, onload, config)->
        env = name.split(':')
        path = env[1]
        env = env[0]
        if window.env? and window.env == env
            #matches the environment then include it
            require([require.toUrl(path)], (value)->
                onload(true)
            )
        else

            onload(false)
})