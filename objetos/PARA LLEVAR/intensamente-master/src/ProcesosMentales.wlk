class ProcesosMentales {

	const procesos = [liberacionDeRecuerdosDelDia]

	method aplicarSobre(unaPersona) {
		return self.procesosOrdenados().forEach { proceso => proceso.apply(unaPersona) }
	}

	method procesosOrdenados() {
		if (procesos.contains(liberacionDeRecuerdosDelDia)) {
			procesos.remove(liberacionDeRecuerdosDelDia)
			procesos.add(liberacionDeRecuerdosDelDia)
		}
		return procesos
	}
}

object asentamiento {
	method apply(unaPersona) {
		unaPersona.recuerdosDelDia().forEach { recuerdo => recuerdo.asentarse() }
	}
}

object profundizacion {
	method apply(unaPersona) {
		unaPersona
			.recuerdosDelDia()
			.filter { recuerdo => self.esRecuerdoProfundizable(unaPersona, recuerdo) }
			.forEach { recuerdo => recuerdo.memorizate() }
	}

	method esRecuerdoProfundizable(unaPersona, unRecuerdo) {
		return unaPersona.pensamientosCentrales().contains(unRecuerdo).negate() && unaPersona.emocion().niega(unRecuerdo)
	}
}

object controlHormonal {
	method apply(unaPersona) {
		if (self.hayDesequilibrioHormonal(unaPersona)) {
			unaPersona.disminuirFelicidadPorcentual(15)
			unaPersona.perderPensamientosCentralesMasAntiguos()
		}
	}

	method hayDesequilibrioHormonal(unaPersona) {
		return self.tienePensamientosCentralesEnMemoriaALargoPlazo(unaPersona) || self.mismaEmocionDominanteEnRecuerdosDelDia(unaPersona)
	}

	method tienePensamientosCentralesEnMemoriaALargoPlazo(unaPersona) {
		return unaPersona.pensamientosCentrales().intersection(unaPersona.memoriaLargoPlazo()).isEmpty().negate()
	}

	method mismaEmocionDominanteEnRecuerdosDelDia(unaPersona) {
		const emocion = unaPersona.recuerdosDelDia().anyOne().emocion()
		return unaPersona.recuerdosDelDia().all { recuerdo => recuerdo.emocion().equals(emocion) }
	}

}

object restauracionCognitiva {
	method apply(unaPersona) {
		unaPersona.aumentarFelicidad(100)
	}
}

object liberacionDeRecuerdosDelDia {
	method apply(unaPersona) {
		unaPersona.recuerdosDelDia().clear()
	}
}

class AsentamientoSelectivo {
	const palabraClave

	method apply(unaPersona) {
		self.recuerdosClave(unaPersona).forEach { recuerdo => recuerdo.asentarse() }
	}

	method recuerdosClave(unaPersona) {
		return unaPersona.recuerdosDelDia().filter { recuerdo => recuerdo.descripcion().contains(palabraClave) }
	}
}
