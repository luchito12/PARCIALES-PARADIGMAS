/** First Wollok example */
class Cliente {
	
	var property tipoCliente
	var property salario
	
	method montoTotalPara(montoCuenta) {
		return montoCuenta + tipoCliente.propinaPara(montoCuenta, self)
	}
}

object comun {
	
	method propinaPara(montoCuenta, _) = montoCuenta * 0.1
}

class Comedido {
	var property montoMaximo
	
	method propinaPara(montoCuenta, _) = montoMaximo.min(montoCuenta * 0.2)
}

object amarrete  {
	method propinaPara(monto, _) = 0
}

object segunSalario {
	method propinaPara(_, cliente) = cliente.salario() * 0.01
}


