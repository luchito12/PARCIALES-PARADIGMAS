
/*De cada juego se conoce su precio en dólares, que no puede cambiar.
Al precio se le puede aplicar algún descuento, que pueden ser*/
class Juego {
  const precioBase 
	var descuento 
	method precioBase() = precioBase
	method descuento() = descuento
	method cambiarDescuento(unDescuento){
		descuento = unDescuento
	}
	
	//De cada juego se conoce una serie de características
	const caracteristicas = []

	//Los juegos reciben críticas, que se utilizan para orientar a los futuros compradores sobre qué juego compra
	const criticas = []
	
	/*Saber el precio de un juego en dólares, considerando su descuento.*/
    method precio() {
		return (descuento.precio(self)).max(0)
	}

    method superaPrecio(precio) {
		return self.precio() > precio
	}


    method contieneCaracteristica(caracteristica) {
		return caracteristicas.contains(caracteristica)
	}
	
	method contieneAlgunaCaracteristica(listaCaracteristicas) {
		return listaCaracteristicas.any({unaCaracteristica => self.contieneCaracteristica(unaCaracteristica)})
	}
	
	method esViolento() {
		return self.contieneCaracteristica("violento")
	}
	
	/*Saber si un juego es apto para menores en un país en particular*/
	method aptoParaMenoresEnPais(pais) {
		return !self.contieneAlgunaCaracteristica(pais.caracteristicasProhibidas())
	}

	/*Registrar la crítica de algún crítico a algún juego.*/
	method recibirCritica(critica) {
		criticas.add(critica)
	}
	
	/*Saber si un juego pasa el umbral de tener una cierta cantidad de críticas positivas.*/
	method tieneAlMenosNCantidadCriticasPositivas(unaCantidad) {
		return self.criticasPositivas().size() > unaCantidad
	}
	method criticasPositivas(){
		return criticas.filter({unaCritica => unaCritica.esPositiva()})
	}
	
	/*Saber si hay algún juego que resulta juego galardonado para Estim, que es aquel juego que
no haya recibido críticas negativas*/
	method sinCriticasNegativas() {
		return criticas.all({unaCritica => unaCritica.esPositiva()})
	}

/*Saber si un juego tiene críticos literarios, que es cuando alguna de las críticas presenta un
texto de más de 100 caracteres.*/
    method tieneCriticoLiterario() {
		return criticas.any({x => x.tieneTextoLargo()})
		 }

}

////////////////// DESCUENTOS //////////////////
/*Descuento directo. Es un porcentaje de descuento que se
aplica sobre el precio del juego*/
class DescuentoDirecto {
	// Valor del tipo 0.1, 0.5 ...
	var porcentaje
	method precio(juego) {
		return juego.precioBase() - (porcentaje * juego.precioBase())
	}
}

/*Descuento fijo. Es un monto fijo que se le descuenta del
precio del juego, pero de manera que el precio final nunca
puede ser menor a la mitad del precio original*/
class DescuentoFijo {
	const montoFijo
	method precio(juego)
	{
		const mitadPrecioOriginal = juego.precioBase() / 2
		return (juego.precioBase() - montoFijo).max(mitadPrecioOriginal)
	}	
}

/*Gratis!! Cuando el juego tiene ese "descuento", es totalmente
gratuito*/
class DescuentoGratis {
	method precio(juego) = 0
}

object descuentoNulo {
	method precio(juego) = juego.precioBase()
}

// DESCUENTO INVENTADO //
/*nventar un nuevo tipo de descuento que se pueda aplicar a cualquier juego, con la única
restricción de usar super() de una manera apropiada en su implementación*/
class DescuentoDirectoSoloParaJuegosNoViolentos inherits DescuentoDirecto {
	override method precio(juego)
	{
		if (juego.esViolento()) {
			return juego.precioBase()
		}
		return super(juego)
	}
}

//////////////////////// INTERNACIONALIZACIÓN //////////////////////////////////// 
class Pais {
	/*Un juego puede venderse en muchos países y de cada país se conoce su conversión dólares a la
moneda local y la legislación vigente donde se especifican las características prohibidas para
menores de edad, es decir que si un juego presenta entre sus características alguna de ellas, no es
apto para menores*/
	var  conversionDolares
	var caracteristicasProhibidas = [] 
	method caracteristicasProhibidas() = caracteristicasProhibidas
	method deDolaresAPesos(precioEnDolares)
	{
		return precioEnDolares * conversionDolares
	}
}