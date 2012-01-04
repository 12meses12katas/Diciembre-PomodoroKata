class Pomodoro
  constructor: (@limitTime = 25) ->
    @step = 1000
    @endCbk = -> "Pomodoro is over"
    do @init

  init: ->
    @beats = 0
    @currentTime = @limitTime
    @stops = 0
    @running = false

  stop: ->
    throw "Pomodoro must be started" if @running is false
    @running = false
    clearTimeout @timer
    @stops++

  getStops: ->
    @stops

  getBeats: ->
    @beats

  start: ->
    @running = true
    do @beat

  restart: ->
    do @stop if @running is true
    do @init
    do @start

  setTimeout: (cbk, step) ->
    setTimeout(cbk, step)
    #do cbk
    return

  beat: ->
    @beats++
    @currentTime--
    #console.log "beat", @currentTime
    if @currentTime > 0
      @timer = @setTimeout((=> @beat()), @step)
    else
      do @end

  registerCallback: (@endCbk) ->

  end: ->
    do @endCbk

exports.Pomodoro = Pomodoro





