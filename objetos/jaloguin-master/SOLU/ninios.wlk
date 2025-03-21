class Ninio {
    const elementosQueLLeva = []
    var salud = sano
    var actitud = 1
    var caramelos = 0
  

    method capacidadDeAsustar(){
        self.sumatoriaDeSustoDeElementosQueLLeva() * actitud
    }
    method sumatoriaDeSustoDeElementosQueLLeva(){
        return elementosQueLLeva.sum({unElemento => unElemento.susto()})
    }
    
    method recibirCaramelos(unaCantidad) {
      caramelos += unaCantidad
    }
    method intentarAsustar(unAdulto){
        unAdulto.serAsustadoPor(self)
    }
    method cantidadDeCaramelos(){
        return caramelos
    }
    method elementosQueLLeva(){
        return elementosQueLLeva
    }

    method comerCaramelos(unaCantidad) {
  	self.validarCantidadCaramelos(unaCantidad)
  	caramelos -= unaCantidad
  }
  
  method validarCantidadCaramelos(unaCantidad) {
  	if (unaCantidad < caramelos) {
  	  throw new ChicoException(message = 'No hay mas morfi')
  	}
  }

  method empachate() {
  	salud = empachado
  }

  method poneteEnCama() {
  	salud = cama
  }


}

class Maquillaje{
    var capacidadDeAsustar = 3
    method susto() = capacidadDeAsustar
}

class Traje{
const esTierno

method susto() {
  if(esTierno){
    return 2
  }else{
    return 5
  }
}
}

object sano {
	method actitud(unChico) = unChico.actitud()
	method comerCaramelos(unChico, unaCantidad) {
		if (unaCantidad > 10) unChico.empachate()
	}
}

object empachado {
	method actitud(unChico) = unChico.actitud() / 2
	method comerCaramelos(unChico, unaCantidad) {
		if (unaCantidad > 10) unChico.poneteEnCama()
	}
}

object cama {
	method actitud(unChico) = 0
	method comerCaramelos(unChico, unaCantidad) {
		throw new ChicoException(message = 'No puede comer más')
	}
}


class ChicoException inherits Exception {}
