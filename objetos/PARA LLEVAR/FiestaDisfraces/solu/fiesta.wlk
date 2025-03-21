class Fiesta{
    const lugar 
    const invitados=[]
    const fecha
    method fecha()= fecha 

method esUnBordio(){
    invitados.forEach({unInvitado => !unInvitado.estaConforme(self)})
}

method mejorDisfraz(){
    invitados.max({unInvitado => unInvitado.puntaje(unInvitado, self)})
}
method puedenIntercambiarTrajes(unInvitado,otroInvitado){
    return self.estanEnLafiesta(unInvitado, otroInvitado) && self.algunoDisconforme(unInvitado, otroInvitado) && self.estanLos2conformes(unInvitado, otroInvitado)
}

method algunoDisconforme(unInvitado, otroInvitado){
return !unInvitado.estaConforme(self) ||  !otroInvitado.estaConforme(self)
}

method estanLos2conformes(unInvitado, otroInvitado){
    self.intercambioDeDisfraces(unInvitado, otroInvitado)
    return unInvitado.estaConforme(self) && otroInvitado.estaConforme(self)
}
method intercambioDeDisfraces(unInvitado, otroInvitado) {
		const disfrazInvitado = unInvitado.disfraz()
		unInvitado.cambiarDisfraz(otroInvitado.disfraz())
		otroInvitado.cambiarDisfraz(disfrazInvitado)
		
		
	}


method estanEnLafiesta(unInvitado, otroInvitado){
return self.estaEnLaFiesta(unInvitado) && self.estaEnLaFiesta(otroInvitado)
}

method estaEnLaFiesta(unInvitado){
return invitados.conteins(unInvitado)
}


method agregarAsistente(unAsistente){
    if(unAsistente.tieneDisfraz(unAsistente) && !self.estaEnLaFiesta(unAsistente)){
        invitados.add(unAsistente)
    }
}


}

object fiestaInovildable{
    const invitados = []
    
	method cumpleCondiciones(unInvitado) {
		return unInvitado.esSexy() && unInvitado.estaConforme(self)
	}

}