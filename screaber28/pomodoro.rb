class Pomodoro
	
	attr_reader :duracion
	attr_reader :detenido
	attr_accessor :iniciado
	attr_reader :contador
	attr_reader :terminado
	attr_accessor :t1

	def initialize(duracion = 25)
		@duracion = duracion
		@detenido = :true
	end
	def iniciar()
		self.iniciado = :false
		@contador = @duracion
		self.t1 = Thread.new do
		 @duracion.times do
		 	@contador -= 1
		  #sleep(@duracion)
		 end
		end
	end

	def terminar()
		if self.iniciado == :true
			#Thread.kill(self.t1)
			#@terminado = :true
			puts "terminado"

		else
			raise_exception	 
		end
		
	end	

	
end