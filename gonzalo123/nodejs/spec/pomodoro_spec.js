(function() {
  var Pomodoro;

  Pomodoro = require('../pomodoro').Pomodoro;

  describe('jasmine-node', function() {
    it('a pomodoro must be started if we want to stop it', function() {
      var pom;
      pom = new Pomodoro;
      pom.setTimeout = function(cbk, step) {
        return cbk();
      };
      try {
        return pom.stop();
      } catch (error) {
        return expect("Pomodoro must be started").toEqual("Pomodoro must be started");
      }
    });
    it('25 minutes by default', function() {
      var pom;
      pom = new Pomodoro(25);
      pom.setTimeout = function(cbk, step) {
        return cbk();
      };
      pom.registerCallback(function() {
        return expect(this.beats).toEqual(25);
      });
      return pom.start();
    });
    it('We can start pomodoros with another value than 25', function() {
      var pom;
      pom = new Pomodoro(10);
      pom.setTimeout = function(cbk, step) {
        return cbk();
      };
      pom.registerCallback(function() {
        return expect(this.beats).toEqual(10);
      });
      return pom.start();
    });
    return it('stops', function() {
      var pom;
      pom = new Pomodoro(5);
      pom.registerCallback(function() {
        return expect(this.beats).toEqual(5);
      });
      expect(pom.getStops()).toEqual(0);
      pom.start();
      waits(500);
      pom.stop();
      expect(pom.getStops()).toEqual(1);
      pom.start();
      waits(500);
      pom.stop();
      return expect(pom.getStops()).toEqual(2);
    });
  });

}).call(this);
