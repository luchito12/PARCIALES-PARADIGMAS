//Crear una materia, determinando qué profesor la dicta y el hechizo que se enseñará.
class Materia {
    const profesor
    const hechizo

    method crearMateria() {
        profesor.agregarMateria(self)
    }

    method hechizoAEnseniar() = hechizo
}