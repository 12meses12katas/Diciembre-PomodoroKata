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
    public void testCanCreatePomodoroWithAnyDuration() {
        assertEquals(10, new Pomodoro(secondsLeft : 10).secondsLeft())
        assertEquals(123456, new Pomodoro(secondsLeft : 123456).secondsLeft())
    }
    
    @Test
    public void testJustCreatedPomodoroIsStopped() {
        assertEquals(PomodoroStates.STOPPED, pomodoro.getState())
    }
    
    @Test
    public void testStartingPomodoroStartsCountDown() {
        assertEquals(PomodoroStates.STOPPED, pomodoro.getState())
        pomodoro.start()
        assertEquals(PomodoroStates.ACTIVE, pomodoro.getState())
    }
    
    @Test
    public void testPomodoroDoesNotFinishIfItHasNotBeenStarted() {
        def oneSecondPomodoro = new Pomodoro(secondsLeft : 1)
        Thread.sleep(2 * 1000)
        assertEquals(PomodoroStates.STOPPED, oneSecondPomodoro.getState())
    }
    
    @Test
    public void testPomodoroFinishesWhenItsTimeIsGone() {
        def oneSecondPomodoro = new Pomodoro(secondsLeft : 1)
        oneSecondPomodoro.start()
        assertEquals(PomodoroStates.ACTIVE, oneSecondPomodoro.getState())
        Thread.sleep(2 * 1000)
        assertEquals(PomodoroStates.FINISHED, oneSecondPomodoro.getState())
    }
    
    @Test
    public void testPomodoroDoesNotFinishUntilItsTimeIsGone() {
        def twoSecondsPomodoro = new Pomodoro(secondsLeft : 2)
        twoSecondsPomodoro.start()
        assertEquals(PomodoroStates.ACTIVE, twoSecondsPomodoro.getState())
        Thread.sleep(1 * 1000)
        assertEquals(PomodoroStates.ACTIVE, twoSecondsPomodoro.getState())
        Thread.sleep(2 * 1000)
        assertEquals(PomodoroStates.FINISHED, twoSecondsPomodoro.getState())
    }
    
    @Test
    public void testPomodoroIsInitializedWithoutInterruptions() {
        assertEquals(0, pomodoro.interruptions())
    }
    
    @Test(expected = PomodoroNotStartedException.class)
    public void testNotStartedPomodoroDoesNotAcceptInterruptions() {
        pomodoro.interrupt()
        
        fail("NotStartedPomodoroDoesNotAcceptInterruptions")
    }
    
    @Test
    public void testPomodoroCountsInterruptions() {
        pomodoro.start()
        
        assertEquals(0, pomodoro.interruptions())
        pomodoro.interrupt()
        assertEquals(1, pomodoro.interruptions())

        pomodoro.interrupt()
        assertEquals(2, pomodoro.interruptions())
    }
    
    @Test
    public void testPomodoroReinitsIfItIsStartedAgain() {
        def oneSecondPomodoro = new Pomodoro(secondsLeft : 1)
        oneSecondPomodoro.start()
        assertEquals(PomodoroStates.ACTIVE, oneSecondPomodoro.getState())
        Thread.sleep(2 * 1000)
        assertEquals(PomodoroStates.FINISHED, oneSecondPomodoro.getState())

        oneSecondPomodoro.start()
        assertEquals(PomodoroStates.ACTIVE, oneSecondPomodoro.getState())
        Thread.sleep(2 * 1000)
        assertEquals(PomodoroStates.FINISHED, oneSecondPomodoro.getState())
    }
    
    @Test
    public void testPomodoroReinitsWithoutInterruptions() {
        def oneSecondPomodoro = new Pomodoro(secondsLeft : 1)
        oneSecondPomodoro.start()
        oneSecondPomodoro.interrupt()
        oneSecondPomodoro.interrupt()
        Thread.sleep(2 * 1000)

        oneSecondPomodoro.start()
        assertEquals(0, oneSecondPomodoro.interruptions())
    }
}
