object tom {
    var energia = 80
    var posicion = 0
  method energia() = energia
  
method velocidad()= 5 + (energia /10)

method posicion() = posicion 

method esMasVeloz(unRaton)= self.velocidad() > unRaton.velocidad()

method modificarPosicion(unaPosicion){
    posicion = unaPosicion} 

method distancia(algo){
   return algo.posicion() - self.posicion()
}

method correrA(unRaton){
    energia -= 0.5 * self.velocidad() * self.distancia(unRaton)
    self.modificarPosicion(unRaton.posicion())
}

}

object jerry {
    var peso = 3
    var posicion = 10

method peso(cantidad) {
		peso = cantidad
	}
method velocidad()= 10 - peso
method posicion() = posicion  
  
}

object robotRaton {
    var posicion = 12
    const velocidad = 8

method velocidad() = velocidad
method posicion()= posicion
}