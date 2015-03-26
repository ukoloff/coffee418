fs = require 'fs'
browserify = require 'browserify'
coffeeify = require 'coffeeify'
coffeeify.sourceMap = false
intreq = require 'intreq'
exorcist = require 'exorcist'
sculpt = require 'sculpt'
rename =  require './rename'
ugly = require './ugly'
mkpaths = require './mkpaths'
chokidar = require 'chokidar'

module.exports = build = (options = {})->
  sources = {}
  files = []

  listen = (file)->
    chokidar.watch file,
      persistent: true
      ignoreInitial: true
    .on 'all', (e, f)->
      files.forEach (z)-> z.close()
      files = []
      process.nextTick -> build options
      options.change? e, f

  paths = do mkpaths
  options.start?()

  b = new browserify
    debug: true
    extensions: ['.coffee']
  .transform coffeeify
  .add '.'
  .on 'file', (file, id)->
    sources[id] = file
    files.push listen file if options.watch

  b.pipeline.get 'label'
    .push intreq(), rename sources

  b.bundle()
  .on('error', (err)->options.error? err)
  .pipe exorcist(paths.debug+'.map')
  .pipe sculpt.fork(fs.createWriteStream paths.debug)
  .pipe ugly()
  .pipe fs.createWriteStream paths.out
  .on 'finish', -> options.success?()

  return

build.defaults = ->
  require './standalone'
