
class Pomodoro {
    private static DEFAULT_SECONDS_LEFT = 25 * 60
    
    private secondsLeft = DEFAULT_SECONDS_LEFT
    
    public int secondsLeft() {
        secondsLeft
    }
    
    public PomodoroStates getState() {
        return PomodoroStates.STOPPED
    }
}
