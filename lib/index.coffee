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
chokidar = require 'chokidar' if watch = !process.env.npm_config_once

do build = ->
  sources = {}
  files = []

  listen = (file)->
    chokidar.watch file,
      persistent: true
      ignoreInitial: true
    .on 'all', (e, f)->
      files.forEach (z)-> z.close()
      files = []
      process.nextTick build
      console.log new Date().toLocaleTimeString(), "Fired #{e} on #{f}..."

  console.log 'Rebuilding...'
  b = new browserify
    debug: true
    extensions: ['.coffee']
  .transform coffeeify
  .add '.'
  .on 'file', (file, id)->
    sources[id] = file
    files.push listen file if watch

  b.pipeline.get 'label'
    .push intreq(), rename sources

  paths = do mkpaths

  b.bundle()
  .on('error', (err)->console.log "Error:", err.annotated or err.message)
  .pipe exorcist(paths.debug+'.map')
  .pipe sculpt.fork(fs.createWriteStream paths.debug)
  .pipe ugly()
  .pipe fs.createWriteStream paths.out
