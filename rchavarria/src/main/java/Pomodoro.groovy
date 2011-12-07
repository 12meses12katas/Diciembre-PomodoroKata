import java.util.concurrent.Executors;

class Pomodoro {
    private static DEFAULT_SECONDS_LEFT = 25 * 60
    
    private secondsLeft = DEFAULT_SECONDS_LEFT
    private state = PomodoroStates.STOPPED
    private interruptions = 0
    private timer
    
    public int secondsLeft() {
        secondsLeft
    }
    
    public synchronized PomodoroStates getState() {
        state
    }
    
    public void start() {
        setState(PomodoroStates.ACTIVE)
        scheduleTimer()
    }
    
    private scheduleTimer() {
        timer = new Timer()
        def timerTask = new TimerTask() {
            @Override
            public void run() {
                setState(PomodoroStates.FINISHED)
            }
        }
        timer.schedule(timerTask, secondsLeft * 1000)
    }
    
    private synchronized setState(PomodoroStates newState) {
        state = newState
    }
    
    public int interruptions() {
        interruptions
    }
    
    public interrupt() {
        if(! (PomodoroStates.ACTIVE == getState()))
            throw new Exception("Pomodoro not started")
        
        interruptions++
    }
    
    public reset() {
        timer.cancel()
        start()
    }
}
