import personajes.*

object batalla {
	var equipo1 = [pamela, toro]
	var equipo2 = [tulipan, pocardo]
	
	method equipo1() = equipo1
	method equipo2() = equipo2
	
	method batallar() {
		self.duelo(equipo1, equipo2)
		self.duelo(equipo2, equipo1)
	}
	
	method duelo(unEquipo, otroEquipo) {
		unEquipo.forEach({ personaje => self.personajeLuchaContraEquipo(personaje, otroEquipo) })	
	}
	
	method personajeLuchaContraEquipo(personaje, equipo) {
		equipo.forEach({ otroPersonaje => personaje.luchar(otroPersonaje)})
	}
	
	method ganadores() {
		if (self.energiaDe(equipo1) > self.energiaDe(equipo2)) {
			return equipo1
		} else {
			return equipo2
		}
	}
	
	method energiaDe(equipo) = equipo.sum({ personaje => personaje.energia() })
	
	method sobrevivientes(equipo) = equipo.filter({personaje => personaje.estaVivo()}) 
	
	method gritoGanador() = self.sobrevivientes(self.ganadores())
		.map({personaje => personaje.gritoDeVictoria()})
}