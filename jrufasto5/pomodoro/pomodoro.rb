class Pomodoro
	attr_reader :duracion
	attr_reader :corriendo
	attr_reader :minutos
	attr_reader :contador
	attr_reader :interrupciones

	def initialize(duracion = 25)
		@duracion = duracion
		@corriendo = false
		@interrupciones = 0
		@contador = duracion*60
	end

	def iniciar
		@corriendo = true
		Thread.new do 
			while @contador > 0
				sleep 1
				@contador -= 1
			end
			@corriendo = false
		end
	end

	def reiniciar
		@corriendo = false
		@interrupciones = 0
		@contador = duracion*60
		:iniciar	
	end

	def interrumpir
		if @corriendo == false
			raise "Pomodoro se encuentra detenido"
		else 
			@interrupciones += 1
			@corriendo = false
		end
	end
end