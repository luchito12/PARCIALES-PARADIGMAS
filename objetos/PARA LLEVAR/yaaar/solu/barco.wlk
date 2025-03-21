
class BarcoPirata{
    const tripulantes = []
    var mision
    const capacidad
    
    method esTemible(){
        mision.puedeSerCompletada(self)
    }
  
    method tieneSuficienteTripulacion(){
        return tripulantes.size() >= capacidad * 0.9
    }
    method hayTripulanteCon(unItem){
        return tripulantes.any({unTripulante => unTripulante.tieneUnItem(unItem)})
    }
    

    method sosSaqueablePor(unPirata) {
		return unPirata.pasadoDeGrog()
	}
    method cantidadTripulantes() {
		return tripulantes.size()
	}
    method esVunerableA(unBarco){
        self.cantidadTripulantes() <= unBarco.cantidadTripulantes() / 2
    }

    method tripulacionPasadaDeGrog(){
        tripulantes.all({unTripulante => unTripulante.estaPasadoDeGrog()})
    }


    method tieneLugar(){
       return capacidad < tripulantes.size()
    }
    method mision() = mision

    method añadir(unPirata){
        if(unPirata.puedoFormarParteDeTripulacionBarco(self)){
            tripulantes.add(unPirata)
        }
    }

    method cambiarMision(unaMision) {
      mision = unaMision
      tripulantes.removeAllSuchThat { tripulante => unaMision.esUtil(tripulante).negate() }
		
    }

    method pirataMasEbrio() {
		return tripulantes.max { tripulante => tripulante.nivelEbriedad() }
	}

  	method anclarEn(unaCiudad) {
		self.todosTomanGrog()
		self.perderMasEbrioEn(unaCiudad)
	}
	
	method todosTomanGrog() {
		tripulantes.forEach { tripulante => tripulante.tomarGrog() }
	}
	
	method perderMasEbrioEn(unaCiudad) {
		tripulantes.remove(self.pirataMasEbrio())
		unaCiudad.sumarHabitante()
	}
	

    method tripulantesPasadosDeGrog() {
		return tripulantes.filter { tripulante => tripulante.estaPasadoDeGrog() }
	}

    	method cantidadItemsDistintosEntreTripulantesPasadosDeGrog() {
		return self.tripulantesPasadosDeGrog().flatMap { tripulante => tripulante.items() }.asSet().size()
	}

    method tripulantePasadoDeGrogConMasMonedas() {
		return self.tripulantesPasadosDeGrog().max { tripulante => tripulante.dinero() }
	}

//PUNTO 6
	/*Cada tripulante conoce qué tripulante del barco lo invitó. Se quiere conocer quién es el                             
tripulante de un barco pirata que invitó (satisfactoriamente) a más gente.*/
	method tripulanteMasInvitador() {
		return tripulantes.max { tripulante => tripulante.cantidadInvitadosPara(self) }
	}
	
	method cantidadInvitadosPor(unTripulante) {
		return tripulantes.count { tripulante => tripulante.fuisteInvitadoPor(unTripulante) }
	}

	
}

class Mision {
	method esRealizablePor(unBarco) {
		return unBarco.tieneSuficienteTripulacion()
	}
}


class BusquedaDelTesoro inherits Mision{

  method puedeSerCompletada(unBarco){
    unBarco.hayTripulanteCon("llave del cofre")
  }
  method esUtil(unPirata) {
    unPirata.dinero() <= 5 && self.tieneItemsNecesariosMision(unPirata)
  }
  method tieneItemsNecesariosMision(unPirata){
    return ['brújula', 'mapa', 'grogXD'].any { item =>  unPirata.tieneUnItem(item) }
  }
}
  


class ConvertirseEnLeyenda inherits Mision {
  const itemObligatorio 

  method itemObligatorio() = itemObligatorio
  
  method esUtil(unPirata) {
    unPirata.tengoUnaCantidadDeItems(10) && unPirata.tieneUnItem(itemObligatorio)
  }
}

class Saqueos inherits Mision {
    const victima

    var cantidadDeMonedasDeterminadas

    method puedeSerCompletada(atacante){
    return victima.esVunerableA(atacante)
  }
  method esUtil(unPirata){
    unPirata.dinero() < cantidadDeMonedasDeterminadas && victima.sosSaqueablePor(unPirata)
  }
  

}

class CiudadCostera {
    const habitantes = 0

  method esVunerable(unBarco) {
   return unBarco.cantidadTripulantes() >= 0.40 * habitantes || unBarco.tripulacionPasadaDeGrog()
  }
  method sosSaqueablePor(unPirata) {
		return unPirata.nivelDeEbriedad() >= 50
	}

method sumarHabitante() {
		habitantes + 1
	}
	

}