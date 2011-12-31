import org.junit.*
import TimerTool.TimerTool
import TimerTool.SecondCounter
/**
 * Created by IntelliJ IDEA.
 * User: ruben
 * Date: 26/12/11
 * Time: 1:58
 * To change this template use File | Settings | File Templates.
 */
class TimerToolTest {

    TimerTool timer

    @Before
    public void createTimer(){

        timer = new SecondCounter()

    }

    @Test
    public void when_timer_set_to_1200_then_time_left_is_1200(){

        timer.set(1200)
        timer.stop()
        assert timer.timeLeft() == 1200

    }

        @Test
    public void when_timer_start_time_left_less_than_1200(){

        timer.set(5)
        timer.start()
        sleep 2000
        assert timer.timeLeft() < 5
        timer.stop()

    }

    @Test
    public void when_timer_is_restarted_time_left_is_set_value(){

     timer.set(12)
     timer.start()
     sleep 5000
     timer.restart()
     assert timer.timeLeft() == 12

    }

     @Test
    public void when_start_sto_and_start_again_then_counter_should_be_accesed_by_only_process(){

     timer.set(12)
     timer.start()
     sleep 5000
     timer.stop()
     timer.start()
     sleep(2000)
     assert timer.timeLeft() > 9

    }



}
