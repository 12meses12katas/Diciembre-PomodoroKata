class Pomodoro

    attr_reader :duracion
    attr_reader :estado
    attr_reader :tiempo_transcurrido
    attr_reader :contador_interrupciones
    #@t

    def initialize(duracion = 25)
        @duracion = duracion
        @estado   = :parado
        @tiempo_transcurrido = @duracion
        @contador_interrupciones = 0
    end

    def arrancar
        if (@estado == :parado or @estado == :interrumpido)
            @estado   = :arrancado
            
            @t = Thread.new do 
              loop do
                if @tiempo_transcurrido <= 0
                    Thread.kill(@t)
                    terminar
                end
                @tiempo_transcurrido -= 1 
                sleep 1
              end
            end            
        end
    end

    def interrumpir
        if @estado  == :arrancado then 
            @estado == :interrumpido
            @contador_interrupciones = @contador_interrupciones + 1
            Thread.kill(@t) if @t
        end
    end

    def interrumpido?
        if (@estado == :interrumpido)
            true
        else
            false
        end
    end

    def reiniciar
        @tiempo_transcurrido = @duracion
        @estado   = :parado
        @contador_interrupciones = 0
    end

    def terminar
        if (@tiempo_transcurrido <= 0)
            @estado   = :terminado
            if (@t.alive?)
                Thread.kill(@t) if @t
                Raise
            end
        end
    end

    def terminado?
        if (@tiempo_transcurrido <= 0)
            true
        else
            false
        end
    end
end