import cupon.Cupon
class Usuario{
    var dineroDisponible
    var puntos
    var nivel = bronce

    const nombre
    const carrito = []
    const cupones = []


   method agregarAlCarrito(unProducto){
        if( nivel.puedeAgregarAlCarrito(carrito.size()) ){
            carrito.add(unProducto)
        } else {
            throw new NoPuedeAgregarAlCarritoException()
        }
    }

    method comprarCarrito(){
        const cupon = self.cuponDisponible()
        cupon.usar()
        const precioAPagar = cupon.precioConElDescuentoAplicado(self.precioDelCarrito())
        dineroDisponible -= precioAPagar
        self.sumarPuntos(precioAPagar)
        
    }

    method cuponDisponible() {
        return cupones.filter( { unCupon => unCupon.estaDisponible() } ).anyOne()
    }

    method precioDelCarrito(){
        return carrito.sum({ unProducto => unProducto.precioFinal() })
    }

    method sumarPuntos(unPrecio){
        puntos += unPrecio * 0.1
    }

    method esMoroso() = dineroDisponible < 0

    method penalizar() {
        puntos -= 1000
    }

    method eliminarCuponesUsados(){
        cupones.removeAllSuchThat({ unCupon => !unCupon.estaDisponible() })
    }

    method actualizarNivel(){
        nivel = self.nivelCorrespondiente()
    }

    method nivelCorrespondiente(){
        if ( puntos < 5000   ) return bronce 
        if ( puntos <  15000 ) return plata
        return oro
    }
    
}


class NivelLimitado {
    const limite

    method puedeAgregarAlCarrito(unaCantidad){
        return unaCantidad < limite
    }

}

const bronce = new NivelLimitado(limite = 1)
const plata = new NivelLimitado(limite = 5)

object oro{
    method puedeAgregarAlCarrito(unaCantidad){
        return true
    }
}

class NoPuedeAgregarAlCarritoException inherits Exception (message = "No puede agregar al carrito"){

}