class Sala{
    const nombre
    const dificultad
    const precio = 10000
    method precioFinal()
    method esDificil()= dificultad > 7

    method nombreSala() = nombre
    
}

class Anime inherits Sala{
    const extra = 7000
    override method precioFinal(){
        return precio + extra
    }
}
class Historia inherits Sala{
    const basadaEnEchosReales

    override method precioFinal() {
      return precio + (dificultad * 0.314)
    }

    override method esDificil() = super() && !basadaEnEchosReales
}

class Terror inherits Sala{
   
    const sustos 

    method haySuficientesSustos() = sustos > 5

    override method precioFinal() {
      return precio + self.valorAdicional()
    }
    method valorAdicional(){
        if(self.haySuficientesSustos()){
           return precio + (0.20 * sustos)
        }else {
            return 0 
        }
    }
    override method esDificil()= super() || sustos > 5
}