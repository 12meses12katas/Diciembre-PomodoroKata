
function pomodoroKataTest() {}
registerTestSuite(pomodoroKataTest);

pomodoroKataTest.prototype.testPomodoroDefaultDurationIs25Minutes = function() {
    var pomodoro = new PomodoroKata();
    expectThat(pomodoro.getDuration(), equals(25));
}

pomodoroKataTest.prototype.testPomodoroCanHavePersonalizedDuration = function() {
    var pomodoro = new PomodoroKata(30);
    expectThat(pomodoro.getDuration(), equals(30));
}

pomodoroKataTest.prototype.testNewPomodoroIsStopped = function(){
    var pomodoro = new PomodoroKata();
    expectThat(pomodoro.isStopped(), equals(true));
}

pomodoroKataTest.prototype.testWhenPomodoroIsStartedTheCountDownIsOn = function() {
    var pomodoro = new PomodoroKata();
    pomodoro.start();
    expectThat(pomodoro.isStopped(), equals(false));
}

pomodoroKataTest.prototype.testPomodoroCantBeFinishedIfNotStarted = function(){
    var pomodoro = new PomodoroKata();
    expectThat(pomodoro.isFinished(),equals(false));
}

pomodoroKataTest.prototype.testPomodoroIsFinishedWhenTimeIsOver = function() {
    var pomodoro = new PomodoroKata();
    pomodoro.start();
    pomodoro.setMinutesConsumed(25);
    expectThat(pomodoro.isFinished(), equals(true));
}

pomodoroKataTest.prototype.testNewPomodoroHasNoInterruptions = function() {
    var pomodoro = new PomodoroKata();
    expectThat(pomodoro.hasInterruptions(),equals(false));
}

pomodoroKataTest.prototype.testNonStartedPomodoroCantBeInterrupted = function() {
    var pomodoro = new PomodoroKata();
    expectThat(pomodoro.interrupt(), equals(false));
}

pomodoroKataTest.prototype.testStartedPomodoroCountsInterruptions = function() {
    var pomodoro = new PomodoroKata();
    pomodoro.start();
    pomodoro.interrupt();
    expectThat(pomodoro.countInterruptions(), equals(1));
    pomodoro.interrupt();
    pomodoro.interrupt();
    expectThat(pomodoro.countInterruptions(), equals(3));
}

pomodoroKataTest.prototype.testStartedPomodoroIfRestartedThenKeepsCountDown = function() {
    var pomodoro = new PomodoroKata();
    pomodoro.start();
    pomodoro.setMinutesConsumed(5);
    pomodoro.start();
    expectThat(pomodoro.getMinutesLeft(), equals(20));
}

pomodoroKataTest.prototype.testRestartedPomodoroHasNoInterruptions = function(){
    var pomodoro = new PomodoroKata();
    pomodoro.start();
    pomodoro.interrupt();
    pomodoro.setMinutesConsumed(5);
    pomodoro.start();
    expectThat(pomodoro.countInterruptions(), equals(0));

}

