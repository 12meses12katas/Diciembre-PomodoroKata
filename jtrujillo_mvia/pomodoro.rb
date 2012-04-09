class Pomodoro

	attr_reader :duracion, :parado, :arrancado, :interrupciones, :tiempo_restante, :interrupciones

	def initialize(duracion = 25)
		@duracion = duracion
		@tiempo_restante = duracion
		@parado = true
		@arrancado = false
		@interrupciones = 0
	end

	def interrumpir?
		!@arrancado ? false : true
	end

	def terminar?
		if !@arrancado then
			 false 
		else
			 if tiempo_agotado? then
			 		Thread.kill(@p)
			 		true 
			 	else
			 		false
			 	end
		end
	end

	def arrancar
		@arrancado = true
		@p = Thread.new do 
			loop do
				@tiempo_restante -= 1
				sleep 1
			end
		end
	end

	def tiempo_agotado?
		@tiempo_restante == 0 ? true : false
	end

	def interrumpir
		if interrumpir? then
			@interrupciones += 1
		end
	end

	def reiniciar
		if @arrancado then
			Thread.kill(@p)
			@duracion = duracion
			@tiempo_restante = duracion
			@parado = true
			@arrancado = false
			@interrupciones = 0
			self.arrancar
		end
	end
end