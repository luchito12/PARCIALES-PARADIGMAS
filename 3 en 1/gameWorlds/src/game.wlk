class Jugador {
	
	var property antiguedad = 0
	var property competenciasInternacionales = 0
	var property nivelCansancio = 0
	
	method esTitular() = antiguedad > 3
	
	method puedeJugar() = self.esTitular() && self.tieneExperiencia()
	
	method tieneExperiencia() = competenciasInternacionales > 2	
	
	method tomarBebidasEnergizante(cantidad) {
		nivelCansancio = (nivelCansancio - cantidad*10).max(0)
	}
	
	method jugar() {
		nivelCansancio += 20
	}
	
	method habilidad()= (antiguedad * 2 + competenciasInternacionales * 3 - nivelCansancio).max(0)
}

// WKO
object faker {
	var property tilteado = false
	var property habilidad = 0
	
	method tomarTecito() {
		tilteado = false
	}
	
	method puedeJugar() = tilteado.negate()
	
	method jugar() {
		habilidad += 50		
	}
	
	method habilidad() = if (tilteado) 0 else habilidad
	
}

class Equipo {
	const jugadores = #{}
	
	method contratarJugador(unJugador){
		jugadores.add(unJugador)
	}
	
	method disponibles() {
		return jugadores.filter({unJugador => unJugador.puedeJugar()})
	}
	
	method jugar() {
		self.disponibles().forEach({unJugador => unJugador.jugar()})
	}
	
	method habilidad() = jugadores.sum({unJugador => unJugador.habilidad()})
}


class Partida {
	const participantes = #{}
	
	method agregarParticipante(unParticipante) {
		participantes.add(unParticipante)
	}
	
	method comenzar() {
		participantes.forEach({unParticipante => unParticipante.jugar()})
	}
	
	method ganador() {
		return participantes.max({participante => participante.habilidad()})
	}
	
	
	
	
}

