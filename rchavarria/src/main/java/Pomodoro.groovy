import java.util.concurrent.Executors;


class Pomodoro {
    private static DEFAULT_SECONDS_LEFT = 25 * 60
    
    private secondsLeft = DEFAULT_SECONDS_LEFT
    private state = PomodoroStates.STOPPED
    private interruptions = 0
    
    public int secondsLeft() {
        secondsLeft
    }
    
    public synchronized PomodoroStates getState() {
        state
    }
    
    public void start() {
        state = PomodoroStates.ACTIVE
        
        new Thread().start {
            Thread.sleep(secondsLeft * 1000)
            setState(PomodoroStates.FINISHED)
        }
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
}
