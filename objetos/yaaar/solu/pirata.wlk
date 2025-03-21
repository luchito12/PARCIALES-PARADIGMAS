import barco.*

class Pirata{
    const items =[]
    var nivelDeEbriedad
    var dinero
	var invitante



method dinero() = dinero
method items() = items
method tieneUnItem(unItem){
   return items.coteins(unItem)
}

method soyUtilPara(unaMision){
    return unaMision.esUtil(self)
}

method tengoUnaCantidadDeItems(unaCantidad){
    items.size() >= unaCantidad
}
method nivelDeEbriedad() = nivelDeEbriedad


 method estaPasadoDeGrog(){
        return nivelDeEbriedad >= 90
    }
method puedoFormarParteDeTripulacionBarco(unBarco){
    (unBarco.tieneLugar() && self.soyUtilPara(unBarco.mision()))
}

method podesSaquear(unaVictima){
    return unaVictima.sosSaqueablePor(self)
}

	method tomarGrog() {
		nivelDeEbriedad += 5
		self.gastarMoneda()
	}
	
	method gastarMoneda() {
		dinero - 1
	}

		method cantidadInvitadosPara(unBarco) {
		return unBarco.cantidadInvitadosPor(self)
	}
	
	method fuisteInvitadoPor(unTripulante) { 
		return invitante.equals(unTripulante)
	}

}

class PirataEspiaDeLaCorona inherits Pirata {
	override method estaPasadoDeGrog() {
		return false
	}

	override method podesSaquear(unaVictima) {
		return super(unaVictima) && self.tieneUnItem('permiso de la corona')
	}	
}