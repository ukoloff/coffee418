browserify = require 'browserify'
chokidar = require 'chokidar' if watch = !process.env.npm_config_once

console.log "Hi! Watch=#{watch}"
