import usuario.*
object pDePLibre {
  const usuarios = #{}
  const productos = []

  method reducirPuntos(){
    self.usuariosMorosos().forEach({unUsuario => unUsuario.penalizar()})
  }
  method usuariosMorosos(){
    return usuarios.filter({unUsuario => unUsuario.esMoroso()})
  }

  method eliminarCupones(){
    usuarios.forEach({unUsuario => unUsuario.eliminarCuponesUsados()})
  }

  method obtenerNombresDeProductosEnOferta(){
    productos.map({unProducto => unProducto.nombreEnOferta()})
  }

  method actualizarNivelUsuario(){
    usuarios.forEach({unUsuario => unUsuario.actualizarNivel()})
  }
}
