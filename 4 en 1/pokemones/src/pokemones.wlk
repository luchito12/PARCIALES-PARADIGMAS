object ash {
	
	const property pokemones = []
	
	method esGroso() = 	pokemones.all({unPokemon => unPokemon.nivel() > 100})
	
	method pokemonPreferido() = pokemones.max({unPokemon => unPokemon.potenciaAtaqueMasPotente()})
	
	method pokemonesPulenta() = pokemones.filter({unPokemon => unPokemon.esPulenta()})
	
}


object charizard {
	
	var property tipo = "fuego"
	
	var property ataque = lanzallamas
	
	method nivel() = ataque.potencia()
	
	method aprender(unAtaque){
		ataque = unAtaque
	}
	
	method potenciaAtaqueMasPotente() = ataque.potencia()
	
	method esPulenta() = false
}

object pikachu {
	
	var property tipo  = "electrico"
	const property ataques = [agilidad, trueno, colaDeHierro]
	
	method nivel() = ataques.sum({unAtaque => unAtaque.potencia()})	
	
	method aprender(unAtaque) {
		ataques.add(unAtaque)
	}
	
	method potenciaAtaqueMasPotente() = ataques.max({unAtaque => unAtaque.potencia()}).potencia()
	
	method esPulenta() = ataques.size() > 2 && tipo == "agua"
	
}

object psyduck {
	
	var property tipo = "agua"
	
	method nivel() = 0
	
	method aprender(_) {
		
	}
	
	method potenciaAtaqueMasPotente() = 0
	
	method esPulenta() = false
}


object lanzallamas {
	var property potencia = 5
}

object agilidad {
	var property potencia = 6
}

object trueno {
	
	var property potencia = 8
}

object colaDeHierro {
	var property potencia = 7
}

object blastoise {
	var property tipo = "agua"
	
	var property ataquePrincipal = hidrobomba
	var property ataqueReserva = rayoDeHielo
	
	method nivel() = ataquePrincipal.potencia() + ataqueReserva.potencia()
	
	method aprender(unAtaque) {
		ataqueReserva = ataquePrincipal
		ataquePrincipal = unAtaque		
	}
	
	method potenciaAtaqueMasPotente() = ataquePrincipal.potencia().max(ataqueReserva.potencia())
	
	method esPulenta() = false
 }
 
 object hidrobomba {
 	var property potencia = 10
 }
 
 object rayoDeHielo {
 	var property potencia = 9
 }