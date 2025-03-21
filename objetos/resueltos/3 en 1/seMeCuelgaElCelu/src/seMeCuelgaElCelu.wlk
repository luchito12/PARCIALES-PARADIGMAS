object celular {
	
	var property limiteRam = 1000
	
	const property aplicaciones = []
	
	var property bateria = 100

	method memoriaLibre() = limiteRam - self.memoriaOcupadaPorAplicaciones()	

	method cantDeBateria() = bateria - self.bateriaConsumidaPorMinuto()
	
	method memoriaOcupadaPorAplicaciones() {
		return aplicaciones.sum({unaAplicacion => unaAplicacion.memoriaOcupada()})
	}
	
	method bateriaConsumidaPorMinuto() {
		return aplicaciones.sum({unaAplicacion => unaAplicacion.gastoBateria()})
	}
	
}


object calculadora {
	var property memoriaOcupada = 10
	
	method gastoBateria() = 0
}

class Mensajeria {
	
	var property memoriaBase
	var property memoriaPorConversacion
	var property gastoBateriaPorConservacion = 1
	var property cantConversaciones
	
	method memoriaOcupada() = memoriaBase + (memoriaPorConversacion * cantConversaciones )
	
	method gastoBateria() = cantConversaciones
}


class Reproductor {
	
	var property cantMaxOcupada 
	var property memoriaOcupadaPorItem
	var property cantItems
	
	method memoriaOcupada() = cantMaxOcupada.min(cantItems*memoriaOcupadaPorItem)

	method gastoBateria() = 2	
}