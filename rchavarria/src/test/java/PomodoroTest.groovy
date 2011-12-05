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

}
