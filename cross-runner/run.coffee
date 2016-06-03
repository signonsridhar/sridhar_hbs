program = require 'commander'
os = require 'os'
_ = require 'underscore'
_.str = require 'underscore.string'
path = require 'path'


csv = (param)->
    param.split(',').map(_.trim)


program
    .version('0.0.1')
    .option('-b, --browsers <n>', 'csv of browsers', csv)
    .parse(process.argv)

cwd = path.resolve('..')
platform = os.platform()

runner = require "./#{os.platform()}.js"
runner.run({
    dir: cwd
    server: 9887
})