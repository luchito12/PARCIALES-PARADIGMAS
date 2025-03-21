class Casa {
    const estudiantes = []

   method contarAlumnosEnBase(criterio) = estudiantes.count(criterio)

    method cantidadDeAlumnosSucios() = self.contarAlumnosEnBase({estudiante => not estudiante.tieneAceitePuro()})

    method cantidadDeAlumnosPuros() = self.contarAlumnosEnBase({{estudiante => estudiante.tieneAceitePuro()}})
   
   method asignarEstudiante(estudiante) {
        estudiante.add(estudiante)
    }

    method lanzarUltimosHechizosA(hechizado) {
        estudiantes.forEach({estudiante => estudiante.lanzarUltimoHechizoA(hechizado)})
    }
}
class CasasSinCondicionEnPeligrosidad inherits Casa {
    const esPeligrosa 

    method esPeligrosa() = esPeligrosa 
}

class CasaConCondicionExtraEnPeligrosidad inherits Casa {

    method esPeligrosa() = self.cantidadDeAlumnosSucios()  > self.cantidadDeAlumnosPuros()
}

const gryffindor = new CasasSinCondicionEnPeligrosidad(esPeligrosa = true)
const slytherin = new CasasSinCondicionEnPeligrosidad(esPeligrosa = false)
const ravenClaw = new CasaConCondicionExtraEnPeligrosidad()
const hufflepuff = new CasaConCondicionExtraEnPeligrosidad()