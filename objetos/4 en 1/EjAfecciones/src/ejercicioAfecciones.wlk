object sara {
	
	var property vitalidad = 90
	var property peso = 55
	var property temperatura = 37
	
	method esAfectadaPor(algo) {
		algo.afectarA(self)
	}
	
	method modificarTemperatura(cantidad) {
		temperatura += cantidad
	}
	
	method modificarVitalidad(cantidad){
		vitalidad += cantidad
	}
	
	method modificarPeso(cantidad) {
		peso += cantidad
	}
}

object malaria {
	
	method afectarA(persona){
		persona.modificarTemperatura(3)
	}
}

object varicela {
	
	method afectarA(persona) {
		persona.modificarVitalidad(-5)
		persona.modificarPeso(persona.peso()*(-0.1))
	}
}

object gripe {
	
	method afectarA(persona) {
		persona.modificarVitalidad(persona.vitalidad() *(-0.2))
	}
	
}

object paracetamol {
	method afectarA(persona) {
		if (persona.temperatura() > 37) {
			persona.temperatura(37)
		}
	}
}

object polen {
	var property gramos = 10
	method afectarA(persona) {
		persona.modificarVitalidad(gramos * 0.1)
	}
}

object nuez {
	method afectarA(persona) {
		persona.modificarVitalidad(persona.vitalidad() * 0.3)
	}
}