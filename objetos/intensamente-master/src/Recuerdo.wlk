class Recuerdo {

	/** Constantes **/

	const property descripcion
	const property propietario
	const property emocion
	const property fecha = new Date()


	/** Punto 2 **/

	method asentarse() {
		emocion.asentarA(self)
	}

	method propietarioFeliz() {
		return propietario.nivelFelicidad() > 500
	}

	method centralizarse() {
		propietario.centralizar(self)
	}

	method disminuirFelicidadPorcentual(unPorcentaje) {
		propietario.disminuirFelicidadPorcentual(unPorcentaje)
	}


	/** Punto 5 **/

	method esDificilDeExplicar() {
		return descripcion.words().count() > 10
	}


	/** Punto 5 **/

	method esAlegre() {
		return emocion.esAlegre()
	}


	/** Punto 7 **/

	method memorizate() {
		propietario.memorizate(self)
	}


	/** Punto 8 **/

	method esAntiguo() {
		return fecha.year() < new Date().year() - propietario.edad() / 2
	}

}
