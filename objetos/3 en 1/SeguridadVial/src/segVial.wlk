class Conductor{
	
	var property tieneLicencia
	var property vehiculo
	
	method esSeguro() = tieneLicencia && vehiculo.esSeguro()
	
}

class Auto {
	var property plusVelocidad
	var property tieneRuedaAux
	
	method esSeguro() = tieneRuedaAux && self.velocidad() <= 140
	
	method velocidad() = 100  + plusVelocidad	
	
}

class Moto {
	var property velocidad
	var property cantEspejos
	
	
	method esSeguro() = velocidad <= 160 && cantEspejos >= 2
	
}
