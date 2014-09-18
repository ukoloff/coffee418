uglify = require 'uglify-js'
through = require 'through'

module.exports = ->
  data = ''
  write = (buf)-> data+=buf
  end = ->
    @queue minify data
    @queue null
  through write, end

minify = (s)->
  try
    uglify.minify(s, fromString: true).code
  catch e
    "// Minify (syntax?) error"
