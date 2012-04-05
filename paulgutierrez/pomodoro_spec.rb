require "./pomodoro.rb"

describe Pomodoro do 

   it "un pomodoro dura 25 minutos por defecto" do
     pomodoro=Pomodoro.new
     pomodoro.duracion.should==25
   end

  it "un pomodoro puede ser creado con cualquier duracion" do
     pomodoro=Pomodoro.new(10)
     pomodoro.duracion.should==10
     
   end

it "un pomodoro recien creado esta parado" do
     pomodoro=Pomodoro.new
     pomodoro.fin.should be_true
   end


it "al arrancar un pomodoro comienza la cuenta atras" do
     pomodoro=Pomodoro.new
     pomodoro.arranca
     pomodoro.tiempo.should>0
   end


it "Un pomodoro no termina si no ha sido arrancado previamente" do
     pomodoro=Pomodoro.new
     pomodoro.arranca
     pomodoro.fin.should be_false
   end

it "Un pomodoro acaba cuando se agota su tiempo" do
     pomodoro=Pomodoro.new
     pomodoro.arranca
     pomodoro.tiempo.should>0
   end

it "Un pomodoro no acaba mientras no se agote su tiempo" do
     pomodoro=Pomodoro.new
     pomodoro.arranca
     pomodoro.inicio.should be_true
end

it "Un pomodoro se inicia sin interrupciones" do
     pomodoro=Pomodoro.new
     pomodoro.interrupciones.should==0
end

it "Si no esta arrancado no se puede interrumpir" do
     pomodoro=Pomodoro.new
     pomodoro.arranca
     pomodoro.interrupciones.should==0
end

it "Un pomodoro ya arrancado se reinicia (empieza a contar el tiempo) 
al arrancarlo de nuevo" do
     pomodoro=Pomodoro.new
     pomodoro.arranca
     pomodoro.reinicia
     pomodoro.tiempo.should==25
end

it "Un pomodoro se reinicia sin interrupciones" do
     pomodoro=Pomodoro.new
     pomodoro.arranca
     pomodoro.reinicia
     pomodoro.interrupciones.should==0
end

end