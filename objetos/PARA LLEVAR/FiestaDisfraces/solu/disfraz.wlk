class Disfraz{
const fecha
const nombre
const caracteristicas = []
method fecha() = fecha 
method nombre() = nombre
}

class Gracioso{
const nivelDeGracia

method puntaje(unInvitado, _unaFiesta){
    if(unInvitado.edad() > 50){
        nivelDeGracia * 3
    }else{
        nivelDeGracia
    }
}
}

class Tobaras{
const diaDeCompra

method puntaje(_unInvitado, unaFiesta){
    if(unaFiesta.fecha() - diaDeCompra >= 2){
      return  5
    }else{
       return  3
    }
}

}

class Caretas{
var personajeCareta

method puntaje(_unInvitado, _unaFiesta){
    return personajeCareta.valor()
}

}

class PersonajeCareta{
    const nombre
    const puntaje 
    method valor(){
        return puntaje
    }
}
