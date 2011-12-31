import TimerTool.TimerTool
/**
 * Created by IntelliJ IDEA.
 * User: ruben
 * Date: 21/12/11
 * Time: 15:55
 * To change this template use File | Settings | File Templates.
 */
class Pomodoro {

    final int DEFAULT_DURATION  = 1500

    TimerTool timer
    int interrupt
    int duration = DEFAULT_DURATION

    public Pomodoro(TimerTool timer){
        timer.set(duration)
        this.timer = timer
    }

    def isStarted() {
       if ((timeLeft() == 0)||(timeLeft() == duration)){
            return  false
       }
        true
    }

    def timeLeft() {
        timer.timeLeft()
    }

    def start() {
        timer.start()
    }

    def isDone() {
        if (timeLeft() == 0){
            return  true
        }
        return false
    }

    def interruptionNumber() {
        interrupt
    }

    def interruption() {
        if (!isStarted()){
            throw new Exception()
        }
        interrupt++
    }

    def restart() {
        interrupt = 0
        timer.restart()
    }

    public void setDuration(int time){
        duration = time
        timer.set(duration)
    }

    def stop() {
        timer.stop()
    }
}
