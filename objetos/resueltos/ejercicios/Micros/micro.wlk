class Micro{
    const capacidadPasajerosParados
    const capacidadPasajerosSentados
    const volumen
    const pasajerosSubidos =[]
    method volumenMicro() = volumen

    method capacidadTotal() = capacidadPasajerosParados + capacidadPasajerosSentados
    
    method hayLugar(){
        return self.lugaresLibres() > 0
    }

    method quedanAsientosLibres(){
        return (capacidadPasajerosSentados  - self.cantidadDeAsientosOcupados() ) >= 0 
    }
    method cantidadDeAsientosOcupados(){
        return pasajerosSubidos.filter({unPasajero => unPasajero.estaSentado()}).size()
    }
    method lugaresLibres(){
        return self.capacidadTotal() - pasajerosSubidos.size()
    }

    method subirA(unPasajero){
        unPasajero.subirseA(self)
        pasajerosSubidos.add(unPasajero)
    }

    method esta(unPasajero){
        return pasajerosSubidos.conteins(unPasajero)
    }

    method bajarA(unPasajero) {
        if(self.esta(unPasajero)){
            pasajerosSubidos.remove(unPasajero)
        }else {
            throw new DomainException(message = "no está el pasajero en el micro")
        }

    }
}

class Persona{
const cualidad
const sentado //Bool

method estaSentado(){
    return sentado
}
method subirseA(unMicro){
    if(self.puedeSubirse(unMicro) && cualidad.aceptaIr(unMicro) ){
        unMicro.subirA(self)
    }else{
        throw new DomainException(message = "no puedo subir")
    }
    }

method puedeSubirse(unMicro){
    return unMicro.hayLugar()
}

}

object apurado {
  method aceptaIr() {
    return true
  }
}

object claustrofobicos{
    method aceptaIr(unMicro){
        return unMicro.volumenMicro() > 120
    }

}

object fiacas {
  method aceptaIr(unMicro){
    return unMicro.quedanAsientosLibres()
  }
}

class Moderados{
    const lugaresLibres
    method aceptaIr(unMicro){
        return unMicro.lugaresLibres() >= lugaresLibres
    }
}


