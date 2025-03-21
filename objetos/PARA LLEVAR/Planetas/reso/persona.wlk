import planeta.*
class Persona{
    var monedas = 20
    var edad

//- ganar o gastar monedas, en una cantidad dada.

    method ganarMonedas(unaCantidad){
        monedas += unaCantidad
    } 
    method gastarMonedas(unaCantidad){
        monedas -= unaCantidad
    }
//los _recursos_ son las monedas que tiene una persona, inicialmente 20 para cualquier de ellas, pero puede ir variando con el tiempo.
    method recursos() = monedas
    
//- cumplir años
    method cumplirAños()= edad ++

    method suEdadEstaEntreCiertoRango(unaEdadMinima, unaEdadMaxima) {
		return edad.between(unaEdadMinima, unaEdadMaxima)
	}

    method tieneMasDeRecursosDadaUnaCantidad(unaCantidad) {
		return monedas > unaCantidad
	}
    method esDestacada(){
       return self.suEdadEstaEntreCiertoRango(18, 65) || self.tieneMasDeRecursosDadaUnaCantidad(30)}
	
    
    method trabajar(unTiempo, unPlaneta ) {}

}

class Productor inherits Persona{
const tecnicasQueConoce = [cultivo]

//Los _recursos_ de un productor es su cantidad de monedas, como para todas las personas, multiplicado por la cantidad de técnicas que conoce.
override method recursos(){
    return super() * tecnicasQueConoce.size()
}

//Un productor _es destacado_ si cumple la condición común para todas las personas, o si conoce más de 5 técnicas.
override method esDestacada(){
    return super() || self.conoceMasDeCincoTecnicas()
}

method conoceMasDeCincoTecnicas(){
    return tecnicasQueConoce.size()>5
}

//_realizar_ una técnica durante una cantidad de tiempo: el efecto es ganar 3 monedas por cada unidad de tiempo, pero sólo en caso que conozca dicha técnica. P.ej. el efecto de realizar un cultivo durante un tiempo 5, es ganar 15 monedas. En caso que le pidan realizar uan tarea que no conoce, pierde una unidad de sus recursos básicos.
method realizar(unaTecnica, tiempo){
if(self.conoceTecnica(unaTecnica))
self.ganarMonedas(3* tiempo)
}else{
  self.gastarMonedas(1)
}

method conoceTecnica(unaTecnica){
    return tecnicasQueConoce.contains(unaTecnica)
}

//_aprender_ una técnica: hace que el productor conozca una nueva técnica.
method aprenderUnaTecnica(unaTecnica){
    tecnicasQueConoce.add(unaTecnica)
}

//_trabajar_ durante una cantidad de tiempo en un planeta: implica realizar la última tecnica aprendida durante dicho tiempo, pero sólo en caso que sea el planeta en que vive el productor.
override method trabajar(unTiempo, unPlaneta){
if(unPlaneta.viveEsteHabitante(self))
self.realizar(tecnicasQueConoce.last(), unTiempo)
}

}
class Construtor inherits Persona{
    var construccionesRealizadas 
    const regionDondeVive
    const inteligencia

    method inteligencia() = inteligencia
    
    //Los _recursos_ de un constructor son sus monedas, como toda persona, más 10 monedas por cada construcción realizada.
    override method recursos(){
    return super() + (construccionesRealizadas.size() *10)
}
//Un constructor es destacado si realizó más de 5 construcciones, independientemente de su edad. 
    override method esDestacada(){
        return self.realizoMasDeCincoConstrucciones()
    }
    method realizoMasDeCincoConstrucciones(){
        return construccionesRealizadas > 5
    }
    
    //_trabajar_ una determinada cantidad de tiempo en un planeta: Construye una construcción en el planeta dado, sin importar que sea el que vive. Además, gasta 5 monedas. 
    override method trabajar(unTiempo, unPlaneta){
        unPlaneta.agregarConstruccion(regionDondeVive.construccionPorRegion(self, unTiempo, self.recursos()))
        self.gastarMonedas(5)
        self.aumentarConstruccion()
    }
    method aumentarConstruccion() {
		construccionesRealizadas ++
	}

    }