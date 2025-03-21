import empresa.*

/** First Wollok example */
class Usuario {
	var compania
	var plan
	const descargas = []
	
	method recargoPorCompania() {
		return compania.recargo()
	}
	
	method recargoPorPlan() {
		return plan.recargoPorPlan()
	}
	
	method descargar(contenido) {
		var costo = empresaDeContenidos.cuantoCobra(contenido, self)
		if (plan.tengoSaldoParaDescarga(costo)) {
			plan.cobrar(contenido)
			var descarga = new Descarga(contenido = contenido, fecha = new Date())
			descargas.add(descarga)
		}
		else {
			throw new Exception(message= "Saldo insuficiente")
		}
	}
	
	method cantidadDescargasDelMesActual() {
		return descargas.count({descarga => descarga.seDescargoEn(new Date())})
	}
	
	method descargasDeLaFecha(fecha) {
		return descargas
			.filter({descarga => descarga.seDescargoEn(fecha)})
			.map({descarga => descarga.contenido()})
	}
}


/*Registrar la descarga de un producto por un usuario determinado, lo cual sólo debe suceder si el usuario
puede hacerlo. Se debe poder registrar que se descargó una copia del producto por parte del cliente y la
fecha, que será la del día de hoy1. Para un usuario con plan prepago, debería decrementarse su saldo.
Para uno con plan facturado, en cambio, debería acumularse el monto gastado*/
class Descarga {
	var contenido
	var fecha
	
	method fueEnElMesActual(fechaSolicitada) {
		return fecha.month() == fechaSolicitada.month() && fecha.year() == fechaSolicitada.year()
	}
	
	method contenido() {
		return contenido
	}
}