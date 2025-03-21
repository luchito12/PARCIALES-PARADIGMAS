import plato.*
class Cocinero{
    var especialidad
//Hacer que un cocinero cocine, lo cual crea un plato y lo retorna.
    method cocinar(){
        especialidad.crearPlato(self)
    }
    //Catar un plato. Cuando un plato es catado, se obtiene  la calificación que le da el catador
    method catar(unPlato)

    //Que un cocinero pueda cambiar de especialidad (por ejemplo, pasar de ser chef a ser pastelero)
    method cambiarEspecialidad(nuevaEspecialidad){
        especialidad = nuevaEspecialidad
    }

    
}

class Pastero inherits Cocinero{
const nivelDeseadoDulzor

method calificacionMaxima() = 10
override method catar(unPlato){
return (5 * unPlato.cantidadAzucar() / nivelDeseadoDulzor).min(self.calificacionMaxima())
}

//Los pasteleros crean postres con tantos colores como su nivel de dulzor deseado dividido  50
method crearPlato(unCocinero){
    return new Postre(cantidadColores = nivelDeseadoDulzor / 50, responsableDelPlato = unCocinero)
}

}

class Cheff inherits Cocinero{
    const cantidadMaxCalorias
    method calificacionMaxima() = 10
    method calificacionMinima(unPlato) = 0
    method cumpleExpectativas(unPlato) = unPlato.esBonito() && unPlato.cantidadDeCalorias() <= cantidadMaxCalorias

override method catar(unPlato){
    if(self.cumpleExpectativas(unPlato)){
        self.calificacionMaxima()
    }else{
        self.calificacionMinima(unPlato)
    }
}

//Los chefs crean platos principales bonitos con una cantidad de azúcar igual a la cantidad de 
//calorías preferida del cocinero
method crearPlato(unCocinero){
    return new Principal(esBonito = true, cantidadDeAzucar = cantidadMaxCalorias,responsableDelPlato = unCocinero) 
}
}

//Agregar la especialidad souschef. El souschef es como el chef pero cuando no se cumplen las 
//expectativas la calificación que pone es la cantidad de calorías del plato / 100 (máximo 6). 
class Soucheff inherits Cheff{
  override method calificacionMinima(unPlato) = (unPlato.cantidadDeCalorias() / 100 ).min(6)

//Los souschefs crean entradas.
   override method crearPlato(unCocinero){
        return new Entrada(responsableDelPlato = unCocinero)
    }
}

