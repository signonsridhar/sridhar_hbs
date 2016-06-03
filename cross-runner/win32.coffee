process = require('child_process')
_ = require 'underscore'
chokidar = require 'chokidar'
colors = require 'colors'
Faye = require 'faye'


module.exports = {
    watcher:null, #watcher instance
    #if it's in running mode but there's something changing, then keep that in mind, and run it after the test is done
    in_debt:false,

    run: (options)->
        this.options = options
        this.test() #initial test
        this.watch(options.dir)
        this.setup_server(options.server)

    setup_server:(port)->
        this.server = new Faye.NodeAdapter({mount:'/'})
        this.server.listen(8000)

    watch: (dir)->
        this.watcher = chokidar.watch dir, {
            persistent: true,
            ignoreInitial:true
        }
        this.watcher.on 'all', (evt_type, path, file)=>
            path = path.split('.')
            ext = path[path.length - 1]
            return unless ext == 'js'
            this.test()

    notify:(msg)->
        this.server.getClient().publish('/result',{
            msg: msg
        })
    test: ()->
        if this.running
            this.in_debt = true
            return

        this.running = true
        last_data = ''
        child = process.spawn 'cmd', ['/c', 'bin_env.bat']

        child.stdout.on('data', (data)->
            data = data.toString()
            console.log data
            #show to screen
            last_data = data
        )

        child.stderr.on('data', (data)->
            console.log('stderr: ' + data);
        )

        child.on('close', (code)=>
            color = last_data.indexOf(' FAILED') < 0 ? 'red' : 'green'
            #total_errors = parseInt(last_data.split(' ')[1])
            this.running = false
            if this.in_debt
                this.in_debt = false
                this.test()
            else
                this.notify(last_data[color])
        )
}