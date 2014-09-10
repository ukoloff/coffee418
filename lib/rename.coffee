through = require 'through'

module.exports = (pairs)->
  through (obj)->
    obj.file = pairs[obj.file] if pairs[obj.file]
    @queue obj
