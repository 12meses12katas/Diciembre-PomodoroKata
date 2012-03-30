require "./pomodoro.rb"
describe Pomodoro do

	it "un pomodoro dura 25 minutos por defecto" do
		pomodoro = Pomodoro.new
    	pomodoro.duracion.should == 25
	end
	
	it "Un pomodoro puede ser creado con cualquier duracion" do
		pomodoro = Pomodoro.new(10)
		pomodoro.duracion.should == 10
	end

	it "Un pomodoro recien creado esta parado" do
		pomodoro = Pomodoro.new(10)
		pomodoro.detenido.should be_true
	end

	it "Al arrancar el pomodoro comienza la cuenta atras" do
		pomodoro = Pomodoro.new
		pomodoro.iniciar
		sleep 2
		pomodoro.contador.should be < pomodoro.duracion
	end

	it "Un pomodoro no termina si no ha sido iniciado previamente" do
		pomodoro = Pomodoro.new
		pomodoro.iniciar
		pomodoro.terminar
		pomodoro.terminado.should be_true
	end




	
end
	
