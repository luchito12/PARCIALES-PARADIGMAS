class Familia {

	const integrantes = []
	var don

/*Peligroso! Encontrar al mafioso (vivo) más armado             
de una familia*/
	method mafiosoMasPeligroso() {
		return self.integrantesVivos().max{ integrante => integrante.cantidadArmas() }
	}

/*"El que quiera estar armado que ande armado" Para estar más protegido ante la ola de crímenes,                                 
siguiendo los consejos de las autoridades, se distribuyen armas en la familia: A todos los integrantes                               
se les da un revólver con 6 balas.*/
	method armarFamilia() {
		self.integrantesVivos().forEach{ integrante => integrante.armarse()}
	}

	/*Ataque sorpresa​: Cuando una familia quiere atacar a otra, lo hace por sorpresa y cada uno de sus                                   
integrantes realiza su trabajo responsablemente, tomando como víctima siempre al mafioso más                       
peligroso de la otra familia, que es quien más armas tiene y obviamente esté vivo. En caso de no                                     
quedar ninguno vivo, se concluye el ataque*/

	method atacarFamilia(unaFamilia) {
		self.integrantesVivos().forEach{ integrante => integrante.atacarFamilia(unaFamilia)}
	}
	
	method integrantesVivos() {
		return integrantes.filter { integrante => integrante.estaVivo() }
	}
	
	/*LUTO 
	A veces, inesperadamente, sucede que un Don muere. Cuando preparan su emotivo y                           
multitudinario velorio, la familia aprovecha a reorganizarse*/
	method reorganizarse() {
		self.ascenderSoldadosConArmas()
		self.elegirNuevoDon()
		self.aumentarLealtad()
	}

/*Todo soldado que tenga más de 5 armas, es nombrado subjefe pero empieza sin                           
subordinados*/
	method ascenderSoldadosConArmas() {
		self.soldadosVivos()
			.sortBy { int1, int2 => int1.cantidadArmas() > int2.cantidadArmas() }
			.take(5)
			.forEach { integrante => integrante.ascenderASubjefe() } 
	}
	
	method soldadosVivos() {
		return self.integrantesVivos().filter { integrante => integrante.esSoldado() }
	}
	
	method elegirNuevoDon() {
		don.subordinadoMasLeal().ascenderADonDe(self)
	}
	
	method ascenderADon(unIntegrante) {
		don = unIntegrante
	}
	
	/*Todos aumentan su lealtad a la familia en un 10%*/
	method aumentarLealtad() {
		integrantes.forEach { integrante => integrante.aumentarLealtadPorLuto() }
	}

}
