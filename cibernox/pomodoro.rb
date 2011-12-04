class Pomodoro
  attr_accessor :duration, :remaining_time, :interruptions, :started, :stopped
  def initialize(time = 25)
    self.duration = time
    self.stopped = true
    self.interruptions = 0
  end

  def stopped?
    stopped
  end

  def start
    self.stopped = false
    self.started = true
  end

  def stop
    if self.started && !self.stopped # si ha empezado y no está parado
      self.interruptions += 1
      self.stopped = true
    else
      false
    end
  end

  def resume
    self.stopped = false
  end

  def reset
    self.remaining_time = duration
    self.interruptions = 0
  end

  def finished? 
    started && remaining_time <= 0
  end


end