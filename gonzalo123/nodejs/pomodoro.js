(function() {
  var Pomodoro;

  Pomodoro = (function() {

    function Pomodoro(limitTime) {
      this.limitTime = limitTime != null ? limitTime : 25;
      this.step = 1000;
      this.endCbk = function() {
        return "Pomodoro is over";
      };
      this.init();
    }

    Pomodoro.prototype.init = function() {
      this.beats = 0;
      this.currentTime = this.limitTime;
      this.stops = 0;
      return this.running = false;
    };

    Pomodoro.prototype.stop = function() {
      if (this.running === false) throw "Pomodoro must be started";
      this.running = false;
      clearTimeout(this.timer);
      return this.stops++;
    };

    Pomodoro.prototype.getStops = function() {
      return this.stops;
    };

    Pomodoro.prototype.getBeats = function() {
      return this.beats;
    };

    Pomodoro.prototype.start = function() {
      this.running = true;
      return this.beat();
    };

    Pomodoro.prototype.restart = function() {
      if (this.running === true) this.stop();
      this.init();
      return this.start();
    };

    Pomodoro.prototype.setTimeout = function(cbk, step) {
      setTimeout(cbk, step);
    };

    Pomodoro.prototype.beat = function() {
      var _this = this;
      this.beats++;
      this.currentTime--;
      if (this.currentTime > 0) {
        return this.timer = this.setTimeout((function() {
          return _this.beat();
        }), this.step);
      } else {
        return this.end();
      }
    };

    Pomodoro.prototype.registerCallback = function(endCbk) {
      this.endCbk = endCbk;
    };

    Pomodoro.prototype.end = function() {
      return this.endCbk();
    };

    return Pomodoro;

  })();

  exports.Pomodoro = Pomodoro;

}).call(this);
