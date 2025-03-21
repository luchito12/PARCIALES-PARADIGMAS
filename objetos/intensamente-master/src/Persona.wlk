import Recuerdo.*
import ProcesosMentales.*

object riley {

	/** Constantes **/

	const property recuerdosDelDia = []
	const property memoriaLargoPlazo = []

	/** Atributos **/

	var edad = 12
	var emocion = 1
	var nivelFelicidad = 1000
	var procesosMentales = new ProcesosMentales()
	var pensamientoActual = 1
	var recuerdosCentrales = #{}


	/** Getters **/

	method edad() = edad
	method emocion() = emocion
	method nivelFelicidad() = nivelFelicidad
	method procesosMentales() = procesosMentales
	method pensamientoActual() = pensamientoActual


	/** Punto 1 **/

	method vivirUnEvento(unaDescripcion) {
		recuerdosDelDia.add(new Recuerdo(descripcion = unaDescripcion, emocion = emocion, propietario = self))
	}


	/** Punto 2 **/

	method centralizar(unRecuerdo) {
		recuerdosCentrales.add(unRecuerdo)
	}

	method disminuirFelicidadPorcentual(unPorcentaje) {
		nivelFelicidad -= nivelFelicidad * unPorcentaje / 100
		self.validarNivelFelicidad()
	}

	method validarNivelFelicidad() {
		if (nivelFelicidad < 1) {
			throw new Exception(message = 'La felicidad de la persona está muy baja')
		}
	}


	/** Punto 3 **/

	method recuerdosRecientes() {
		return recuerdosDelDia.take(5)
	}


	/** Punto 4 **/

	method pensamientosCentrales() {
		return recuerdosCentrales.asSet()
	}


	/** Punto 5 **/

	method recuerdosDificilesDeExplicar() {
		return self.pensamientosCentrales().filter { recuerdo => recuerdo.esDificilDeExplicar() }
	}


	/** Punto 6 **/

	method niegaAlgunRecuerdo() {
		return recuerdosDelDia.any { recuerdo => emocion.niega(recuerdo) }
	}


	/** Punto 7 **/

	method dormir() {
		return procesosMentales.aplicarSobre(self)
	}

	method memorizate(unRecuerdo) {
		memoriaLargoPlazo.add(unRecuerdo)
	}

	method perderPensamientosCentralesMasAntiguos() {
		recuerdosCentrales = recuerdosCentrales.sortBy { recuerdo1, recuerdo2 => recuerdo1.fecha() > recuerdo2.fecha() }.drop(3)
	}

	method aumentarFelicidad(unaCantidad) {
		nivelFelicidad = 1000.min(nivelFelicidad + unaCantidad)
	}


	/** Punto 8 **/

	method rememorarRecuerdo() {
		pensamientoActual = memoriaLargoPlazo.find { recuerdo => recuerdo.esAntiguo() }
	}


	/** Punto 9 **/

	method cantidadRepeticiones(unRecuerdo) {
		return memoriaLargoPlazo.count { recuerdo => recuerdo.equals(unRecuerdo) }
	}


	/** Punto 10 **/

	method tieneUnDejaVu() {
		return self.cantidadRepeticiones(pensamientoActual) >= 2
	}

}

