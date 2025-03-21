class Critica {
	var texto
	var positiva
	method esPositiva() 
	{
		return positiva
	}
	
	// PUNTO 4 //
	method tieneTextoLargo()
	{
		return texto.words().size() > 100
	}
}

object positiva {
	method textoUsuario() = "SI"
	method esPositiva() = true
}

object negativa {
	method textoUsuario() = "NO"
	method esPositiva() = false
}


class Critico {
	method daCriticaPositiva(juego)
	
	method textoCritica()
	
	// PUNTO 1 //
	method criticar(juego) 
	{
		const unaCritica = new Critica(texto = self.textoCritica(), positiva = self.daCriticaPositiva(juego))
		juego.recibirCritica(unaCritica)
	}
}

/*De usuarios, en cuyo caso, según cada uno, pueden ser tanto positivas como negativa y el
texto es un simple "SI" o "NO". Un usuario puede cambiar su predisposición a votar negativa
o positivamente en cualquier momento.*/
class Usuario inherits Critico{
	// positiva o negativa
	var posicion
	override method textoCritica() = posicion.textoUsuario()
	override method daCriticaPositiva(juego) = posicion.esPositiva()
}

/*De críticos pagos, en cuyo caso son positivos cuando el juego está en la lista de juegos que
le pagaron. Siempre contienen un texto que consiste en palabras random. Un críticos pago
puede recibir pagos de nuevos juegos y de esta manera algún juego que antes calificaba
negativamente, a partir de ese momento lo califica positivamente. O al revés. Pero siempre
se comporta de la misma manera.*/
class CriticoPago  inherits Critico{
	const juegosQueLePagaron = []
	const palabrasRandomDeCriticos = ["divertido", "aburrido", "feo", "juego", "robo"]
	//  Son positivos cuando el juego está en la lista de juegos que le pagaron.
	override method daCriticaPositiva(juego)
	{
		return juegosQueLePagaron.contains(juego)
	}
	
	override method textoCritica()
	{
		return palabrasRandomDeCriticos.anyOne()
	}
	
	method recibirPagoDeJuego(juego)
	{
		juegosQueLePagaron.add(juego)
	}
	
	method dejarDeRecibirPagoDeJuego(juego)
	{
		juegosQueLePagaron.remove(juego)
	}
}

/*De revistas, que sólo son positivas si la mayoría de los críticos que conforman dicha revista
califican positivamente (estos críticos pueden ser pagos o usuarios comunes). El texto de la
crítica es la concatenación de los textos de los críticos. Una revista puede incorporar o perder
críticos, y en función de ello también puede que en diferentes oportunidades califique
diferente a un mismo juego.*/
class Revista inherits Critico {
	const criticos = []
	// son positivas si la mayoría de los críticos que la conforman califican positivamente 
	override method daCriticaPositiva(juego)
	{
		return self.mayoriaCriticosDaCriticaPositiva(juego)
	}
	
	method mayoriaCriticosDaCriticaPositiva(juego) {
		const criticosQueDanCriticaPositiva = self.criticosQueDanCriticaPositiva(juego)
		return criticosQueDanCriticaPositiva.size() > criticos.size() / 2
	}
	
	method criticosQueDanCriticaPositiva(juego)
	{
		return criticos.filter({unCritico=> unCritico.daCriticaPositiva(juego) })
	}
	
	// El texto de la crítica es la concatenación de los textos de los críticos.
	override method textoCritica() 
	{	
		return criticos.map({unCritico => unCritico.textoCritica()})
	}
	
	// Una revista puede incorporar o perder críticos.
	method incorporarCritico(critico)
	{
		criticos.add(critico)
	}
	
	method removerCritico(critico)
	{
		criticos.remove(critico)
	}

}