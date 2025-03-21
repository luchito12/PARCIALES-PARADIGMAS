class Escapista{
    var maestria
    var saldoBilletera
    const salasQueEscapo = []

    method cambiarMaestria(nuevaMaestria) {
      maestria = nuevaMaestria
    }

    method puedeSalirDe(unaSala) = maestria.puedeSalir(unaSala, self)

   method hizoMuchasSalas(){
        return salasQueEscapo.size()> 6
    }

    method puedeSubirNivel(unEscapista){
        if(self.hizoMuchasSalas()){
            maestria.ascender(unEscapista)
        }
    }

    method salasQueEscapo(){
        return salasQueEscapo.map({unaSala => unaSala.nombre()}).asSet()
    }

    method pagarUnaSala(unaSala){
        saldoBilletera -= unaSala.precioFinal()
    }

    method pagar(unMonto){
        saldoBilletera -= unMonto
    }

    method puedePagar(unPrecio) = saldoBilletera >= unPrecio

    method dinero() = saldoBilletera

    method agregarSala(unaSala){
        salasQueEscapo.add(unaSala)
    }
}

object amateur {
  method puedeSalir(unaSala, unEscapista){
    return !unaSala.dificil() && unEscapista.hizoMuchasSalas()
  } 
  method ascender() = profecional
}

object profecional {
  method puedeSalir(unaSala, unEscapista)= true
  method ascender() = self
  
}

class Grupo{
    const escapistas = []
    method puedenEscapar(unaSala) = escapistas.any({unEscapista => unEscapista.puedeSalirDe(unaSala)})
    
    method ingresar(unaSala){
            self.verificarSiPuedenPagar(unaSala)
            self.pagarLaSala(unaSala)
            self.agregarSiEscapan(unaSala)
        
        
    }
    method agregarSiEscapan(unaSala){
        if(self.puedenEscapar(unaSala)){
            escapistas.forEach({unEscapista => unEscapista.agregarSala(unaSala)})
        }
    } 
    method precioSalaPorGrupo(unaSala) = unaSala.precioFinal() / escapistas.size()
    
    method pagarLaSala(unaSala){
        escapistas.forEach({unEscapista => unEscapista.pagar(self.precioSalaPorGrupo(unaSala))})
    }

    method todosPuedenPagar(unPrecio) = escapistas.all {unEscapista => unEscapista.puedePagar(unPrecio)}

method puedenPagar(unaSala){
    return  self.todosPuedenPagar(self.precioSalaPorGrupo(unaSala)) || self.sumaDeSaldosCubre(self.precioSalaPorGrupo(unaSala))
}

method sumaDeSaldosCubre(unPrecio) = escapistas.sum {unEscapista => unEscapista.dinero()} >= unPrecio

 method verificarSiPuedenPagar(unaSala) {
        if(!self.puedenPagar(unaSala)) {
            throw new DomainException(message = "No pueden pagar la sala, arafue")
        }
 }
}