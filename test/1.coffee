describe 'Sync', ->
  it 'evaluates immediately', ->
    (1+2).should.equal 3

describe 'Async', ->
  it 'evaluates in callback', (done)->
    delay 1000, ->
      do done
      # done Error 'Oops'

  it 'supports promises', ->
    oks = []
    fails = []
    delay 1000, ->
      if !true
        oks.forEach (fn)-> fn true
      else
        fails.forEach (fn)-> fn Error 'Something failed...'

    then: (ok, fail)->
      oks.push ok if 'function'==typeof ok
      fails.push fail if 'function'==typeof fail

delay = (ms, fn)-> setTimeout fn, ms
