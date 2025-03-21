import usuario.*

class Juego{
    const nombre 
    const precio
    const categoria 

    method precio() = precio
    
    method esDeCategoria(unaCategoria){
        return unaCategoria == categoria
    } 
    method seLlama(unNombre) {
    return unNombre == nombre
  }
    method afectarA(unCliente, unasHoras)
}


//Los juegos violentos reducen el humor en 10 unidades por cada hora jugada.
class Violento inherits Juego{
override method afectarA(unCliente, unasHoras){
    unCliente.reducirHumor(10*unasHoras)
}
}

/*Cada vez que se juega un MOBA, se ve obligada a comprar skins para sus
personajes gastando $30 en total.*/
class Moba inherits Juego{
    override method afectarA(unCliente, _unasHoras){
    unCliente.comprarSkinsPorUnMonto(30)
    }
}

/*● Si juega a uno de terror, tira todo al *biiiiiiiiiip* y se pasa a la suscripción Infantil 🧸.
*/
class Terror inherits Juego{
    override method afectarA(unCliente, _unasHoras) {
      unCliente.cambiarSuscripcionA(infantil)
    }
}

/*● Los juegos estratégicos aumentan el humor en 5 unidades por cada hora jugada.*/
class Estrategia inherits Juego{
    override method afectarA(unCliente, unasHoras){
        unCliente.aumentarHumor(5*unasHoras)
    }
}