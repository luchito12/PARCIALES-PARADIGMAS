class Trabajador{
var valorHora = 1000
var profesion

method realizoTrabajoHeavy(trabajo) {
		return profesion.esHeavy(trabajo)
	}
	method trabajaEn(espacioUrbano) {
		profesion.trabajaEn(espacioUrbano, self)
	}	
}


class Profesion{
method puedeRealizarTrabajoEn(unEspacio)
method producirEfecto(espacioUrbano)
method duracionTrabajo(espacioUrbano)

	
method costoTrabajo(espacioUrbano, trabajador) {
	return trabajador.valorHora() * self.duracionTrabajo(espacioUrbano)
		
	}
method trabajaEn(espacioUrbano, trabajador) {
		self.validarTrabajoEn(espacioUrbano)
		self.producirEfecto(espacioUrbano)
		self.registrarTrabajo(espacioUrbano, trabajador)
		}
		
	method validarTrabajoEn(unEspacioUrbano) {
		if(!self.puedeRealizarTrabajoEn(unEspacioUrbano)) {
			throw new TrabajoIncompatible(message= "no puede realizar dicho trabajo")
		}
	}
method registrarTrabajo(espacioUrbano, trabajador) {
		espacioUrbano.agregarTrabajo(self.trabajoRealizado(espacioUrbano, trabajador))
	}

    	method trabajoRealizado(espacioUrbano, trabajador) {
		return new Trabajo(persona = trabajador, duracion = self.duracionTrabajo(espacioUrbano), costo  = self.costoTrabajo(espacioUrbano, trabajador))
	}

    
	method esHeavy(trabajo) {
		return trabajo.costo() > 10000
	}
}
class Cerrajero inherits Profesion{

override method puedeRealizarTrabajoEn(unEspacio){
    return !unEspacio.tieneVallado()
}

override method producirEfecto(espacioUrbano) {
		espacioUrbano.tieneVallado(true)
	}
    override method duracionTrabajo(espacioUrbano){
        if(espacioUrbano.esGrande()) {
         return 5
        }else{
          return 3  
        }
    }
    override method esHeavy(trabajo){
       return super(trabajo) && trabajo.duracion() > 5
    }

}

class Jardinero inherits Profesion{
override method puedeRealizarTrabajoEn(unEspacio){
    return unEspacio.esEspacioVerde()
}

override method producirEfecto(espacioUrbano) {
		espacioUrbano.aumentarValuacion(espacioUrbano.valuacion() *0.1)
	}

    override method duracionTrabajo(espacioUrbano){
        return espacioUrbano.superfie()/10
    }
override method costoTrabajo(espacioUrbano, trabajador) = 2500
}

class Encargado inherits Profesion{

override method puedeRealizarTrabajoEn(unEspacio){
    return unEspacio.esEspacioLimpliable()
}

override method producirEfecto(espacioUrbano) {
		espacioUrbano.aumentarValuacion(5000)
	}

    override method duracionTrabajo(espacioUrbano){
        return 8
    }

}

class Trabajo {
	
	var property fecha = new Date()
	var property duracion
	var property persona
	var property costo
	
	method esHeavy() = persona.realizoTrabajoHeavy(self) 
}

class TrabajoIncompatible inherits DomainException {}