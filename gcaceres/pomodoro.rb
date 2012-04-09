class Pomodoro
	attr_reader :duracion
	attr_reader :estado
	attr_reader :num_interrupcion
	attr_reader :tiempo
	attr_reader :hilo
	
	
	#Estados : Iniciado, Parado, Interrupido,Finalizado

	def initialize(duracion)
		@duracion=duracion
		@tiempo  = duracion
		@estado=:parado
		@run= false
	    @num_interrupcion = 0	   
	end

	def arranca
		@tiempo  = @duracion
        @estado = :iniciado
        @num_interrupcion = 0
        @hilo = Thread.new do 
        	
        	@duracion.times do
                @tiempo =  @tiempo - 1
                sleep(1)
		        if @tiempo == 0 
		        	@estado = :finalizado
		        	Thread.kill(@hilo)
		        end
        		
        	end
        end
	end


	def interrumpir
		if @estado!=:iniciado
			raise "No se puede interrumpir"
		else
			@estado = :interrupido
			@num_interrupcion = @num_interrupcion + 1
		end 
	end

end