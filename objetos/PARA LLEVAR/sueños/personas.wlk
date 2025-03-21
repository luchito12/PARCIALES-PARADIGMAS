class Persona{
    var edad
    const carrerasAEstudiar =[]
    const plataAGanar
    var tieneHijos
    var felicidad
    const sueños= []
    const carrerasRecibidas = []
    const lugaresVisitados = []
    var tipoPersona
    
	method sueniosPendientes() = sueños.filter { suenio => suenio.estaPendiente() }

    method cumplirSueño(unSuenio){
        if(unSuenio.puedeSerCumplidoPor(self)){
            unSuenio.realizar()
        }else{

        }
    }
    method cumplirSuenioElegido() {
		const suenioElegido = tipoPersona.elegirSuenio(self.sueniosPendientes())
		self.cumplirSueño(suenioElegido)
	}
    
    method carrerasAEstudiar() = carrerasAEstudiar
    method carrerasRecibidas() = carrerasRecibidas
    method recibirse(unaCarrera)= carrerasRecibidas.add(unaCarrera)
    method añadirSuenio(unSueño) = sueños.add(unSueño)
    method quieroGanar()= plataAGanar
    method tengoUnHijo() = tieneHijos
    method adoptar(){
        tieneHijos = true
    }
    method tenerUnHijo(){
        tieneHijos = true
    }

    method viajar(unLugar){
        lugaresVisitados.add(unLugar)
    }

    method esAmbicioso(){
        return self.sueñosAmbiciosos().size() >3  
    }
    method sueñosAmbiciosos(){
        return  sueños.filter({unSueño => unSueño.felicidonios() > 100 })
    }

    method esFeliz() = felicidad > sueños.sum { unSuenio => unSuenio.felicidonios() }

}


object realista { 
	method elegirSuenio(sueniosPendientes) {
		sueniosPendientes.max { suenio => suenio.felicidonios() }
	}
}

object alocado { 
	method elegirSuenio(sueniosPendientes) {
		sueniosPendientes.anyOne()
	}
}

object obsesivo { 
	method elegirSuenio(sueniosPendientes) {
		sueniosPendientes.first()
	}
}



class Sueño{
const felicidonios
var cumplido = false

method felicidonios() = felicidonios
method puedeSerCumplidoPor(unaPersona)
method realizar(unaPersona)
method fueCumplido(){
    cumplido = true
}

}

class RecibirseDeUnaCarrera inherits Sueño{
    const carrera

override method puedeSerCumplidoPor(unaPersona){
    return self.esValidaLaCarrera(unaPersona)
   
}

override method realizar(unaPersona){
        unaPersona.recibirse(carrera)
        self.fueCumplido()       

}

method esValidaLaCarrera(unaPersona) =  self.quiereEstudiar(unaPersona) && self.noSeRecibio(unaPersona)
method quiereEstudiar(unaPersona)= unaPersona.carrerasAEstudiar().contains(carrera) 
method noSeRecibio(unaPersona)= !unaPersona.carrerasRecibidas().contains(carrera)

}

class TenerUnHijo inherits Sueño{
override method puedeSerCumplidoPor(unaPersona){
   return true
}
override method realizar(unaPersona){
    unaPersona.tenerUnHijo()
    self.fueCumplido()       
}


}

class Adoptar inherits Sueño{

override method puedeSerCumplidoPor(unaPersona){
    return self.puedeAdoptar(unaPersona)
} 

override method realizar(unaPersona){
    if(self.puedeSerCumplidoPor(unaPersona))       
        unaPersona.adoptar()
        self.fueCumplido()       
    

}

method puedeAdoptar(unaPersona){
    return !unaPersona.tengoUnHijo()
}
}

class Viajar inherits Sueño{
const unLugar

override method puedeSerCumplidoPor(unaPersona){
    return true
}
override method realizar(unaPersona){
    if(self.puedeSerCumplidoPor
    (unaPersona)){
            unaPersona.viajar(unLugar)
            self.fueCumplido()       
    }
}

}

class ConseguirLaburo inherits Sueño{
    const dineroAPagar

override method puedeSerCumplidoPor(unaPersona){
return self.dineroSufiente(unaPersona)
}

override method realizar(unaPersona){
if(self.puedeSerCumplidoPor(unaPersona)){
            self.fueCumplido()

    }
    
}
method dineroSufiente(unaPersona){
   return unaPersona.quieroGanar() < dineroAPagar
}

}


class sueñoMultiple inherits Sueño{
    const listaDeSueños = []
    method puedeSerCumplido(unaPersona){
        listaDeSueños.forEach({unSueño => unSueño.puedeSerCumplido(unaPersona)})
    }
    override method realizar(unaPersona) {
		listaDeSueños.forEach { unSuenio => unSuenio.realizar(unaPersona) }
	}	
}