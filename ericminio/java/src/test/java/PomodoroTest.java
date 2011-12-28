
import static org.hamcrest.CoreMatchers.equalTo;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.assertTrue;

import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;


public class PomodoroTest {

	Pomodoro pomodoro;
	
	@Before
	public void setUp() throws Exception {
		pomodoro = new Pomodoro();
	}
	
	@Test public void
	remainingIsComputedWithJumpNumber() {
		pomodoro.setJumpNumber( 3 );
		assertThat( pomodoro.remainingJumps(), equalTo( 3 ) );
	}
	
	@Ignore
	@Test public void
	eachJumpDecreasesTheRemainingByOne() {
		pomodoro.setJumpNumber( 30 );
		pomodoro.oneJumpDone();
		assertThat( pomodoro.remainingJumps(), equalTo( 29 ) );
	}
	
	
	@Test public void
	performsTheJumpSize() throws InterruptedException {
		pomodoro.setJumpNumber( 30 );
		pomodoro.setJumpSize( 1 );
		pomodoro.performJumpSize();
		assertThat( pomodoro.remainingJumps(), equalTo( 29 ) );
	}
	
	@Test public void
	sizeOfJump() throws InterruptedException {
		int jumpSize = 10;
		double precision = 0.2;
		pomodoro.setJumpSize( jumpSize );
		long before = System.currentTimeMillis();
		pomodoro.performJumpSize();
		long after = System.currentTimeMillis();
		assertTrue( ((int) (after-before)) -jumpSize < precision*jumpSize );
	}
	
	@Test public void
	canDetectEnd() throws InterruptedException {
		pomodoro.setJumpNumber(1);
		assertFalse( pomodoro.isEnd() );
		pomodoro.performJumpSize();
		assertTrue( pomodoro.isEnd() );
	}
	
	@Test public void
	canDetectStart() throws InterruptedException {
		pomodoro.setJumpNumber( 500 );
		pomodoro.setJumpSize( 10 );
		pomodoro.start();
		Thread.sleep( 10 * 4 );
		assertTrue( pomodoro.remainingJumps() < ( 500 - 2 ) );
	}
	
	@Test public void
	stopsWhenNoJumpRemain() throws InterruptedException {
		pomodoro.setJumpNumber( 1 );
		pomodoro.setJumpSize( 10 );
		pomodoro.start();
		Thread.sleep( 10 * 3 );
		assertThat( pomodoro.remainingJumps(), equalTo( 0 ) );
	}
	

}
