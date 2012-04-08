require "./Pomodoro.rb"

describe Pomodoro do

before(:each) do
@pomodoro = Pomodoro.new
end

it "un pomodoro dura por defecto 25 minutos " do
@pomodoro.duracion.should == 25
end

it "un pomodoro puede ser creado con cualquier duracion" do
@pomodoro = Pomodoro.new(10)
@pomodoro.duracion.should == 10
end

it "un pomodoro recien creado se encuentra en estado detenido" do
@pomodoro.estado.should == :detenido
end

it "un pomodoro se inicia sin interrupciones" do
@pomodoro = Pomodoro.new(1)
@pomodoro.iniciar
sleep 2
@pomodoro.cant_interrupciones.should == 0
end

it "un pomodoro no se puede interrumpir si no esta en estado  iniciado" do
@pomodoro.interrumpir
@pomodoro.interrumpido?.should be_false
end

it "un pomodoro contabiliza las interrupciones" do
@pomodoro = Pomodoro.new(1)
@pomodoro.iniciar
sleep 2
@pomodoro.interrumpir
@pomodoro.cant_interrupciones.should > 0
end

it "un pomodoro se reinicia sin interrupciones" do
@pomodoro = Pomodoro.new(1)
@pomodoro.iniciar
sleep 2
@pomodoro.interrumpir
@pomodoro.reiniciar
@pomodoro.cant_interrupciones.should == 0
end

it "al iniciar el pomodoro comienza la cuenta regresiva" do
@pomodoro = Pomodoro.new(1)
@pomodoro.iniciar
sleep 2
@pomodoro.tiempo_transcurrido.should < @pomodoro.duracion
end

it "un pomodoro no termina si nunca ha sido iniciado" do
@pomodoro.terminado?.should be_false
end

it "un pomodoro no se termina mientras no finalize el tiempo" do
@pomodoro = Pomodoro.new(5)
sleep 2
@pomodoro.interrumpir
@pomodoro.terminado?.should be_false
end

it "un pomodoro termina cuando se agota su tiempo" do
#puts "error"
@pomodoro = Pomodoro.new(2)
@pomodoro.iniciar
sleep 6
@pomodoro.terminado?.should be_true
puts "pomodoro finalizado correctamente =)"
end

end