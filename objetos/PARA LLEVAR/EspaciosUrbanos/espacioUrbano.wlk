class EspacioUrbano{
var valuacion
const superficie 
const nombre 
var tieneVallado
const trabajosRealizados = #{}

method esEspacioUrbanoGrande(){
    return superficie > 50
}

method esEspacioLimpliable() = false

method esEspacioVerde() = false

method aumentarValuacion(unaCantidad) {
		valuacion += unaCantidad
	}

method superfie()= superficie	
method esDeUsoIntensivo() {
		return self.cantidaDeTrabajosHeavies() > 5
	}
	
	method cantidaDeTrabajosHeavies() {
		return self.trabajosRealizadosHeavies().size()
	}
	
	method trabajosRealizadosHeavies() {
		return trabajosRealizados.filter({unTrabajo => unTrabajo.esHeavy()})
	}
}


class Plaza inherits EspacioUrbano{
    const cantidadDeCanchas

override method esEspacioUrbanoGrande(){
    return super() && cantidadDeCanchas > 2
}

override method esEspacioVerde(){
    return cantidadDeCanchas == 0
    }

override method esEspacioLimpliable() = true
}

class Plazoleta inherits EspacioUrbano{
const procer
method elProcerEsSanMartin(){
    return procer == "san martin" 
}

override method esEspacioUrbanoGrande(){
    return super() && self.elProcerEsSanMartin() && tieneVallado
}

}

class Anfiteatro inherits EspacioUrbano{
const capacidad 

override method esEspacioUrbanoGrande(){
    return super() && capacidad > 500
}

override method esEspacioLimpliable() = self.esEspacioUrbanoGrande()


}
class Multiespacio inherits EspacioUrbano{
    const espaciosUrbanos = []
    override method esEspacioUrbanoGrande(){
       return espaciosUrbanos.all({unEspacio => unEspacio.esEspacioUrbanoGrande()})
    }

    override method esEspacioVerde(){
        return espaciosUrbanos.size()>3
    }
    
}