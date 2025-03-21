/*Cuando Rick se va de aventuras su nivel de demencia se altera en base a su acompañante
y además, este último siente los efectos de la aventura. Si no puede irse, entonces su
demencia aumenta en 1000 unidades*/

class Rick{
    var nivelDeDemencia
    const puedeIrseDeAventura
    method irseDeAventuras(unfamiliar){
        if(puedeIrseDeAventura){
            unfamiliar.irseDeAventura(self)
        }else{
            self.modificarDemencia(1000)
        }
        
    }

    method modificarDemencia(unaCantidad){
        nivelDeDemencia += unaCantidad
    }
}

/*Morty: Cuando se va de aventuras, su salud mental disminuye en 30 unidades y la
demencia de Rick aumenta en 50.*/
class Morty{
    var saludMental
    method irseDeAventura(unRick) {
      self.disminuirSaludMental(30) 
      unRick.modificarDemencia()
    }
    method disminuirSaludMental(unaCantidad){
        saludMental -= unaCantidad
    }

}


/*● Beth: Cuando va en una aventura se siente más querida por el padre (Rick),
aumentando el afecto por el padre en 10 unidades y disminuyendo la demencia de
Rick en 20 unidades.*/
class Beth {
 var nivelAfectoPaterno
 method irseDeAventura(unRick){
    self.aumentarAfectoPorPapa(10)
    unRick.modificarDemencia(20)
 }

 method aumentarAfectoPorPapa(unaCantidad){
    nivelAfectoPaterno += unaCantidad
 }
 
}

/*● Summer: puede ir de aventura si es lunes1, al ir de aventura le ocurre lo mismo que
a Beth (si bien Rick no es su padre, sí se siente más querida por él, que es su
abuelo).*/
class Summer inherits Beth{

 override method irseDeAventura(unRick) {
    if (self.esLunes()) {
      super(unRick)
    } else {
      throw new SoloPuedoIrmeDeAventurasLosLunesException()
    }
  }

 method esLunes() {
    return new Date().dayOfWeek() == "monday"
  }

}

/*● Jerry: no puede ir de aventuras.*/
object jerry {
    method irseDeAventura(unRick) {
    throw new NoPuedoIrmeDeAventurasException(message = "¡No puedo irme de aventuras!")
  }
}

class NoPuedoIrmeDeAventurasException inherits Exception {

}

class SoloPuedoIrmeDeAventurasLosLunesException inherits NoPuedoIrmeDeAventurasException(message = "¡Sólo me puedo ir de aventuras los lunes!") {

}

