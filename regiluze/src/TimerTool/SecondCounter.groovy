package TimerTool

import java.util.concurrent.atomic.AtomicInteger

/**
 * Created by IntelliJ IDEA.
 * User: ruben
 * Date: 26/12/11
 * Time: 2:03
 * To change this template use File | Settings | File Templates.
 */
class SecondCounter implements TimerTool{

    int counter
    int goal
    def counting = true

    def clock = {
        while (counting){
            sleep 1000
            increase()
            checkGoal()
        }
    }

    def start() {
        counter = 0
        Thread.startDaemon(clock)
    }

    def checkGoal() {
        if (counter == goal) {
            stopCount()
        }
    }

    synchronized def stopCount() {
        counting = false
    }

    synchronized def increase(){
        counter++
    }

    def timeLeft() {
       goal - counter
    }

    def restart() {
        counter = 0
    }

     def set(int duration) {
        goal = duration
    }

    def stop() {
        stopCount()
    }


}




