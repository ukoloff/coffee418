browserify = require 'browserify'
opaque = require './opaque'
c2js = require './coffee2js'
chokidar = require 'chokidar' if watch = !process.env.npm_config_once

b = new browserify
  extensions: ['.coffee']
  pack: opaque
.transform c2js
.add './src/main'

b.bundle (err, data)->
    if err
      console.log "Err: #{data}"
    else
      console.log "Success: #{data}"
