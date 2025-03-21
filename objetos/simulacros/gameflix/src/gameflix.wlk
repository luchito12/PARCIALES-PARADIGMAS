object gameflix {
const usuarios = #{}
const juegos = #{}

//pedirle a Gameflix que filtre los juegos de una categoría determinada
method filtrarJuegosPor(unaCategoria){
   return juegos.filter({unJuego => unJuego.perteneceACategoria(unaCategoria)})
}

//busque un juego por su nombre si es que se encuentra dentro de la colección
//(de lo contrario, se deberá notificar adecuadamente)
method buscarJuegoPorNombre(unNombre){
    return juegos.findOrElse({unJuego => unJuego.seLlama(unNombre)},  { throw new NoExisteElJuegoException(nombreDeJuego = unNombre)})
}

//ecomiende un juego al azar de su librería
method recomendarJuego() {
    return juegos.anyOne()
  }

//Gameflix cobrará el costo de la suscripción a sus clientes
method cobrarSuscripciones(){
usuarios.forEach({unUsuario => unUsuario.pagarSuscripcion()})
}

}

class NoExisteElJuegoException inherits Exception(message = "¡No existe el juego " + nombreDeJuego + "!") {
  const nombreDeJuego
}
