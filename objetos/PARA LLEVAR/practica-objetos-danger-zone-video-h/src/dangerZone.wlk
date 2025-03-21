// const empleado = new Empleado(
// 		puesto = new Oficinista(cantEstrellas = 1))
// empleado.puesto(espia)
// empleado.estaIncapacitado()

// empleado.puedeUsar(habilidad)

// mision.serCumplidaPor(empleado)
// mision.serCumplidaPor(equipo)


//Para resolver una misión,los empleados pueden conformar equipos,
// para colaborar y mejorar suschances de éxito
class Equipo {
	const empleados = []
	
	//n equipo cumpla una misión.Esto sólo puede llevarse a cabo si quien la cumple reúne todas lashabilidades requeridas de la misma (si puede usarlas todas). Para losequipos alcanza con que al menos uno de sus integrantes pueda usar cadauna de ellas
	method puedeUsar(habilidad) = 
		empleados.any({empleado => empleado.puedeUsar(habilidad)})
		

	//el equipo que cumplió la misión recibe daño en base ala peligrosidad de la misión. Para los equipos, esto implica que todos losintegrantes reciban un tercio del daño total.	
	method recibirDanio(cantidad) {
		empleados.forEach({empleado => empleado.recibirDanio(cantidad / 3)})
	}
	

	method finalizarMision(mision) {
		empleados.forEach({empleado => empleado.finalizarMision(mision)})
	}
}


//Hacer que un empleado o un equipo cumplauna misión.Esto sólo puede llevarse a cabo si quien lacumple reúne todas las habilidadesrequeridas de la misma 
//(si puede usarlastodas). 
//Para los equipos alcanza con que almenos uno de sus integrantes pueda usarcada una de ellas
class Mision {
	const habilidadesRequeridas = []
	const peligrosidad
	
	method serCumplidaPor(asignado) {
		self.validarHabilidades(asignado)
		asignado.recibirDanio(peligrosidad)		
		asignado.finalizarMision(self)
	}
	
	method validarHabilidades(asignado) {
		if (not self.reuneHabilidadesRequeridas(asignado)) {
			self.error("La misión no se puede cumplir")
		}
	}
	
	method enseniarHabilidades(empleado) {
		self.habilidadesQueNoPosee(empleado)
			.forEach({hab => empleado.aprenderHabilidad(hab)})
	}
	
	method reuneHabilidadesRequeridas(asignado) =
		habilidadesRequeridas.all({hab => asignado.puedeUsar(hab)})
		
	method habilidadesQueNoPosee(empleado) =
		habilidadesRequeridas.filter({hab => not empleado.poseeHabilidad(hab)})
}

//Todos los empleados poseen habilidades, las cuales usan para resolver misiones, y una cantidad de saludvariable. Sabemos que 
//los empleados quedanincapacitados cuando su salud se encuentra pordebajo de su salud crítica.
class Empleado {
	var property puesto
	var salud = 100
	const habilidades = #{}
	
	//Saber si un empleado está incapacitado.
	method estaIncapacitado() = salud < puesto.saludCritica()

	//Saber si un empleado puede usar una habilidad, que se cumple si no estáincapacitado y efectivamente posee la habilidad indicada
	method puedeUsar(habilidad) 
		= not self.estaIncapacitado() && self.poseeHabilidad(habilidad)
		
	method poseeHabilidad(habilidad) = habilidades.contains(habilidad)
	
	method recibirDanio(cantidad) { salud = salud - cantidad }
	
	method estaVivo() = salud > 0
	
	method finalizarMision(mision) {
		if (self.estaVivo()) {
			self.completarMision(mision)
		}
	}
	
	method completarMision(mision) {
		puesto.completarMision(mision, self) 
	}
	
	method aprenderHabilidad(habilidad) {
		habilidades.add(habilidad)
	}
}

//Saber si un empleado puede usar una habilidad, que se cumple si no estáincapacitado y efectivamente posee la habilidad indicada. En el caso de losjefes, 
//también consideramos que la posee si alguno de sus subordinados lapuede usar
class Jefe inherits Empleado {
	var subordinados
	override method poseeHabilidad(habilidad) 
		= super(habilidad) || self.algunoDeSusSubordinadosLaPuedeUsar(habilidad)
		
	method algunoDeSusSubordinadosLaPuedeUsar(habilidad)
		= subordinados.any {subordinado => subordinado.puedeUsar(habilidad)	}
	
}
//Son los referentes más importantes dentro de la agencia y soncapaces de aprender nuevas habilidades al completar misiones.La salud crítica de los espías es 15.
object espia {
	method saludCritica() = 15
	

	//Los espías aprenden las habilidades de la misión que no poseían
	method completarMision(mision, empleado) {
		mision.enseniarHabilidades(empleado)
	}
}


//de alguna forma u otra siempre terminan involucrándose en lasmisiones. Sabemos que si un oficinista sobrevive a una misión gana unaestrella.Su salud crítica es de 40 - 5 * la cantidad de estrellas que tenga
class Oficinista {
	var cantEstrellas = 0
	method saludCritica() = 40 - 5 * cantEstrellas
	

	//Por último, los empleados que sobreviven al finalizar la misión (por tenersalud > 0) registran que la completaron, teniendo en cuenta que:- Los oficinistas consiguen una estrella. Cuando un oficinista junta tresestrellas adquiere la suficiente experiencia como para empezar a trabajar deespía
	method completarMision(mision, empleado) {
		cantEstrellas += 1
		if (cantEstrellas == 3) {
			empleado.puesto(espia)
		}
	}
}