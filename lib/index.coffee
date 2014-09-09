browserify = require 'browserify'
opaque = require './opaque'
coffeeify = require 'coffeeify'
coffeeify.sourceMap = false
exorcist = require 'exorcist'
uglify = require 'uglify-stream'
chokidar = require 'chokidar' if watch = !process.env.npm_config_once

b = new browserify
  debug: true
  extensions: ['.coffee']
  pack: opaque
.transform coffeeify
.add './src/main'

b.bundle (err, data)->
    if err
      console.log "Err: #{err}"
.pipe exorcist('./map')
.pipe uglify()
.pipe process.stdout
