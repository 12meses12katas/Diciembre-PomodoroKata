from time import sleep
import threading

class pomodoro:

	def __init__(self):
		self.ESTADO = "STOP"
		self.TIEMPO = 25*60
		self.INTERR = 0
		self.estado = self.ESTADO
		self.tiempo = self.TIEMPO
		self.interr = self.INTERR
		self.on = False
		self.count_t = 0

	def interruptions(self):
		return self.interr


	def terminar(self):
		self.estado = "END"
		self.on = False


	def arrancar(self, time):
		global t
		if self.on == True:
			t.cancel()
			self.on == False
			self.count_t -= 1
		t = threading.Timer(time, self.terminar)
		t.start()
		self.count_t += 1
		self.on = True


	def crear_pom(self, time = 25*60):

		self.estado="STOP"
		self.tiempo = time
		

	def iniciar_pom(self, time = 0):
		if time == 0:
			time = self.tiempo

		self.estado = "START"

		self.arrancar(time)

		self.interr = 0

	
	def tiempo_pom(self, mins = 0):
		if mins == 0:
			self.tiempo = 25*60
		else:
			self.tiempo = mins*60

	def interrupt_pom(self):
		if self.estado=="STOP":
			print "No puedes parar algo no empezado"
		
		else:
			self.interr += 1