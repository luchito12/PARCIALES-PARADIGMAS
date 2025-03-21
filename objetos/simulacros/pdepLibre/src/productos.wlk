class Producto {
  var nombre
  const precioBase

  method precio() = precioBase * 1.21

  method precioFinal()

  method nombreEnOferta(){
    return "SUPER OFERTA " + nombre
  }

}

class Mueble inherits Producto {

  override method precioFinal() {
    return self.precio() + 1000
  }

}

class Indumentaria inherits Producto {
  var esDeTemporadaActual // Bool

  override method precioFinal() =   if (esDeTemporadaActual) { return self.precio() * 1.1 }  else return self.precio()
    
  }

class Ganga inherits Producto {

  override method precioFinal(){
    return 0
  }

  override method nombreEnOferta(){
    return super() + " COMPRAME POR FAVOR"
  }

}

