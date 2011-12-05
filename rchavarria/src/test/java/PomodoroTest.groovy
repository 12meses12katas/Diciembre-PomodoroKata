import static org.junit.Assert.*

import org.junit.Before
import org.junit.Test

class PomodoroTest {

    def pomodoro
    
    @Before
    public void setUp() throws Exception {
        pomodoro = new Pomodoro()
    }
    
    @Test
    public void testDefaultTimeLeft() {
        assertEquals(25 * 60, pomodoro.secondsLeft())
    }
    
    @Test
    public void testDefineDuration() {
        def newDuration = 150
        assertEquals(newDuration, new Pomodoro(secondsLeft : newDuration).secondsLeft())
        
        def otherDuration = 123456
        assertEquals(otherDuration, new Pomodoro(secondsLeft : otherDuration).secondsLeft())
    }
    
    @Test
    public void testJustCreatedPomodoroIsStopped() {
        assertEquals(PomodoroStates.STOPPED, pomodoro.getState())
    }
    
    @Test
    public void testWhenStartingPomodoroIsActive() {
        pomodoro.start()
        assertEquals(PomodoroStates.ACTIVE, pomodoro.getState())
    }

}
