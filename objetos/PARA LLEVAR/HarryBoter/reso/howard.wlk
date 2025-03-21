import casas.*
import bots.*


object hogwart {
    const casasActuales = [gryffindor, slytherin, ravenClaw, hufflepuff]
    const asignadorDeCasas = sombreroBot 

    method celebrarCeremoniaDeSeleccion(estudiante) {
        asignadorDeCasas.distribuir(estudiante, casasActuales)
    }
}