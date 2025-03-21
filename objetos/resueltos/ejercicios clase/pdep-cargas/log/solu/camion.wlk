object verdurin {
  var cajonesQueLLeva = 10
  const pesoCajon = 50
  var kilometrajeActual = 700000
  const velocidadPunta = 80

    method cantidadDeCajones(unaCantidad) {
    cajonesQueLLeva= unaCantidad
  }

  method velocidadMaxima(){
    return velocidadPunta - self.carga().div(500)
  }
  method aumentarKilometraje(unaCantidad){
    kilometrajeActual += unaCantidad
  }
  method carga() {
    return pesoCajon * cajonesQueLLeva
  }
method recorrer(unosKilometros, _unaVelocidad) {
    self.aumentarKilometraje(unosKilometros)
  }
}


object scanion {
  var densidadLiquido = 1
  const capacidadMax = 5000
  
  method velocidadMaxima(){
    return 140
  }
   method densidad(unaDensidad) {
    densidadLiquido= unaDensidad
  }
  method carga() {
    return capacidadMax * densidadLiquido
  }
  method recorrer(unosKilometros, unaVelocidadMaxima){}
  

}

object cerealitas{
    var property cantidadCargada = 0 
    var nivelDeterioro = 0

    method aumentarNivelDeDeterioro(unaCantidad, unavelocidad){
        nivelDeterioro += (unavelocidad - 45).max(0)
    }

    method velocidadMaxima(){
        if(nivelDeterioro < 10){
            return 40
        }else{
            return 60 - nivelDeterioro
        }
    }
    method carga() = cantidadCargada

    method recorrer(unosKilometros, unaVelocidad){
        self.aumentarNivelDeDeterioro(unosKilometros, unaVelocidad)
    }
}

object rutatlantica {
  const precio = 7000

method tarifa(unCamion){
   return precio + 100 * unCamion.carga().div(100)
}

method efectoA(unCamion,unaEmpresa){
    unaEmpresa.cobrar(self.tarifa(unCamion))
    unCamion.recorrer(400, 75)
}

}

object pdepCargas {
    var dinero = 100000
    var gastos = 0
    method dineroDisponible() = dinero
    
    method cobrar(unaCantidad) {
    dinero -= unaCantidad
    gastos += unaCantidad
  }
}