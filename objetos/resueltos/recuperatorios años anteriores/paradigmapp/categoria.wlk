import post.*

class Categoria{
method tipoPost(contenido) = new Post(contenidoTextual=contenido)

method recategorizarse(usuario){
    if(self.cumpleConCategorizacion(usuario)) self.promocion(usuario)
}

method cumpleConCategorizacion(usuario)
method promocion(usuario)
}

object novato inherits Categoria {

override method cumpleConCategorizacion(usuario) = usuario.puntaje() > 100
override method promocion(usuario) { usuario.promoverA(intermedio)}
}

object intermedio inherits Categoria {
override method cumpleConCategorizacion(usuario) = usuario.puntaje() > 1000 and usuario.tieneAlMenosUnPostDe(500)
override method promocion(usuario) { usuario.promoverA(experto)}
}

object experto inherits Categoria {
override method tipoPost(contenido) = new PostPremium(contenidoTextual=contenido)

override method cumpleConCategorizacion(usuario) = false
override method promocion(usuario) {}
}

