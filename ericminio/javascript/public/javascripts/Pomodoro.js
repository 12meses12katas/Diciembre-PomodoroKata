function Pomodoro() {
  this.interval = 1000;
  this.createConfigurationField();
  this.createStartButton();
  this.createRemainingLabelPlaceHolder();
  this.timerCount = 0;
};

Pomodoro.prototype.createConfigurationField = function() {
  var config = document.createElement("input");
  config.id = "configuration";
  config.value = "1500";
  document.body.appendChild(config);
};

Pomodoro.prototype.createStartButton = function() {
  var start = document.createElement("a");
  start.id = "start-button";
  start.innerHTML = "start";
  start.href = "javascript:pomodoro.start();";
  document.body.appendChild(start);
};

Pomodoro.prototype.createRemainingLabelPlaceHolder = function() {
  var label = document.createElement("span");
  label.id = "remaining-label";
  document.body.appendChild(label);
};

Pomodoro.prototype.updateRemainingLabel = function() {
  element("remaining-label").innerHTML = 
    "<center>" + this.remainingTimeToString() + "</center>";
  if (this.remainingTime < 0) {
    element("remaining-label").style.color = 'red';
  }
};

Pomodoro.prototype.remainingTimeToString = function() {
  var minutes = Math.floor(this.remainingTime / 60);
  if (minutes == 0 || minutes == -1) {
    return this.remainingTime + "s";
  }
  if (minutes < 0) {
    minutes += 1;
  }
  var seconds = Math.abs(this.remainingTime) % 60;
  return minutes + "mn" + seconds + "s";
};

Pomodoro.prototype.start = function() {
  this.remainingTime = parseInt(element("configuration").value);
  this.updateRemainingLabel();
  if (this.timerCount == 0) {
    setInterval(function(){window.pomodoro.tic();}, this.interval);
    this.timerCount ++;
  }
};

Pomodoro.prototype.tic = function() {
  this.remainingTime -= 1;
  this.updateRemainingLabel();
};


