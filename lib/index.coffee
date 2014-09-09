browserify = require 'browserify'
opaque = require './opaque'
coffeeify = require 'coffeeify'
coffeeify.sourceMap = false
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
.pipe process.stdout
