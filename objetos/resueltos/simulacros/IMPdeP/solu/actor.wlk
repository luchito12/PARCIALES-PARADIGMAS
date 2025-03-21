class Actor{
    var experiencia 
    const peliculasQueActuo = []
    var ahorros

    method cantidadDePelisActuadas(){
        return peliculasQueActuo.size()
    }

    method sueldo(){
        return experiencia.sueldo(self.nivelDeFama(), self.cantidadDePelisActuadas() )
    }
    
    method nivelDeFama(){
        return self.cantidadDePelisActuadas()/ 2
    }
method recategorizar(){
    experiencia = experiencia.recategorizar(self.nivelDeFama(), self.cantidadDePelisActuadas())
}

 
method incrementarAhorros(unaCantidad){
    ahorros += unaCantidad
}

method actuar(unaPelicula){
peliculasQueActuo.add(unaPelicula) 
self.incrementarAhorros(self.sueldo())
}


}

object amateur {
  method sueldo(_fama, _cantidadPelisQueActuo){
    return 10000
  }
  method recategorizar(_, cantidadDePelisActuadas){
    if(cantidadDePelisActuadas > 10){
        return establecido
    }else {
        return self
    }
    
  }

}


object establecido {
  method sueldo(fama, _){
    if(fama < 15){
      return  15000
    }else{
        return 5000 * fama
    }
  }
method recategorizar(nivelDeFama, _){
     if(nivelDeFama > 10){
        return estrella
    }else{
        return self
    }
}
}



object estrella {
  method sueldo(_, cantidadPelisQueActuo){
    return 30000 * cantidadPelisQueActuo
  }

method recategorizarA(_fama, _cantidadPeliculas) {
        throw new DomainException(message = "Ya sos la maquina pa")
    }

}