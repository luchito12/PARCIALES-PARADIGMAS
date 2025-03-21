import howard.*

class Bot{
    var cargaElectrica
    var tipoAceite

    method tieneAceitePuro() = tipoAceite.sosPuro()
    method asignarCasa(casa) {}

    method disminuirEnergiaEn(valor) {
        cargaElectrica = (cargaElectrica - valor).max(0)
    }
    
    method estaActivo() = cargaElectrica > 0

    method cambiarAceite(nuevoAceite) {
        tipoAceite = nuevoAceite
    }
    method agotarEnergia() { 
        cargaElectrica = 0 
    }
}

class BotMago inherits Bot{
var casaActual
const hechizos = #{}
  override method asignarCasa(casa) {
        casaActual = casa
        casa.agregarEstudiante(casa)
    }

method esExperimentado(){
    return self.seSabeMasDeTresHechizos() && cargaElectrica > 50
}

method seSabeMasDeTresHechizos(){
   return hechizos.size() > 3
}

method aprenderHechizo(hechizo) {
        hechizos.add(hechizo)
    }
method asistirA(materia) {}

   method intentarLanzarHechizo(hechizo, hechizado) {
        if(not (self.cumpleCondicionBase(hechizo) && hechizo.cumpleRequisito(self)))
            self.error("No se pudo lanzar el hechizo")
        
        hechizo.sufriConsecuenciasA(hechizado)
    }   
    method cumpleCondicionBase(hechizo) = self.estaActivo() && self.tieneHechizo(hechizo)

    method tieneHechizo(hechizo) = hechizos.contains(hechizo)

    method lanzarUltimoHechizoA(hechizado) {
        const ultimoHechizo = hechizos.last()
        self.intentarLanzarHechizo(ultimoHechizo, hechizado)
    }

}


object aceitePuro {
    method sosPuro() = true
}

object aceiteSucio {
    method sosPuro() = false
}

class BotEstudiante inherits BotMago{
 override method asistirA(materia) {
        const hechizoNuevo = materia.hechizoAEnseniar() 
        self.aprenderHechizo(hechizoNuevo)
    }

}

class GrupoEstudiante {
    const estudiantes = []

    method asistirA(materia) {
        estudiantes.forEach({estudiante => estudiante.asistirA(materia)})
    }

    method irHogwart() {
        estudiantes.forEach({estudiante => hogwart.celebrarCeremoniaDeSeleccion(estudiante)})
    }
}



class BotProfesor inherits BotMago{
    const materias = []

    override method esExperimentado(){
        return super() && self.dictoMasDeDosMaterias()
    }
     method agregarMateria(materia) {
        materia.add(materia)
    }
    override method disminuirEnergiaEn(valor) {}

    method dictoMasDeDosMaterias(){
        return materias.size() > 2
    }

 override method agotarEnergia() {
        cargaElectrica /= 3 
    }

}

object sombreroBot{
    var indexProximaCasa = 0

//1. Llega un grupo de estudiante a Hogwart y el sombrero bot los distribuye en las casas  correspondientes.
  method distribuir(estudiante, casasActuales) {
        const proxCasa = casasActuales.get(indexProximaCasa)
        const sizeCasas = casasActuales.size()

        estudiante.asignarCasa(proxCasa)
        proxCasa.asignarEstudiante(estudiante)

        indexProximaCasa = (indexProximaCasa + 1) % casasActuales.size()
    }   

}