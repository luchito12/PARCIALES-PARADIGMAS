object superIntendencia{
const registro =[]
}

class Vehiculo{
    var poliza
    const siniestros =[]
    const nombre
    var cantidadDePasajeros

method montoNoCubierto(){
return siniestros.sum({unSiniestro => poliza.montoNoCubierto(unSiniestro, self)})
}

	method cuantoCubrePolizaEn(siniestro) {
		return poliza.cuantoCubreEn(siniestro, self)
	}
	

}


class Siniestro{

const danios = []
method danios() = danios

const vehiculosInvolucrados = []

method esta(unVehiculo){
  return vehiculosInvolucrados.coteins(unVehiculo)
}

method daniosPara(unVehiculo) {
		return self.daniosDel(unVehiculo).monto()
	}

method daniosDel(unVehiculo){
  return danios.find({unDanio => unDanio.involucrado() == unVehiculo})
}
}

class Danio {
	
	var  monto
  method monto() = monto
  method involucrado() = involucrado
	var  involucrado
}

class Poliza {
	var aseguradora
	
	method cuantoCubreEn(unSiniestro, unVehiculo) {
		return self.danios(unSiniestro, unVehiculo).sum({unDanio => unDanio.monto()})
	}
	
	method danios(unSiniestro, unVehiculo)
  method montoNoCubierto(unSiniestro, vehiculo)
}


class ContraTerceros inherits Poliza {

	override method danios(unSiniestro, unVehiculo) {
		return unSiniestro.danios().filter({unDanio => unDanio.involucrado()!= unVehiculo})
	}	
	
	override method montoNoCubierto(unSiniestro, vehiculo) = unSiniestro.daniosPara(vehiculo)
}

class ContraTodoRiesgo inherits Poliza {
	
	override method danios(unSiniestro, _) = unSiniestro.danios()
	
	override method montoNoCubierto(_, vehiculo) = 0	
	
}

class Aseguradora {
	method cuantoDebePagarPor(unSiniestro, unVehiculo) {
		self.validarSiEstaVehiculo(unSiniestro, unVehiculo)
		return unVehiculo.cuantoCubrePolizaEn(unSiniestro)		
	}
	
	
	method validarSiEstaVehiculo(unSiniestro, unVehiculo) {
		if (!unSiniestro.esta(unVehiculo)) {
			throw new NoParticipoVehiculo(message = "vehiculo no esta involucrado en el siniestro")
		}
	}
	
	
		
}

class NoParticipoVehiculo inherits DomainException {
}