require './pomodoro.rb'

describe Pomodoro do

  before(:each)do
    @pomodoro = Pomodoro.new(2)
  end

  context "al crear " do
    it "dura 2 minutos por defecto" do
      @pomodoro.duracion.should == 2
    end

    it "puede ser creado con cualquier duracion" do
      @pomodoro = Pomodoro.new(10)
      @pomodoro.duracion.should == 10
    end
  end

  context "al parar " do
    it "recien creado esta parado" do
      @pomodoro.estado.should == :parado
    end

    it "Al arrancar un pomodoro comienza la cuenta atras" do
      @pomodoro.arrancar
      sleep 2
      @pomodoro.duracion.should <= 2
    end

    it "no termina si no ha sido arrancado previamente" do
      expect {
        @pomodoro.termino?
        }.should raise_exception
    end

    it "acaba cuando se agota su tiempo" do
        @pomodoro.arrancar
        sleep 3
        @pomodoro.termino?.should be_true
    end

    it "no acaba mientras no se agote su tiempo" do
         @pomodoro.arrancar
         expect {
            @pomodoro.finalizar
          }.should raise_exception
    end

  end

  context "al interrumpir " do
    it " se inicia sin interrupciones" do
      @pomodoro.interrumpido?.should be_false
    end

    it "Si no esta arrancado no se puede interrumpir" do
      expect {
        @pomodoro.interrumpir
      }.should raise_exception
    end

    it "cuenta las interrupciones (1, 2...)" do
      @pomodoro.arrancar
      @pomodoro.interrumpir
      @pomodoro.interrupciones.should > 0
    end

  end

  context "al reiniciar " do
    it "ya arrancado se reinicia (empieza a contar el tiempo) al arrancarse de nuevo" do
        @pomodoro.arrancar
        sleep 1
        @pomodoro.interrumpir
        @pomodoro.reiniciar
        @pomodoro.duracion.should eq(25)
    end

    it "se reinicia sin interrupciones" do
         @pomodoro.arrancar
        sleep 1
        @pomodoro.interrumpir
        @pomodoro.reiniciar
        @pomodoro.interrupciones.should eq(0)
    end
  end
end