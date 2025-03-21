import armas.*
import rango.*

class Integrante {

	const armas = [new Escopeta()]
	
	var estaHerido = false
	var estaMuerto = false
	
	var rango = new Soldado()
	var lealtad

/*Durmiendo con los peces: Saber si alguien duerme               
con los peces*/
	method estaDurmiendoConLosPeces() {
		return estaMuerto
	}

	method cantidadArmas() {
		return armas.size()
	}

	method armarse() {
		self.agregarArma(new Revolver(cantidadBalas = 6))
	}

	method agregarArma(unArma) {
		armas.add(unArma)
	}

/*Elegancia: Averiguar si un mafioso sabe despachar elegantemente. Si se trata de un don, seguro                             
sabe. Si es un subjefe, alguno de sus subordinados debe tener un arma sutil. Si es un soldado,                                   
también debe tener un arma sutil. Las cuerdas de piano son sutiles, los revólveres con una sola bala                                   
también.*/
	method sabeDespacharElegantemente() {
		return rango.sabeDespacharElegantemente(self)
	}

	method tieneArmaSutil() {
		return armas.any{ arma => arma.esSutil() }
	}


/*Ataque sorpresa​: Cuando una familia quiere atacar a otra, lo hace por sorpresa y cada uno de sus                                   
integrantes realiza su trabajo responsablemente, tomando como víctima siempre al mafioso más                       
peligroso de la otra familia, que es quien más armas tiene y obviamente esté vivo. En caso de no                                     
quedar ninguno vivo, se concluye el ataque.*/
	method atacarFamilia(unaFamilia) {
		const atacado = unaFamilia.mafiosoMasPeligroso()
		if (atacado.estaVivo()) {
			self.atacarIntegrante(atacado)
		}
	}


	method estaVivo() {
		return not estaMuerto
	}

	method atacarIntegrante(unaPersona) {
		rango.atacar(self, unaPersona)
	}

	method armaCualquiera() {
		return armas.anyOne()
	}

	method armaMasCercana() {
		return armas.first()
	}
	
	method morir() {
		estaMuerto = true
	}
	
	method herir() {
		if (estaHerido) {
			self.morir()
		} else {
			estaHerido = true
		}
	}

/*Luto A veces, inesperadamente, sucede que un Don muere. Cuando preparan su emotivo y                           
multitudinario velorio, la familia aprovecha a reorganizarse.  
● Todo soldado que tenga más de 5 armas, es nombrado subjefe pero empieza sin                           
subordinados 
● El subordinado del difunto más leal a la familia es nombrado don, manteniendo los mismos                             
subordinados, en caso de tener. Además, tiene que saber despachar elegantemente. 
● Todos aumentan su lealtad a la familia en un 10%*/
	method ascenderASubjefe() {
		rango = new Subjefe()
	}
	
	method esSoldado() {
		return rango.esSoldado()
	}
	
	method ascenderADonDe(unaFamilia) {
		rango = new Don(subordinados = self.subordinados())
		unaFamilia.ascenderADon(self)
	}
	
	method subordinados() {
		return rango.subordinados()
	}
	
	method aumentarLealtadPorLuto() {
		lealtad *= 1.1
	}
	
	method lealtad() {
		return lealtad
	}
	
}


/*Al iniciar una traición, se determina el miembro de su propia familia que va a ser la primera víctima, y                                       
se establece una fecha tentativa.*/
class Traicion {
	const traidor
	const victimas = #{}
	
	const fechaTentativa
	
	method ajusticiar() {
		// Esto se lo dejo a ustedes, es fácil
	}

	method concretarse() {
		// Esto se lo dejo a ustedes, es fácil
	}
}