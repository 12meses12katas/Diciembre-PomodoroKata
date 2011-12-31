package TimerTool

/**
 * Created by IntelliJ IDEA.
 * User: ruben
 * Date: 21/12/11
 * Time: 16:18
 * To change this template use File | Settings | File Templates.
 */
interface TimerTool {

    def start()

    def timeLeft()

    def restart()

    def set(int duration)

    def stop()

}
