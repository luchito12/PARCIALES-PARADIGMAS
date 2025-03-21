/*Ringtone: Al ser una canción de un autor, su valor depende de lo que dure la misma y el precio por minuto
del autor*/
class Ringtone {
	var duracion
	var precioPorMinutoDeAutor
	
	method montoPorDerechoDeAutor() {
		return duracion * precioPorMinutoDeAutor
	}
	
}

/*Chiste: El precio se calcula a partir de un monto fijo (que es igual para todos los chistes) multiplicado por la
cantidad de caracteres del texto del mismo.*/
class Chiste {
	var valorBase = 5
	var textoDelChiste
	
	method montoPorDerechoDeAutor() {
		return valorBase * textoDelChiste.length()
	}
	
}

/*Juego: Los juegos vienen con un monto determinado que varía de acuerdo a cada juego*/
class Juego {
	var precioDelJuego
	
	method montoPorDerechoDeAutor() {
		return precioDelJuego
	}
}
