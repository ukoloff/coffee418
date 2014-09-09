browserify = require 'browserify'
opaque = require './opaque'
c2js = require './coffee2js'
chokidar = require 'chokidar' if watch = !process.env.npm_config_once

console.log "Hi! Watch=#{watch}"
