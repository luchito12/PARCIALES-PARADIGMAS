object harryPotterElMisterioDelPrincipeMestizo {
	
	var property cantidadLectores = 10500156
	
	method valoracion() = cantidadLectores/10000000
	
}

object elSeniorDeLosAnillosLasDosTorres {
	var property cantPaginas = 450
	
	method valoracion() = cantPaginas/45
}

object elPrincipito {
	const property valoracion = 50
	
}

object losJuegosDelHambre {
	var property votosPositivos = 1600200 
	var property votosNegativos = 300600
	
	method coeficiente() = votosPositivos - votosNegativos
	
	method valoracion() {
		
	 if(self.coeficiente() > 0) {
		return self.coeficiente()/100000
	  }		
	  return 0		
	}	
}



object venasAbiertasDeAmericaLatina {
	const property anioPublicacion = 1971
	
	method cantidadDeAnios() {
		const fechaHoy = new Date()
		return fechaHoy.year() - anioPublicacion
	}
	
	method valoracion() = self.cantidadDeAnios()/3
}

object rayuela{
	const titulo = "Rayuela"
	
	method valoracion() = self.cantLetras() * 2
	
	method cantLetras() = titulo.size()
}


object andy {
	const property librosLeidos = [harryPotterElMisterioDelPrincipeMestizo,elSeniorDeLosAnillosLasDosTorres, elPrincipito,losJuegosDelHambre, venasAbiertasDeAmericaLatina,rayuela]
	
	method ultimoLibroLeido() = librosLeidos.last()
	
	method primerLibroLeido() = librosLeidos.first()
	
	method cantidadLibrosLeidos() = librosLeidos.size()
	
	method olvidarPrimerLibroLeido() = librosLeidos.remove(self.primerLibroLeido())
	
	method olvidarLibro(unLibro) = librosLeidos.remove(unLibro)
	
	method peorLibroLeido() = librosLeidos.min({unLibro => unLibro.valoracion()})
	
	method mejorLibroLeido() = librosLeidos.max({unLibro => unLibro.valoracion()})
	
	method buenosLibrosLeidos() = librosLeidos.filter({unLibro => self.esBuenLibro(unLibro)})
	
	method esBuenLibro(unLibro) = unLibro.valoracion() > 12
	
}