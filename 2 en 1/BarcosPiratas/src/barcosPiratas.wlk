class BarcoPirata {
	
	var property mision
	const property tripulacion = #{}
	
	method piratasUtiles()  = tripulacion.filter({unPirata => mision.esUtil(unPirata)})
	
	
}

class Mision {
	
	method esUtil(unPirata)  {
		
		return unPirata.esIntrepido() && self.cumpleCondiciones(unPirata)
	}
	
	method cumpleCondiciones(unPirata)
}

object convertirseEnLeyenda inherits Mision {
	
	override method cumpleCondiciones(unPirata) = unPirata.cantItems() >= 10	
	
}

object busquedaDelTesoro inherits Mision {
	
	override method cumpleCondiciones(unPirata) {
		
		return unPirata.edad() <= 50 && (unPirata.tenes("brujula") || unPirata.tenes("botellaGrogXD"))
		
	} 
	
	}
	
class Saqueo inherits Mision {
	
	var property objetivo
	
	var property cantMonedas
	
	override method cumpleCondiciones(unPirata) = unPirata.dinero() < cantMonedas


	
}


class Pirata {
	
	const property items = []
	
	var property edad 
	var property temeMorir 
	
	var property dinero
	
	method cantItems() = items.size()
	
	method tenes(unItem) = items.contains(unItem)
	
	method esIntrepido() = edad < 40 && !temeMorir
	
}
