import unittest
from pomodoro import pomodoro
from time import sleep

class Test(unittest.TestCase):

	def setUp(self):
		self.pomodoro = pomodoro()

	def test_crear_pom_def(self):
		self.pomodoro.crear_pom()
		self.assertEqual(self.pomodoro.ESTADO, "STOP")
		self.assertEqual(self.pomodoro.tiempo, 25*60)

	def test_finaliza_pom(self):
		self.pomodoro.iniciar_pom(1)
		self.assertEqual(self.pomodoro.estado, "START")
		sleep(2)
		self.assertEqual(self.pomodoro.estado, "END")

	
	def test_tiempo_inic_pom(self):
		self.assertEqual(self.pomodoro.TIEMPO, 25*60)
	
	def test_tiempo_pom(self):
		self.pomodoro.tiempo_pom()
		self.assertEqual(25*60, self.pomodoro.tiempo)
		self.pomodoro.tiempo_pom(3)
		self.assertEqual(3*60, self.pomodoro.tiempo)
	
	def test_count_interrupts(self):
		self.pomodoro.iniciar_pom(1)
		self.assertEqual(0, self.pomodoro.interruptions())

		self.pomodoro.interrupt_pom()
		self.assertEqual(1, self.pomodoro.interruptions())

		self.pomodoro.interrupt_pom()
		self.assertEqual(2, self.pomodoro.interruptions())

		self.pomodoro.iniciar_pom(1)
		self.assertEqual(0, self.pomodoro.interruptions())


	def test_solo_un_pom(self):
		self.pomodoro.iniciar_pom(2)
		self.pomodoro.iniciar_pom(2)
		self.pomodoro.iniciar_pom(2)
		self.pomodoro.iniciar_pom(2)
		self.assertEqual(1, self.pomodoro.count_t)

	def test_reinic_sin_interrup(self):
		self.pomodoro.iniciar_pom(2)
		self.pomodoro.interrupt_pom()
		self.pomodoro.iniciar_pom(2)
		self.assertEqual(0, self.pomodoro.interruptions())
