__author__ = 'Yamit Cardenas'
import time
import threading


class Pomodoro(threading.Thread):

    def __init__(self, duration=25):
        super(Pomodoro, self).__init__()

        self.__setDuration(duration)
        self.started = False
        self.timeLeft = self.duration * 60
        self.finish = False
        self.interruptions = 0

    def __setDuration(self,duration):
        if(duration > 0):
            self.duration = duration
        else:
            self.duration = 25

    def startPomodoro(self):
        self.started = True
        self.start()

    def run(self):
        while self.timeLeft:
            time.sleep(1)
            self.timeLeft -= 1
        self.finish = True

    def interrupt(self):
        if(self.started):
            self.interruptions += 1


