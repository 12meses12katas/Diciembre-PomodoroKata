import java.util.concurrent.Executors;

class Pomodoro {
    
    private static SECONDS_LEFT = 25 * 60
    
    private secondsLeft = SECONDS_LEFT
    private state = PomodoroStates.STOPPED
    private interruptions = 0
    
    public secondsLeft() {
        secondsLeft
    }
    
    public getState() {
        state
    }
    
    public start() {
        state = PomodoroStates.ACTIVE
        interruptions = 0
        
        new Timer().schedule(new FinishPomodoroTask(), secondsLeft * 1000)
    }
    
    public interruptions() {
        interruptions
    }
    
    public interrupt() {
        if(state == PomodoroStates.STOPPED)
            throw new PomodoroNotStartedException()

        interruptions ++
    }

    private class FinishPomodoroTask extends TimerTask {
        @Override
        public void run() {
            state = PomodoroStates.FINISHED
        }
    }
}

