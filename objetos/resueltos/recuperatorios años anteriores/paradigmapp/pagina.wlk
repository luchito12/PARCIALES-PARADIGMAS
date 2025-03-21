object paradigma {
const usuarios=[]

// 3. Realizar una recategorización general de todos los usuarios.

method recategorizacionGeneral(){
usuarios.forEach({usuario=> usuario.recategorizar()})
}

method altaUsuario(usuario){usuarios.add(usuario)}

method bajaUsuario(usuario){usuarios.remove(usuario)}

}