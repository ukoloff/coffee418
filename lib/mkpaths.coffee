fs = require 'fs'
path = require 'path'
mkdirp = require 'mkdirp'

module.exports = (ext = '.js')->

  try
    name = JSON.parse fs.readFileSync 'package.json'
    .name
  catch

  name ||= path.basename path.resolve '.'
  name ||= 'bundle'

  r =
    out:   path.resolve name+ext
    debug: path.resolve 'tmp', name+ext
  mkdirp.sync path.dirname v for k, v of r
  r
