require "./pomodoro.rb"

describe Pomodoro do 

	before(:each) do
       @pomodoro = Pomodoro.new(25)
    end
    context "al crear" do
		it "un pomodoro dura 25 minutos por defecto" do		
			@pomodoro.duracion.should==25
		end
		it "un pomodor puede ser creado con cualquier duracoin" do
			@pomodoro = Pomodoro.new(10)
			@pomodoro.duracion.should==10
		end
		it "un pomodoro recien creado esta parado" do
			#@pomodoro  = Pomodoro.new(25)
			@pomodoro.estado.should==:parado
		end

	end

	context "al parar" do
		it "Al arrancar un pomodoro comienza cuentra atras" do
			@pomodoro.arranca()
			sleep 1			
			@pomodoro.tiempo.should < @pomodoro.duracion			


		end

		it "Un pomodoro no termina sino ha sido arrancado previamente" do
			@pomodoro.arranca()
			@pomodoro.tiempo.should > 0 #Termina cuando el tiempo es 0
			@pomodoro.estado.should == :iniciado
		
		end
		
		it "Un pomodoro acaba cuando se agota su tiempo" do
			@pomodoro = Pomodoro.new(1)
			@pomodoro.arranca()
			sleep 2
			@pomodoro.tiempo.should == 0 
			@pomodoro.estado.should == :finalizado
		
		end

		it "Un pomodoro no acaba mientras no se agote su tiempo" do	
            @pomodoro.arranca()
			@pomodoro.tiempo.should > 0 
			@pomodoro.estado.should_not == :finalizado		

		end
	end

	context "al interrumpir" do
		it "Un pomodoro se inicia sin interrupciones" do	
			@pomodoro.tiempo.should == @pomodoro.duracion
			@pomodoro.num_interrupcion.should == 0	
		end

		it "Si no esta arrancado no se puede interrumpir" do	
			expect{				
				@pomodoro.interrumpir()
			}.should raise_error
		end

		it "El pomodoro cuenta las interrupciones" do	
			@pomodoro.arranca()
			@pomodoro.interrumpir()
			@pomodoro.num_interrupcion.should>0
		end
	end

	context "reiniciar" do
		it "Un pomodoro ya arrancado se reinicia (empieza a contar el tiempo) al arrancarlo de nuevo" do
			@pomodoro.arranca()
			sleep 1
			@pomodoro.arranca()
			@pomodoro.tiempo.should == @pomodoro.duracion #si se reincia el tiempo (que es el que disminuye) y la duracion establecida son iguales
			
		end

		it "Un pomodoro se reinicia sin interrupciones" do
			@pomodoro.arranca()
			@pomodoro.interrumpir()
			sleep 1
			@pomodoro.arranca()
			@pomodoro.num_interrupcion.should == 0	
		end
	end
end

 
