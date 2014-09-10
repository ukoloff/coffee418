fs = require 'fs'
through = require 'through'

module.exports = (name)->
  out = fs.createWriteStream name
  through (data)->
    @queue data
    out.write JSON.stringify data, null, ' '
    out.write "\n"
