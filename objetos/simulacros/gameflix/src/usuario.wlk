class Usuario{
    var suscripcion 
    var humor
    var dinero

    method reducirHumor(unaCantidad){
        humor -= unaCantidad
    }
    method aumentarHumor(unaCantidad) {
    humor += unaCantidad
  }
    method comprarSkinsPorMonto(unMonto){
        self.gastar(unMonto)
    }
    method gastar(unMonto) {
       dinero -= unMonto
    }

    method cambiarSuscripcionA(unaSuscripcion){
        suscripcion = unaSuscripcion
    }

    method saldoNegativo(unValor){
     return  dinero < unValor
    }

    method puedePagarLaSuscripcion(unaSuscripcion){
      return !self.saldoNegativo(unaSuscripcion.precio())
    }
      
    
    method pagarSuscripcion(){
      if(self.puedePagarLaSuscripcion(suscripcion)){
      self.gastar(suscripcion.precio())
      }else{
        self.cambiarSuscripcionA(prueba)
      }
    }

method buscarEn(unaPlataforma, unNombre){
  unaPlataforma.buscarJuegoPorNombre(unNombre)
}

method filtrarEn(unaPlataforma, unaCategoria){
  unaPlataforma.filltrarJuegosPor(unaCategoria)
}

method pedirRecomendacionA(unaPlataforma){
  unaPlataforma.recomendarJuego()
}

}

class SuscripcionPorCategoria {
    const categoria 
    const precio
    method precio() {
      return precio
    }
    method puedeJugarA(unJuego){
        return unJuego.esDecategoria(categoria)
    }
}
object base {
    
  method precio() = 25
  
  method puedeJugarA(unJuego){
    return unJuego.precio() < 30
  }
}

object premium  {
  method precio() = 50
  
  method puedeJugarA(unJuego){
    return true
  }
}

const infantil = new SuscripcionPorCategoria(categoria = "infantil", precio = 10)
const prueba = new SuscripcionPorCategoria(categoria = "demo", precio = 0)

class MeQuedeSinPlataException inherits Exception(message = "Me quede sin plata") {

}
