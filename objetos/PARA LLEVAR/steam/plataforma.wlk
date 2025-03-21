import juego.Juego
import juego.DescuentoDirecto
import juego.descuentoNulo

object plataforma {
	const juegos = []
	
	method juegoMasCaro()
	{
		return juegos.max{unJuego => unJuego.precio()}
	}
	
	/*La plataforma puede modificar el descuento de cualquiera de los
juegos, o incluso hacer que no tenga descuento. Los descuentos no son acumulativos, sólo se aplica
el más recientemente estipulado*/
	method modificarDescuento(juego, nuevoDescuento)
	{
		juego.cambiarDescuento(nuevoDescuento)
	}
	
	method eliminarDescuento(juego)
	{
		juego.descuento(descuentoNulo)
	}
	
	method aniadirJuego(juego)
	{
		juegos.add(juego)
	}
	
	method removerJuego(juego)
	{
		juegos.remove(juego)
	}
	
	 ////////////////// PUNTO 2 //////////////////
	 /*A todos los juegos cuyo precio supera las ¾ partes del juego más caro, se decide aplicarle un
descuento directo con un determinado porcentaje*/
	 method aplicarDescuentoPorcentual(nuevoPorcentaje)
	 {	
	 	if (nuevoPorcentaje > 1)
	 	{
	 		throw new Exception(message = "No se puede aplicar un descuento del mas del 100%")
	 	}
	 	const precioJuegoMasCaro = self.juegoMasCaro().precio()
	 	
	 	const juegosADescontar = juegos.filter{unJuego => unJuego.superaPrecio( 0.75 * precioJuegoMasCaro)}
	 	
	 	const nuevoDescuento = new DescuentoDirecto(porcentaje = nuevoPorcentaje)
	 	
	 	juegosADescontar.forEach{unJuego => self.modificarDescuento(unJuego, nuevoDescuento)}
	 }
	 
	 //////////////////// INTERNACIONALIZACIÓN ////////////////////
	 //Saber si un juego es apto para menores en un país en particular
	method juegoAptoParaMenoresEnPais(juego, pais)
	{
		return juego.aptoParaMenoresEnPais(pais)
	}
	
	//Calcular el promedio de precio final de los juegos aptos para menores en un país, expresado
  //en moneda local.

	method precioJuegoEnPais(juego, pais)
	{
		return pais.deDolaresAPesos(juego.precio())
	}
	
	method todosLosJuegosAptosEnPais(pais)
	{
		return juegos.filter{unJuego => self.juegoAptoParaMenoresEnPais(unJuego, pais)}
	}
	
	method promedioDeTodosLosJuegosAptosEnPais(pais)
	{
		const juegosAptos = self.todosLosJuegosAptosEnPais(pais)
		
		const cantidadJuegosAptos = juegosAptos.size()
		
		return juegosAptos.sum{unJuego => unJuego.precio()} / cantidadJuegosAptos
		
	}
	
	//////////////////////////////////// REVIEWS ////////////////////////////////////
	// PUNTO 3 //
	method hayAlgunJuegoGalardonado()
	{
		return juegos.any{unJuego => unJuego.sinCriticasNegativas() }
	}
}
    