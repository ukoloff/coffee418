# We're running in a script
@standalone = true

# Use --once?
@watch = !process.env.npm_config_once

start = null
N = 0

# (re)Build callback
@start = ->
  console.log if N++ then 'Rebuilding...' else 'Building...'
  start = new Date

@success = ->
  console.log "Done (#{((new Date - start)/1000).toFixed(3).replace(/[.]0*$/, '')}s)"

@error = (err)->
  console.log "Error:", err.annotated or err.message

@change = (e, f)->
  console.log new Date().toLocaleTimeString(), "Fired #{e} on #{f}..."
