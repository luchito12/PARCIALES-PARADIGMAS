import familia.*
/*Don: La cabeza de la familia. No suele ensuciarse las manos utilizando sus armas, prefiere darle la                                 
orden a alguno de sus subordinados, que pueden ser subjefes o soldados. Don Vito, Don de la                                 
familia Corleone, al ordenarle a un subordinado a atacar, le da tanto coraje que éste ataca dos veces*/
class Don {

	const property subordinados = #{}

	method sabeDespacharElegantemente(unaPersona) {
		return true
	}

	method atacar(unAtacante, unAtacado) {
		subordinados.anyOne().atacarIntegrante(unAtacado)
	}
	
	method esSoldado() {
		return false
	}
	
	method subordinadoMasLeal() {
		return subordinados.max { subordinado => subordinado.lealtad() }
	}

}

/*Subjefe: Segundo al mando. Cada vez que tiene que usar un arma, usa una distinta. Tiene por                                 
subordinados a algunos de los miembros de la familia*/
class Subjefe {

	const property subordinados = #{}

	method sabeDespacharElegantemente(unaPersona) {
		return subordinados.any{ subordinado => subordinado.tieneArmaSutil() }
	}

	method atacar(unAtacante, unAtacado) {
		unAtacante.armaCualquiera().usarContra(unAtacado)
	}

	method esSoldado() {
		return false
	}

}

/*Soldado: Obedientes y de comprobada honradez, son la mano de obra de la organización. Cada uno                               
empieza con una escopeta de regalo, pero luego puede obtener más armas. No tiene subordinados.                             
Para "trabajar", usa siempre el arma que tiene más a mano*/
class Soldado {

	method sabeDespacharElegantemente(unaPersona) {
		return unaPersona.tieneArmaSutil()
	}

	method atacar(unAtacante, unAtacado) {
		unAtacante.armaMasCercana().usarContra(unAtacado)
	}

	method esSoldado() {
		return true
	}
	
	method subordinados() {
		return #{}
	}

}

object donCorleone inherits Don {	
	override method atacar(unAtacante, unAtacado) {
		super(unAtacante, unAtacado)
	}
}