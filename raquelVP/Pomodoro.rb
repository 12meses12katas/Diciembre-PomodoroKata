class Pomodoro

    attr_reader :estado
    attr_reader :duracion        
    attr_reader :cant_interrupciones
    attr_reader :tiempo_transcurrido


    def initialize(duracion = 25)
        @duracion = duracion
        @estado = :detenido
        @tiempo_transcurrido = @duracion
        @cant_interrupciones = 0
    end

    def iniciar
        if (@estado == :detenido or @estado == :interrumpido)
            @estado = :iniciado
            
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
        if @estado == :iniciado then
            @estado == :interrumpido
            @cant_interrupciones = @cant_interrupciones + 1
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
        @estado = :detenido
        @cant_interrupciones = 0
    end

    def terminar
        if (@tiempo_transcurrido <= 0)
            @estado = :terminado
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