import org.junit.*
import TimerTool.TimerTool
import static org.mockito.Mockito.*


/**
 * Created by IntelliJ IDEA.
 * User: ruben
 * Date: 21/12/11
 * Time: 12:43
 * To change this template use File | Settings | File Templates.
 */
class PomodoroKataTest {

     Pomodoro pomodoro
     TimerTool timer

    @Before
    public void intitializePomodoro(){
        timer = mock(TimerTool.class)
        pomodoro = new Pomodoro(timer)
    }

    @Test
    public void when_create_pomodoro_then_his_state_is_stopped(){
         when(timer.timeLeft()).thenReturn(1500)
        assert pomodoro.isStarted() == false

    }

    @Test
    public void when_create_pomodoro_then_time_left_is_25_mins() {
        when(timer.timeLeft()).thenReturn(1500)
        assert pomodoro.timeLeft() == 1500
    }

    @Test
    public void when_start_then_pomodoro_is_started(){

        pomodoro.start()

        assert pomodoro.isStarted() == true
        assert pomodoro.isDone() == false

    }

    @Test
    public void when_start_then_timeLeft_decreases(){
        when(timer.timeLeft()).thenReturn(1499)
        pomodoro.start()
        assert pomodoro.timeLeft() == 1499
    }

    @Test
    public void when_timeleft_is_zero_then_pomodoro_is_done(){

        when(timer.timeLeft()).thenReturn(0)
        pomodoro.start()
        assert pomodoro.isDone() == true
        assert pomodoro.isStarted() == false

    }

     @Test
    public void when_pomodoro_start_num_of_interruptions_is_zero(){
        when(timer.timeLeft()).thenReturn(1400)

        assert pomodoro.interruptionNumber() == 0

    }

     @Test(expected=Exception)
    public void when_interrup_a_not_started_pomodoro_should_throw_exception(){
        when(timer.timeLeft()).thenReturn(1500)
        pomodoro.interruption()

    }

     @Test
    public void when_pomodoro_is_started_counts_interruptions(){
        when(timer.timeLeft()).thenReturn(1400)
         pomodoro.interruption()
        assert pomodoro.interruptionNumber() == 1
        pomodoro.interruption()
        assert pomodoro.interruptionNumber() == 2

    }

    @Test
    public void when_pomodoro_is_restarted_then_timer_is_restarted(){
        pomodoro.restart()
        verify(timer,times(1)).restart()
    }

    @Test
    public void when_pomodoro_is_restarted_then_num_interruptions_is_zero(){
        when(timer.timeLeft()).thenReturn(1400)
        pomodoro.interruption()
        pomodoro.restart()
        assert pomodoro.interruptionNumber() == 0
    }

    @Test
    public void when_pomodoro_is_set_to_1200_min_then_timer_is_set_to_1200(){

        pomodoro.duration = 1200
        verify(timer,times(1)).set(1200)
    }

     @Test
    public void when_pomodoro_is_created_the_timer_is_set_to_1500(){

        verify(timer,times(1)).set(1500)
    }

    @Test
    public void when_pomodoro_is_stoped_then_timer_is_stoped(){
        pomodoro.stop()
        verify(timer,times(1)).stop()
    }
}
