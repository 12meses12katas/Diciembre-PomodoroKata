Pomodoro = require('../pomodoro').Pomodoro

describe 'jasmine-node', ->
  
  it 'a pomodoro must be started if we want to stop it', ->
    pom = new Pomodoro
    pom.setTimeout = (cbk, step) -> do cbk
    try
      do pom.stop
    catch error
      expect(error.message).toEqual "Pomodoro must be started"

  it '25 minutes by default', ->
    pom = new Pomodoro 25
    pom.setTimeout = (cbk, step) -> do cbk
    pom.registerCallback(->
      expect(@beats).toEqual 25
    )
    do pom.start

  it 'We can start pomodoros with another value than 25', ->
    pom = new Pomodoro 10
    pom.setTimeout = (cbk, step) -> do cbk
    pom.registerCallback(->
      expect(@beats).toEqual 10
    )
    do pom.start

  it 'stops', ->
    pom = new Pomodoro 5
    pom.registerCallback(->
      expect(@beats).toEqual 5
    )
    expect(do pom.getStops).toEqual 0
    do pom.start
    waits 500
    do pom.stop
    expect(do pom.getStops).toEqual 1
    do pom.start
    waits 500
    do pom.stop
    expect(do pom.getStops).toEqual 2
