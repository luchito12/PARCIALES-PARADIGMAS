import categoria.*

class Usuario{
    const post=[]

    var categoria = novato

// 1. Hacer que un usuario postee un contenido
method postear(contenido) {post.add(categoria.tipoPost(contenido))}

// 2.c Conocer el puntaje de un usuario
method puntaje(){post.sum({unPost => unPost.puntaje()})}

method recategotizar(){
    categoria.recategorizarse(self)

}
method promoverA(unaCategoria){ categoria = unaCategoria}
method tieneAlMenosUnPostDe(cant) = post.any({unPost => unPost.valor()> cant})


// 4. Saber la cantidad de posts interesantes de un usuario
method cantPostInteresantes() = self.postInteresantes().size()
method postInteresantes() = post.filter({unpost => unpost.esInteresante()})

}
