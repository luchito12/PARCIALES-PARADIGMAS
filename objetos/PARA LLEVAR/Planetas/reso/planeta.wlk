import persona.*
import construcciones.*

//De cada **planeta** se conocen las personas que lo habitan. También se lleva el registro de las construcciones que se fueron efectuando en él.
class Planeta{
    const habitantes = #{}
    const construcciones = []

//la _delegación diplomática_, que está formada por todos los habitantes destacados y el habitante que tenga más recursos. Si llegara a coincidir que el habitante con más recursos fuera tambien destacado, mantiene su pertenencia a la delegación.
    method delegacionDiplomatica(){
                return self.habitantesDestacados() && self.habitanteConMasRecusos()
    }
       
    method habitantesDestacados(){
        return habitantes.filter({unHabitante => unHabitante.esDestacada()})
    }
       
    method habitanteConMasRecusos(){
        return habitantes.max({unHabitante => unHabitante.recursos()})
    }

//si es _valioso_: la condición es que el total del valor de todas las construcciones sea mayor a 100 monedas.
    method esValioso(){
        self.cumpleConCondicion()
    }

    method cumpleConCondicion(){
        return self.sumaDeValoresDeLasConstrucciones() > 100
    }
    
    method sumaDeValoresDeLasConstrucciones(){
        return construcciones.sum({unaConstruccion => unaConstruccion.valor()}) > 100

    }
    method viveEsteHabitante(unHabitante) {
		return habitantes.contains(unHabitante)
	}
    
    	method agregarConstruccion(unaConstruccion) {
		construcciones.add(unaConstruccion)
	}
	
    //Hacer que la delegación diplomática del planeta trabaje durante un determinado tiempo en su planeta
    method hacerQueLaDelegacionDiplomaticaTrabajeEnUnPlaneta(unPlaneta, unTiempo) {
		self.delegacionDiplomatica().forEach({unDiplomatico => unDiplomatico.trabajar(unTiempo,unPlaneta)})
	}
    
    //Hacer que un planeta invada a otro y obligue a su delegación diplomática a trabajar para el planeta invasor.
    method invadirUnPlanetaPorUnTiempo(otroPlaneta, unaUnidadDeTiempo) {
		otroPlaneta.hacerQueLaDelegacionDiplomaticaTrabajeEnUnPlaneta(self, unaUnidadDeTiempo)
	}

    }