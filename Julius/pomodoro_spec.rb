require "./pomodoro.rb"

describe Pomodoro do

	before(:each) do
		@pomodoro = Pomodoro.new
	end

	context "CREAR UN POMODORO" do
		it "un pomodoro dura 25 minutos por defecto" do
			@pomodoro.duracion.should == 25
		end

		it "un pomodoro puede ser creado con cualquier duracion" do
	  	@pomodoro = Pomodoro.new(10)
	  	@pomodoro.duracion.should == 10
	  end	  	  
	end

	context "PARAR UN POMODORO" do
	  it "un pomodoro recien hecho esta parado" do
	  	@pomodoro.parado.should be_true
	  end

	  it "al arrancar un pomodoro comienza la cuenta atras" do
	  	@pomodoro = Pomodoro.new(10)
	  	@pomodoro.arrancar
	  	sleep(5)
	  	@pomodoro.tiempo_restante.should < 10			
	  end

	  it "al arrancar un pomodoro comienza la cuenta atras" do
	  	@pomodoro.tiempo_restante.should > 0
	  end

	end

	context "INTERRUMPIR UN POMODORO" do
		it "un pomodoro se inicia sin interrupciones" do
	  	@pomodoro.interrupciones.should == 0
	  end  

	  it "si no esta arrancado no se puede interrumpir" do
	  	@pomodoro.interrumpir
	  	@pomodoro.interrupciones.should == 0  	
	  end

	  it "el pomodoro cuenta las interrupciones" do
	  	@pomodoro.arrancar
	  	@pomodoro.interrumpir
	  	@pomodoro.interrupciones.should == 1
	  end
	end

	context "REINICIAR UN POMODORO" do		
	end


end