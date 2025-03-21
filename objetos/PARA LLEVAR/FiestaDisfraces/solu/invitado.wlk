import disfraz.*

class Invitado{
    var disfraz
    const edad
    const personalidad
    method edad() = edad
    method cambiarDisfraz(unDizfras){
        disfraz = unDizfras
    }
    method esSexy(){
        personalidad.esSexy(self)
    }
    method estaConforme(unaFiesta){
        return disfraz.puntaje(self, unaFiesta) > 10
    }
    method disfraz() = disfraz
    
    method tieneDisfraz(){
        return disfraz != null
    }
}

object alegre {
  method esSexy() = false
}

object taciturnas {
  method esSexy(unInvitado) = unInvitado.edad() < 30

}

class Cambiante{
    var personalidad
    method cambiarPersonalidad(unaPeronalidad){
        personalidad = unaPeronalidad
    }
    method esSexy(unInvitado) = personalidad.esSexy(unInvitado)
}

class Caprichoso inherits Invitado{
method tieneCantidadParLetrasNombreDisfraz(){
    return disfraz.nombre().even()
}

override method estaConforme(unaFiesta){
    return super(unaFiesta) && self.tieneCantidadParLetrasNombreDisfraz()
}

}


class Pretencioso inherits Invitado{

method estaEchoHace(){
    return new Date() - self.disfraz().fecha() 
}
    override method estaConforme(unaFiesta){
        return super(unaFiesta) && self.estaEchoHace() < 30
    }
}

class Numerologos inherits Invitado{
    var cifraADeterminar

    method cambiarMiCifra(unaCifra){
        cifraADeterminar = unaCifra
    }
    override method estaConforme(unaFiesta){
        return super(unaFiesta) && disfraz.puntaje(self, unaFiesta) == cifraADeterminar
    }
}