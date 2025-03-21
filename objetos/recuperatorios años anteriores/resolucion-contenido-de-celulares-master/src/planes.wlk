
/*Para los que tienen plan
prepago, lo que se cobra por cada descarga es un 10% más del precio descrito anteriormente,*/
class Prepago {
	var saldo
	
	method recargoPorPlan() {
		return 1.1
	}	
	
	
	method tengoSaldoParaDescarga(costo) {
		return saldo >= costo
	}
	
	method cobrar(costo) {
		saldo -= costo
	}
}

/* mientras que para
quienes tienen un plan facturado no se les cobra recargo*/
class Facturado {
	var saldoAcumulado
	
	method recargoPorPlan() {
		return 1
	}
	
	/*Quienes tienen un plan facturado, pueden descargar libremente, pero debe acumularse
cuánto fue gastando durante el mes para luego facturarle lo que corresponda.*/
	method tengoSaldoParaDescarga(costo) {
		return true
	}
	
	method cobrar(costo) {
		saldoAcumulado += costo
	}
}
