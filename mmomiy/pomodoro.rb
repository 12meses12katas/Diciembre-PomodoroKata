class Pomodoro
	attr_reader :duracion , :interrupciones, :estado

	def initialize(duracion=25)
		@duracion = duracion
		@estado = :parado
		@interrupciones = 0
	end

	def arrancar
		a = Thread.new do 
			while @duracion > 0 do 
				@duracion -= 1; 
				sleep 1
			end
		end
		@estado = :arrancado
	end

	def termino?
		if @estado != :arrancado
			raise "Estado no arrancado"
		end
		@duracion <= 0
	end

	def finalizar
		if @duracion > 0
			raise "Estado no finalizado"
		end
	end

	def interrumpido?
		@interrupciones > 0
	end

	def interrumpir
		if @estado != :arrancado
			raise "Estado no arrancado"
		end
		@interrupciones += 1
		
	end

	def reiniciar
		@interrupciones = 0
		@duracion = 25
		:arrancar
	end
end