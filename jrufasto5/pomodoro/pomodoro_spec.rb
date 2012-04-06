require './pomodoro.rb'

describe Pomodoro do 
	
	before(:each) do
		@pomodoro = Pomodoro.new
	end

	it "un pomodoro dura 25 minutos por defecto" do
	    @pomodoro.duracion.should eq(25)
	end

	it "un pomodoro puede ser creado con cualquier duracion" do
		@pomodoro = Pomodoro.new(10)
		@pomodoro.duracion.should eq(10)
	end

	it "un pomodoro recien creado esta parado" do
		@pomodoro.corriendo.should eq(false)
	end

	it "Al arrancar un pomodoro comienza la cuenta atras" do
		@pomodoro.iniciar
		sleep 5
		@pomodoro.contador.should be < 25*60
	end

	it "un pomodoro no termina si no ha sido arrancado previamente" do
		@pomodoro = Pomodoro.new(1)
		expect {
			@pomodoro.interrumpir
		}.should raise_exception
	end

	it "un pomodoro acaba cuando se agota su tiempo" do
		@pomodoro = Pomodoro.new(0.1)
		@pomodoro.iniciar
		sleep 8
		@pomodoro.corriendo.should eq(false)
	end

	it "un pomodoro no acaba mientras no se agote su tiempo" do
		@pomodoro = Pomodoro.new(0.5)
		@pomodoro.iniciar
		sleep 2
		@pomodoro.corriendo.should eq(true)
	end

	it "un pomodoro se inicia sin interrupciones" do
		@pomodoro = Pomodoro.new(0.5)
		@pomodoro.iniciar
		@pomodoro.interrupciones.should eq(0)
	end

	it "un pomodoro si no esta arrancado no se puede interrumpir" do
		@pomodoro = Pomodoro.new(1)
		expect {
			@pomodoro.interrumpir
		}.should raise_exception
	end

	it "un pomodoro cuenta las interrupciones" do
		@pomodoro = Pomodoro.new(0.5)
		@pomodoro.iniciar
		@pomodoro.interrumpir
		@pomodoro.iniciar
		@pomodoro.interrumpir
		@pomodoro.interrupciones.should eq(2)
	end

	it "un pomodoro ya arrancado se reinicia (empieza a contar el tiempo) al arrancarlo de nuevo" do
		@pomodoro.iniciar
		sleep 3
		@pomodoro.reiniciar
		@pomodoro.contador.should eq(25*60)
	end

	it "un pomodoro se reinicia sin interrupciones" do
		@pomodoro.iniciar
		sleep 3
		@pomodoro.interrumpir
		@pomodoro.reiniciar
		@pomodoro.interrupciones.should eq(0)
	end
end