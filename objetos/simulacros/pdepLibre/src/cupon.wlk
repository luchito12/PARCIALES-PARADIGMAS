class Cupon{
    var fueUsado = false
    const descuento
    
    method descuento() = descuento 

    method estaDisponible(){
        return !fueUsado
    }

    method precioConElDescuentoAplicado(unPrecio){
        return unPrecio * (1 - descuento)
    }

    method usar(){
        fueUsado = true
    }



}
