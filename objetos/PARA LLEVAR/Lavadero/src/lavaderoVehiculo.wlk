class Vehiculo {
	var property nivelSuciedad = 0
	
	method incrementarNivelSuciedad(cantidad) {
		nivelSuciedad += cantidad
	}
	
	method limpiar() {
		nivelSuciedad = 0
	}
	
}

class Paloma  {
	
	var property peso
	
	method ensuciar(vehiculo) {
		var cantEnsucia = peso * 0.3
		vehiculo.incrementarNivelSuciedad(cantEnsucia);
		peso -= cantEnsucia
	}
	
}


class Gaviota {
	
	var property cantPescados
	
	method ensuciar(vehiculo) {
		vehiculo.incrementarNivelSuciedad(cantPescados * 3)		
	}
}

class Ave  {
	
	var property cantEnsucia
	
	method ensuciar(vehiculo) {
		vehiculo.incrementarNivelSuciedad(cantEnsucia)
	}
	
}


class Bandada {
	const property aves = []
	var property formacion
	
	method ensuciarA(vehiculo) {
		
		formacion.ensuciar(vehiculo, aves)
	} 
	
	method agregarAve(unAve) {
		aves.add(unAve)
	}	
 	
 }
 
 class FormacionV {
 	
 	method ensuciar(vehiculo, aves) 
 	{
 		aves.forEach({unAve => unAve.ensuciar(vehiculo)})
 	}
 	 	
 }
 
  object formacionW inherits FormacionV {
  	
  	
  	override method ensuciar(vehiculo, aves) {
  		
  		2.times({_ => super(vehiculo, aves)})
  	}
  
}


object formacionI {
	
	method ensuciar(vehiculo, aves ){
		aves.first().ensuciar(vehiculo)
		aves.last().ensuciar(vehiculo)
	}
}


object caba {
	var property vehiculos = []
	
	method agregarVehiculo(unVehiculo) {
		vehiculos.add(unVehiculo)
	}
	
	
}


class LluviaCeniza {
	
	var property cantMilimetros
	
	method caerSobre(lugar) {
		
		lugar.vehiculos().forEach({unVehiculo => unVehiculo.incrementarNivelSuciedad(cantMilimetros)})
	}
	
	}
	
	
class LavArtesanal {
	
	var property costoMinuto
	var property cantEmpleados
	
	method lavar(vehiculo) {
		
		var precio = self.precioPara(vehiculo)
		vehiculo.limpiar()
		return precio
		
	}	
	
	method precioPara(vehiculo) {
		return cantEmpleados * self.cantMinutos(vehiculo)* costoMinuto
	}
	
	method cantMinutos(vehiculo) {
		return vehiculo.nivelSuciedad()/5
	}
	
	
}















