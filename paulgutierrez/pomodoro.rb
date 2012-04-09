class Pomodoro

 attr_reader :duracion , :fin, :inicio, :tiempo, :contador, :interrupciones
 

 def initialize(duracion=25)
 	@duracion=duracion
 	@fin=true
 	@inicio=false
 	@interrupciones=0
 	@tiempo=duracion
 end
 

 def arranca
 	@fin=false
 	@inicio=true
 	@interrupciones=0
 	@contador= Thread.new { loop { tiempo -= 1 } }
 	sleep(1)
 end

 def reinicia
 	@interrupciones=0
 	@contador= Thread.new { loop { tiempo += 1 } }
 	sleep(25)
 end


end