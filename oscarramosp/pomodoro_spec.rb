require "./pomodoro.rb"

describe Pomodoro do

	before(:each) do
		@pomodoro = Pomodoro.new
	end

	it "un pomodoro dura 25 minutos por defecto" do
		@pomodoro.duracion.should == 25
	end		

	it "un pomodoro puede ser creado con cualquier tiempo de duracion" do
		@pomodoro = Pomodoro.new(10)
		@pomodoro.duracion.should == 10
	end

	it "un pomodoro recien creado esta parado" do
		@pomodoro.estado.should == :parado
	end

	it "un pomodoro se inicia sin interrupciones" do
		@pomodoro.arrancar
		@pomodoro.contador_interrupciones.should == 0
	end

	it "un pomodoro no se puede interrumpir si no esta arrancado" do
		@pomodoro.interrumpir
		@pomodoro.interrumpido?.should be_false
	end

	it "un pomodoro cuenta las interrupciones" do
		@pomodoro.arrancar
		@pomodoro.interrumpir
		@pomodoro.contador_interrupciones.should > 0
	end

	it "un pomodoro se reinicia sin interrupciones" do
		@pomodoro.arrancar
		@pomodoro.interrumpir
		@pomodoro.reiniciar
		@pomodoro.contador_interrupciones.should == 0
	end

	it "al arrancar el pomodoro  comienza la cuenta regresiva" do
		@pomodoro.arrancar
		sleep 2
		@pomodoro.tiempo_transcurrido.should < @pomodoro.duracion
	end

	it "un pomodoro no termina si no ha sido arrancado" do
		@pomodoro.terminado?.should be_false
	end

	it "un pomodoro no se acaba mientras no termine su tiempo" do
		@pomodoro = Pomodoro.new(5)
		sleep 2
		@pomodoro.interrumpir
		@pomodoro.terminado?.should be_false
	end

	it "un pomodoro acaba cuando se agota su tiempo" do
		puts "metodo error"
		@pomodoro = Pomodoro.new(2)
		@pomodoro.arrancar
		sleep 6
		@pomodoro.terminado?.should be_true
	end

end