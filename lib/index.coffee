fs = require 'fs'
browserify = require 'browserify'
coffeeify = require 'coffeeify'
coffeeify.sourceMap = false
intreq = require 'intreq'
exorcist = require 'exorcist'
sculpt = require 'sculpt'
ugly = require './ugly'
chokidar = require 'chokidar' if watch = !process.env.npm_config_once

b = new browserify
  debug: true
  extensions: ['.coffee']
.transform coffeeify
.add './src/main'

b.pipeline.get('label').push intreq()

b.bundle()
.on('error', (err)->console.log "Error:", err)
.pipe exorcist('./1.js.map')
.pipe sculpt.fork(fs.createWriteStream '1.js')
.pipe ugly()
.pipe fs.createWriteStream '2.js'
