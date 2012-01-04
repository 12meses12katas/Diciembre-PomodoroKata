class Pomodoro
  attr_accessor :duration, :remaining_time, :interruptions, :started, :stopped, :timer
  def initialize(time = 25)
    self.duration = self.remaining_time = time * 60 # Time in minutes
    self.stopped = true
    self.interruptions = 0
  end

  def stopped?
    stopped
  end

  def start
    self.stopped = false
    self.started = true
    work!
  end

  def work!
    self.timer = Thread.new {
      loop do
        self.remaining_time -= 5
        if self.remaining_time <= 0
          puts "End of pomodoro. Good bye!"
          exit 
        end
        sleep(2) 
      end
    }
  end

  def stop
    if self.started && !self.stopped
      self.interruptions += 1
      self.stopped = true
      Thread.kill(self.timer) if self.timer
    else
      false
    end
  end

  def resume
    self.stopped = false
    work!
  end

  def reset
    self.remaining_time = duration
    self.interruptions = 0
    Thread.kill(self.timer) if self.timer
  end

  def finished? 
    started && remaining_time <= 0
  end


end