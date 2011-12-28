
public class Pomodoro {

	private int remaining;
	private long jumpSize;
	
	public void setJumpNumber(int i) {
		this.remaining = i;
	}

	public Integer remainingJumps() {
		return remaining;
	}

	public void oneJumpDone() {
		remaining -= 1;
	}

	public void setJumpSize(long i) {
		this.jumpSize = i;
	}

	public void performJumpSize() throws InterruptedException {
		Thread.sleep(jumpSize);
		oneJumpDone();
	}

	public boolean isEnd() {
		return remaining == 0;
	}

	public void start() {
		Thread thread = new Thread(new Runnable() {
			public void run() {
				while (!Pomodoro.this.isEnd()) {
					try {
						Pomodoro.this.performJumpSize();
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
			}
		});
		thread.start();
	}

}
