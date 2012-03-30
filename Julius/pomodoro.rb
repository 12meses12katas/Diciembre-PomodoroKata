class Pomodoro
	attr_reader :duracion
	attr_reader :parado
	attr_reader :interrupciones
	attr_reader :tiempo_restante
	attr_reader :temporizador

	def initialize(duracion = 25)
		@duracion = duracion
		@parado = true
		@interrupciones = 0
		@tiempo_restante = duracion
	end

	def interrumpir
		if not @parado
			@interrupciones += 1
		end
	end

	def arrancar
		if @parado
			@parado = false
			@temporizador = Thread.new do
			  loop do
				  exit if @tiempo_restante <= 0        	
				  @tiempo_restante -= 1
				  sleep(1) 
				  puts @tiempo_restante
			  end
	    end
	  end
	end

end