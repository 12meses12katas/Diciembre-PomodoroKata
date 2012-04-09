describe("Basics", function(){
	it("can launch Jasmine tests", function() {
		expect(true).toBe(true);
	});
});
describe("Pomodoro", function() {
  var pomodoro;
  beforeEach(function() {
    pomodoro = new Pomodoro();
  });
  describe("initial rendering", function() {
    it("displays a start button", function() {
      expect(element("start-button").innerHTML).toBe("start");
      expect(element("start-button").href).toBe("javascript:pomodoro.start();");
    });
    it("displays an input field with default length of 1500s", function() {
      expect(element("configuration").value).toBe("1500");
    });
  });
  describe("start", function() {
    it("uses the configuration to set the remaining time", function() {
      pomodoro.start();
      expect(pomodoro.remainingTime).toBe(1500);
      expect(element("remaining-label").innerHTML).toBe("<center>25mn0s</center>");
    });
    it("launches the count down", function() {
      window.pomodoro = pomodoro;
      pomodoro.interval = 10;
      spyOn(pomodoro, 'tic');
      pomodoro.start();
      waits(50);
      runs(function() {
        expect(pomodoro.tic.callCount).toBeGreaterThan(1);
      });
    });
    it("does not start several timers", function() {
      expect(pomodoro.timerCount).toBe(0);
      pomodoro.start();
      expect(pomodoro.timerCount).toBe(1);
      pomodoro.start();
      expect(pomodoro.timerCount).toBe(1);
    });
  });
  describe("speed", function() {
    it("is 1000", function() {
      expect(pomodoro.interval).toBe(1000);
    });
  });
  describe("tic", function() {
    it("decreases the remaining by one", function() {
      pomodoro.remainingTime = 30;
      pomodoro.tic();
      expect(pomodoro.remainingTime).toBe(29);
      expect(element("remaining-label").innerHTML).toContain("29s");
    });
  });
  describe("end", function() {
    it("displays negative values in red", function() {
      pomodoro.remainingTime = 0;
      pomodoro.tic();
      expect(element("remaining-label").style.color).toBe('red');
    });
  });
  describe("rendering remaining time", function() {
    it("displays remaining with minutes and seconds", function() {
      pomodoro.remainingTime = 65;
      expect(pomodoro.remainingTimeToString()).toBe("1mn5s");
    });
    it("displays negatives with minutes and seconds", function() {
      pomodoro.remainingTime = -65;
      expect(pomodoro.remainingTimeToString()).toBe("-1mn5s");
    });
    it("dont display minutes when minute is zero", function() {
      pomodoro.remainingTime = -5;
      expect(pomodoro.remainingTimeToString()).toBe("-5s");
    });
  });
});




