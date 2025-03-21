import plato.*
import cocinero.*

class Torneo{
    const platosParticipantes = []
    const catadores = []
// Punto 6a: Hacer que un cocinero participe en un torneo: al participar cocina y presenta su plato al torneo.  
method agregarParticipante(unCocinero) {
		platosParticipantes.add(unCocinero.cocinar())
	}


// Punto 6b: Encontrar el cocinero ganador del torneo, que es aquél que haya presentado el plato que obtiene la mayor puntuación del torneo (la suma de las calificaciones individuales de cada catador). 
	//           Cuidado: si no se presenta ningún cocinero al torneo, no se puede establecer al ganador. 


method hayParticipantes() {
		return !platosParticipantes.isEmpty()
	}
    
method encontrarGanador(){
    if(self.hayParticipantes()){
        self.platoConMejorPuntaje().responsableDePlato()
    }else{
    throw new UserException(message = "No se puede encontrar un ganador, ya que no hay participantes!")

    }
}

method platoConMejorPuntaje() {
		return platosParticipantes.max({unPlato => self.puntajeTotalDeUnPlato(unPlato)})
	}    
method puntajeTotalDeUnPlato(unPlato) {
		return catadores.sum({unCatador => unCatador.catar(unPlato)})
	}
    
    }

    class UserException inherits wollok.lang.Exception {}
