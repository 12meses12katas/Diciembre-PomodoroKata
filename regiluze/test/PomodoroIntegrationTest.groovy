import org.junit.*
import TimerTool.SecondCounter
/**
 * Created by IntelliJ IDEA.
 * User: ruben
 * Date: 27/12/11
 * Time: 17:05
 * To change this template use File | Settings | File Templates.
 */
class PomodoroIntegrationTest {

    Pomodoro pomodoro
    def timer

    @Before
    def void initiatePomodoro(){
        timer = new SecondCounter()
        pomodoro = new Pomodoro(timer)

    }

    @After
    def void stopPomodoro(){
        pomodoro.stop()
    }


    @Test
    def void when_pomodoro_set_to_10_second_and_start_and_sleep_5_second_then_time_left_is_equal_to_6(){

        pomodoro.setDuration(10)
        pomodoro.start()
        sleep 5000
        assert 6 == pomodoro.timeLeft()

    }

    @Test
    def void when_pomodoro_set_to_5_seconds_after_5_senconds_then_is_done(){

        pomodoro.setDuration(5)
        pomodoro.start()
        sleep 5100
        assert pomodoro.isDone()
    }

    @Test
    def void start_pomodoro_add_three_interruptions_then_stop_should_get_3_interruptions(){

        pomodoro.setDuration(5)
        pomodoro.start()
        sleep 1000
        pomodoro.interruption()
        sleep 1000
        pomodoro.interruption()
        sleep 1000
        pomodoro.interruption()
        pomodoro.stop()
        assert pomodoro.interruptionNumber() == 3
    }

      @Test
    def void when_restart_pomodoro_then_counter_start_again(){

        pomodoro.setDuration(5)
        pomodoro.start()
        sleep 1000
        pomodoro.restart()
        sleep 1000
        assert pomodoro.timeLeft() == 4
    }
}
