function PomodoroKata(duration){
    this.stopped = true;
    this.duration = (duration != null) ? duration : 25;
    this.timeConsumed = 0;
    this.interruptions = 0;
}

PomodoroKata.prototype.getDuration = function(){
    return this.duration;
}

PomodoroKata.prototype.isStopped = function() {
    return this.stopped;
}

PomodoroKata.prototype.start = function() {
    this.stopped = false;
    this.interruptions = 0;
}

PomodoroKata.prototype.isFinished = function() {
    return ((!this.isStopped()) && (this.timeConsumed >= this.duration));
}

PomodoroKata.prototype.hasInterruptions = function() {
    return false;
}

PomodoroKata.prototype.interrupt = function(){
    if (this.isStopped()) {
        return false;
    }
    this.interruptions++;
    return true;
}

PomodoroKata.prototype.countInterruptions = function(){
    return this.interruptions;
}

PomodoroKata.prototype.setMinutesConsumed = function(minutes){
    this.timeConsumed += minutes;
}

PomodoroKata.prototype.getMinutesLeft = function(){
    return this.duration - this.timeConsumed;
}
