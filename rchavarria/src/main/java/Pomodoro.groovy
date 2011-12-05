
class Pomodoro {
    private static DEFAULT_SECONDS_LEFT = 25 * 60
    
    private secondsLeft = DEFAULT_SECONDS_LEFT
    private state = PomodoroStates.STOPPED
    
    public int secondsLeft() {
        secondsLeft
    }
    
    public PomodoroStates getState() {
        state
    }
    
    public void start() {
        state = PomodoroStates.ACTIVE
    }
}
