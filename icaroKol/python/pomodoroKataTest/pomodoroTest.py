from pomodoroKata.pomodoro import Pomodoro
import time


__author__ = 'Yamit Cardenas'

import unittest

class MyTestCase(unittest.TestCase):

    def test_create_pomodoro_by_default(self):
        pomodoro = Pomodoro()
        self.assertEqual(pomodoro.duration, 25)
        self.assertEqual(pomodoro.timeLeft,25*60)

    def test_create_pomodoro_stoped_by_default(self):
        pomodoro = Pomodoro()
        self.assertEqual(pomodoro.started, False)

    def test_create_pomodo_with_30min_of_duration(self):
        pomodoro = Pomodoro(30)
        self.assertEqual(pomodoro.duration,30)
        self.assertEqual(pomodoro.timeLeft,30*60)

    def test_create_pomodo_with_1min_of_duration(self):
        pomodoro = Pomodoro(1)
        self.assertEqual(pomodoro.duration,1)

    def test_create_pomodo_with_minus_15min_of_duration(self):
        pomodoro = Pomodoro(-15)
        self.assertEqual(pomodoro.duration,25)

    def test_create_pomodo_with_minus_100min_of_duration(self):
        pomodoro = Pomodoro(-100)
        self.assertEqual(pomodoro.duration,25)

    def test_create_pomodo_with_zero_min_of_duration(self):
        pomodoro = Pomodoro(0)
        self.assertEqual(pomodoro.duration,25)

    def test_start_pomodoro(self):
        pomodoro = Pomodoro(0.1)

        pomodoro.startPomodoro()

        self.assertEqual(pomodoro.started, True)
        time.sleep(1)
        self.assertTrue(pomodoro.timeLeft<=(0.1*60))

    def test_not_finish_without_starting(self):
        pomodoro= Pomodoro()
        self.assertEqual(pomodoro.finish,False)

    def test_not_finish_and_starting(self):
        pomodoro= Pomodoro(0.1)

        pomodoro.startPomodoro()

        self.assertEqual(pomodoro.finish,False)

    def test_starting_and_finish(self):
        pomodoro= Pomodoro(0.1)

        pomodoro.startPomodoro()
        time.sleep(7)
        self.assertEqual(pomodoro.finish,True)

    def test_pomodoro_without_interruptions(self):
        pomodoro = Pomodoro()

        self.assertEqual(pomodoro.interruptions,0)

    def test_interrupt_pomodoro_without_start(self):
        pomodoro = Pomodoro()

        pomodoro.interrupt()

        self.assertEqual(pomodoro.interruptions,0)

    def test_pomodoro_start_without_interruptions(self):
        pomodoro = Pomodoro(0.1)

        pomodoro.startPomodoro()

        self.assertEqual(pomodoro.interruptions,0)

    def test_pomodoro_start_with_one_interruption(self):
        pomodoro = Pomodoro(0.1)

        pomodoro.startPomodoro()
        pomodoro.interrupt()

        self.assertEqual(pomodoro.interruptions,1)

    def test_pomodoro_start_with_three_interruptions(self):
        pomodoro = Pomodoro(0.1)

        pomodoro.startPomodoro()
        pomodoro.interrupt()
        pomodoro.interrupt()
        pomodoro.interrupt()

        self.assertEqual(pomodoro.interruptions,3)


if __name__ == '__main__':
    unittest.main()
