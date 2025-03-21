/*La empresa cuenta con una numerosa cantidad de usuarios registrados y trabaja con varias empresas de
telecomunicaciones del mercado (tanto Nacionales como Extranjeras). Su negocio consiste en ofrecer a los
clientes descargas de contenidos pagos para celulares que pueden ser: ringtones, juegos y chistes*/

/*Por cada descarga, la empresa le cobra un monto determinado al usuario que se calcula sumando lo siguiente:
● El monto por derecho de autor.
● Lo que cobra la compañía de telecomunicaciones del usuario. Las nacionales cobran un 5% del monto por
derecho de autor. Las extranjeras, además de cobrar lo que cobra una nacional, cobran un impuesto por la
prestación, que es igual para todas las compañías extranjeras y debe ser fácilmente configurable.
● Lo que gana la empresa de comercialización de contenidos para celulares (25% del monto por derecho de
autor).*/
object empresaDeContenidos {
	const usuarios = #{}
	
	method cuantoCobra(contenido, usuario) {
		const montoDerechoDeAutor = contenido.montoPorDerechoDeAutor()
		return  (montoDerechoDeAutor * (1 + usuario.recargoPorCompania()) + montoDerechoDeAutor * 0.25) * usuario.recargoPorPlan()
	}
	
	/*Obtener cuánto gastó en descargas de contenidos un cliente determinado en el mes actual*/
	method forzarDescarga(contenido) {
		usuarios.forEach({usuario => usuario.descargar(contenido)})
	}
}


class Nacional {
	method recargo() {
		return 0.05
	}
}

class Extranjera inherits Nacional {
	var recargoExtranjero
	
	override method recargo() {
		return super() + recargoExtranjero
	}
}
