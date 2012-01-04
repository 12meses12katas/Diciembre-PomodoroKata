import java.util.concurrent.Executors;

class Pomodoro {
    
    private static ONE_SECOND = 1000
    private static SECONDS_LEFT = 25 * 60
    
    private secondsLeft = SECONDS_LEFT
    private state = PomodoroStates.STOPPED
    private Timer timer = new Timer()
    private interruptions = 0
    private secondsCountDown
    
    public start() {
        initFields()
        initTimer()
    }
    
    private initFields() {
        secondsCountDown = secondsLeft
        state = PomodoroStates.ACTIVE
        interruptions = 0
    }
    
    private initTimer() {
        cancelPreviousTimer()
        timer = new Timer()
        timer.schedule(new SecondsCountDownTask(), ONE_SECOND, ONE_SECOND)
    }
    
    private cancelPreviousTimer(){
        if(timer != null){
            timer.cancel()
        }
    }
    
    public interrupt() {
        if(state == PomodoroStates.STOPPED)
            throw new PomodoroNotStartedException()

        interruptions ++
    }

    private class SecondsCountDownTask extends TimerTask {
        @Override
        public void run() {
            secondsCountDown --
            
            if(secondsCountDown == 0)
                state = PomodoroStates.FINISHED
        }
    }
}

