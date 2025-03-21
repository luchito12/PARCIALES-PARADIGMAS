/*revólver​: ningún honesto miembro de ninguna familia sale sin él. Muy confiable, mata de un disparo,                               
pero siempre y cuando le queden balas. A veces, se olvidan de recargarlo y en el momento de la                                     
verdad resulta inofensivo. Como es de esperar, cada disparo gasta una bala.*/
class Revolver {

	var cantidadBalas

	method esSutil() {
		return cantidadBalas == 1
	}

	method usarContra(unaPersona) {
		if (self.estaCargada()) {
			unaPersona.morir()
			cantidadBalas -1		
		}
	}
	
	method estaCargada() {
		return cantidadBalas > 0
	}

}

//cuerda de piano: ​Si es de buena calidad, lo mata instantáneamente.
class CuerdaDePiano {

	const esDeBuenaCalidad

	method esSutil() {
		return true
	}
	
	method usarContra(unaPersona) {
		if (esDeBuenaCalidad) {
			unaPersona.morir()			
		}
	}

}

/*escopeta: hiere a la víctima, dándole tiempo para implorar por su vida e hijos. Pero si la víctima ya                                     
estaba herida, la mata. */
class Escopeta {

	method esSutil() {
		return false
	}

	method usarContra(unaPersona) {
		unaPersona.herir()
	}

}