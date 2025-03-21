
object fiesta {
    var quienOrganiza = mañic
  method estaLista(){
    quienOrganiza.tieneSuficientesGlobos() > 50 && quienOrganiza.tieneTodoListoParaLaFiesta()
  }
}



object mañic {
  var cantidadDeEstrellas = 0
  var globos = 0

  method encontrarEstrellas(){
    cantidadDeEstrellas += 8
  }

  method regalarEstrellas(){
    cantidadDeEstrellas = 0.max(cantidadDeEstrellas - 1)
  }

  method tieneTodoListoParaLaFiesta(){
    return cantidadDeEstrellas >= 4
  }

 method tieneSuficientesGlobos() = globos > 50

 method comprarGlobos(unaCantidad){
    globos += unaCantidad
  }


}


object chuy {
    var globos = 0
 method tieneTodoListoParaLaFiesta() {
  return true 
} 
 method tieneSuficientesGlobos() = globos > 50

 method comprarGlobos(unaCantidad){
    globos += unaCantidad
  }

}


object capi{
    var globos = 0
    var cantidadDeLatas  = 0

 method recolectarLatas(){
 cantidadDeLatas += 1
 }

 method llevarARecliclar() {
  cantidadDeLatas = 0.max(cantidadDeLatas - 5)
 }

 method tieneTodoListoParaLaFiesta() {
  return cantidadDeLatas.even()
 }

 method tieneSuficientesGlobos() = globos > 50

 method comprarGlobos(unaCantidad){
    globos += unaCantidad
  }
}




