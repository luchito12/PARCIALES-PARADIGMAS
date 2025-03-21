object delfina {
  var diversion = 0
  var tieneEnLaMano = play
  //delfina entienda el mensaje diversion() que indica su nivel de diversión
  method diversion() = diversion

    method agarrar(unaConsola){
        tieneEnLaMano = unaConsola
    }
  method aumentarDiversion(unaCantidad){
    diversion += unaCantidad
  }

  //delfina entienda el mensaje jugar(videojuego).
  method jugar(unajuego){
    self.aumentarDiversion(unajuego.otorgar()) 
    tieneEnLaMano.usar()
    }
    method jugabilidadDeTuConsola() {
		return tieneEnLaMano.jugabilidad()
	}
}

object play {
    //Las consolas entiendan el mensaje jugabilidad() que indicacuánta jugabilidad otorga.
    const jugabilidad = 10
  method jugabilidad() = jugabilidad

  //Las consolas entiendan el mensaje usar() que provoca que la consola reciba un uso
  method usar() {

  }
  }


object portatil {
    var bateriaBaja = false

//Las consolas entiendan el mensaje jugabilidad() que indicacuánta jugabilidad otorga.
  method jugabilidad(){
    if(bateriaBaja){
        1
    }else{
        8
    }
  }

//Las consolas entiendan el mensaje usar() que provoca que la consola reciba un uso
  method usar(){
    bateriaBaja = true
  }
}


object arcanoid {
  method otorgar()= 50
}

object mario {
  method otorgar(unaJugabilidad){
    if(unaJugabilidad > 5){
        100
    }else{
        15
    }
  } 
}

object pokemon {
  method otorgar(unaJugabilidad) {
    return 10 * unaJugabilidad 
  }
}