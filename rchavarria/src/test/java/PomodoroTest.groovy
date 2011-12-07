import static org.junit.Assert.*

import org.junit.Before
import org.junit.Test

import com.sun.xml.internal.bind.v2.model.impl.ClassInfoImpl.SecondaryAnnotation;

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
    
    @Test
    public void testNotStartedPomodoroNeverEnds() {
        def oneSecondPomodoro = new Pomodoro(secondsLeft : 1)
        
        assertEquals(PomodoroStates.STOPPED, oneSecondPomodoro.getState())
        
        Thread.sleep(2 * 1000)
        assertEquals(PomodoroStates.STOPPED, oneSecondPomodoro.getState())
    }
    
    @Test
    public void testPomodoroEndsWhenItsTimeIsGone() {
        def oneSecondPomodoro = new Pomodoro(secondsLeft : 1)
        
        assertEquals(PomodoroStates.STOPPED, oneSecondPomodoro.getState())
        
        oneSecondPomodoro.start()
        assertEquals(PomodoroStates.ACTIVE, oneSecondPomodoro.getState())

        Thread.sleep(2 * 1000)
        assertEquals(PomodoroStates.FINISHED, oneSecondPomodoro.getState())
    }
    
    @Test
    public void testPomodoroIsInitializedWithoutInterruptions() {
        assertEquals(0, pomodoro.interruptions())
    }
        
    @Test(expected=Exception.class)
    public void testPomodoroDoesNotAllowInterruptionsIfNotStarted() {
        pomodoro.interrupt()
        
        fail("pomodoro should not allow interruptions if it is not started")
    }
    
    @Test
    public void testPomodoroAllowInterruptionsIfStarted() {
        pomodoro.start()
        pomodoro.interrupt()
        assertEquals(1, pomodoro.interruptions())
    }
    
    @Test
    public void testPomodoroCountsInterruptions() {
        pomodoro.start()
        def count = 5
        (1..count).each { pomodoro.interrupt() }
        assertEquals(count, pomodoro.interruptions())
    }
    
    @Test
    public void testStartedPomodoroCanBeReset() {
        def fiveSecondsPomodoro = new Pomodoro(secondsLeft : 5)
        
        fiveSecondsPomodoro.start()
        assertEquals(PomodoroStates.ACTIVE, fiveSecondsPomodoro.getState())
        Thread.sleep(3 * 1000)
        assertEquals(PomodoroStates.ACTIVE, fiveSecondsPomodoro.getState())

        // reset before finish        
        fiveSecondsPomodoro.reset()
        Thread.sleep(3 * 1000)
        //still active
        assertEquals(PomodoroStates.ACTIVE, fiveSecondsPomodoro.getState())
        Thread.sleep(3 * 1000)
        
        assertEquals(PomodoroStates.FINISHED, fiveSecondsPomodoro.getState())
    }
}
