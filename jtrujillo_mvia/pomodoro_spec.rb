require './pomodoro.rb'
describe Pomodoro do

	before(:each) do
		@pomodoro = Pomodoro.new
	end

	context "al crear" do
		it "un pomodoro dura 25 minutos por defecto" do
			@pomodoro.duracion.should == 25
		end

		it "un pomodoro puede ser creado con cualquier duracion" do
			pomodoro = Pomodoro.new(10)
			pomodoro.duracion.should == 10
		end
	end

	context "al parar" do
		it "un pomodoro recien creado esta parado" do
			@pomodoro.parado.should == true
		end

		it "al arrancar un pomodoro comienza la cuenta atras" do
			@pomodoro.arrancar
			sleep 2
			@pomodoro.tiempo_restante < @pomodoro.duracion
		end

		it "un pomodoro no termina si no ha sido arrancado previamente" do
			@pomodoro.terminar? == false
		end

		it "un pomodoro acaba cuando se agota su tiempo" do
			pomodoro = Pomodoro.new(2)
			pomodoro.arrancar
			sleep 2
			pomodoro.tiempo_agotado? == true
		end

		it "Un pomodoro no acaba mientras no se agote su tiempo" do
			@pomodoro.arrancar
			sleep 2
			@pomodoro.terminar? == false
		end
	end

	context "al interrumpir" do
		it "un pomodoro se inicia sin interrupciones" do
			@pomodoro.interrupciones.should == 0
		end

		it "si no esta arrancado no se puede interrumpir" do
			@pomodoro.interrumpir? == false
		end

		it "El pomodoro cuenta las interrupciones (1, 2...)" do
			pomodoro = Pomodoro.new(5)
			pomodoro.arrancar
			sleep 2
			pomodoro.interrumpir
			sleep 2
			pomodoro.interrumpir
			pomodoro.interrupciones == 2
		end
	end

	context "al reiniciar" do
		it "Un pomodoro ya arrancado se reinicia (empieza a contar el tiempo) al arrancarlo de nuevo" do
			pomodoro = Pomodoro.new(2)
			pomodoro.arrancar
			sleep 1
			pomodoro.reiniciar
			pomodoro.tiempo_restante == 2
		end
		it "Un pomodoro se reinicia sin interrupciones" do
			pomodoro = Pomodoro.new(2)
			pomodoro.arrancar
			sleep 1
			pomodoro.reiniciar
			pomodoro.interrupciones == 0
		end
	end

end