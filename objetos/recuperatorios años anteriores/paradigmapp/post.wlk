class Post {
var contenidoTextual
const opiniones = []
var estado = abierto

//El valor de un post equivale a la cantidad de comentarios que tenga más la suma de todas las calificaciones recibidas
method valor() = self.cantidadDeComentarios() + self.sumaDeCalificaciones()


method cantidadDeComentarios() = self.comentariosDelPost().size()
method sumaDeCalificaciones() = opiniones.filter({unaOpinion => unaOpinion.esCalificacion()}.sum({unaCalificacion => unaCalificacion.cantUnidades()}) )

method comentariosDelPost()= opiniones.filter({unaOpinion => unaOpinion.esComentario()})

//2.a Agregar un comentario a un post.
method agregarComentario(comentario){
if(estado.permite()){
    self.anadirOpinion(comentario)
}
}

method anadirOpinion(opinion){
    opiniones.add(opinion)
    }
//2.b Poder calificar un post con cierto número.
method agregarCalificacion(calificacion){
     self.anadirOpinion(calificacion)}

method todosSusComentariosSonExtensos() = self.comentariosDelPost().all({comentario=>comentario.esExtenso()})

method esInteresante() = self.cantComentariosExtensos() > 20 and self.valor() > 300

method cantComentariosExtensos() = self.comentariosDelPost().filter({comentario=>comentario.esExtenso()}).size()

method cambiarEstado(nuevoEstado) {estado=nuevoEstado}

}
class PostPremium inherits Post{
//Hay algunos post, llamados premium, para los cuales el valor de las calificaciones se considera doble.    
override method sumaDeCalificaciones() = 2 * super()
override method esInteresante() = self.todosSusComentariosSonExtensos() and self.valor() >= 300 

}
class Opinion{

method esCalificacion() = false
method esComentario() = false

}

class Calificacion inherits Opinion{
const cantidadDeUnidades
override method esCalificacion() = true


}

class Comentario inherits Opinion{
const descripcion

override method esComentario() = true

method esExtenso() = descripcion.size() > 240


}

object abierto{

method permite() = true

}
object cerrado{
method permite() = false

}