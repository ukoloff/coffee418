describe 'Sync', ->
  it 'evaluates immediately', ->
    (1+2).should.equal 3

describe 'Async', ->
  it 'evaluates in callback', (done)->
    setTimeout ->
      do done
      # done Error 'Oops'
    , 1000
