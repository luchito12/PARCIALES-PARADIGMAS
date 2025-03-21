object centralAtomicaBurns{
   var varillasDeUranio = 1

    method produccion(unaCiudad){
        return 0.1 * varillasDeUranio
    }
    method esContaminante(){
        return varillasDeUranio> 20
    }
}

object  centralDeCarbon {
    const capacidadToneladas = 1 

  method produccion(unaCiudad){
    return 0.5 + capacidadToneladas * unaCiudad.riquesaSuelo()
  }

  method esContaminante(){
    return true
  }
}

object centraEolica {
    const turbinas = []
  method produccion(unaCiudad){
    return  turbinas.sum({turbina => turbina.produccionTurbina(unaCiudad)})
  }

  method esContaminante(){
    return false
  }
}

object turbina{
	method produccionTurbina(unaCiudad) {
		return 0.2 * unaCiudad.fuerzaDeVientosQueSoplan() 
	}

}

object centralHidroElectrica {
  method produccion(unaCiudad){
    unaCiudad.caudalRio() * 2
  }
}