class Pelicula{
    const nombre 
    const elenco = []
    method nombre(){
        return nombre 
    }
    method presupuesto(){
       return self.sumatoriaDeSueldosElenco() + 0.7 * self.sumatoriaDeSueldosElenco()
    }
    method sumatoriaDeSueldosElenco(){
        return elenco.sum({unActor => unActor.sueldo()})

    }
    method recaudacion()= 1000000

    method ganacia() = self.recaudacion() - self.presupuesto()

    method integranteElenco() = elenco.size()

    method rodar(){
        elenco.forEach({unActor => unActor.actuar()})
    }

    method peliculaEconomica(){
        return self.presupuesto() < 500000
    }
}

class Accion inherits Pelicula{
    const vidriosRotos
    
    override method presupuesto(){
       return super() + 1000 * vidriosRotos
    }
     override method recaudacion() {
        return super() + 50000 * self.integranteElenco()
    }
}



class Drama inherits Pelicula{
    method cantidadLetraNombre() = nombre.size()
    override method recaudacion() {
        return super() + self.cantidadLetraNombre() * 100000
    }
}

class Terror inherits Pelicula{
    const cucho
    override method recaudacion(){
        return super() + 20000 * cucho
    }
}

class Comedia inherits Pelicula{

}