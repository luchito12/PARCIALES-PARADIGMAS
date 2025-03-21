
import construcciones.*
import planeta.*
import persona.*

//si vive en la montaña, construye una muralla. Su largo será igual a la mitad de las horas que trabaje.
object montaña {
  method construccionPorRegion(unConstructor, unTiempo, unosRecusos ){
    return new Muralla(longitud = unTiempo / 2, precioPorUnidad = 2)
  }
}

//si vive en la costa, construye un museo. Su superficie será igual a la cantidad de horas que trabaje y con nivel 1.
object costa {
    method construccionPorRegion( unConstructor, unTiempo, _ ){
  return new Museo(superficieCubierta = unTiempo, indiceDeImportancia = 1)
  }
}
//si vive en la llanura, depende: si no es destacado, construye una muralla (largo a la mitad de las horas que trabaje), pero si es destacado contruye un museo (la superficie será igual a la cantidad de horas que trabaje, pero con un nivel entre 1 y 5, proporcional a sus recursos)

object llanura{
method construccionPorRegion(unConstructor , unTiempo, unosRecursos ){
    if(!unConstructor.esDestacada())
    return new Muralla(longitud = unTiempo / 2, precioPorUnidad = 1)
    else
    {
    const indiceDeImportancia = new Range(start = 1, end = unosRecursos).anyOne()
    if(indiceDeImportancia > 5)
        throw new UserException(message = "no se puede")
    else
    return new Museo(superficieCubierta = unTiempo, indiceDeImportancia = indiceDeImportancia)
    
    }
  }   
}

//agregar una nueva región y que lo que construya dependa de la inteligencia del constructor
object meseta {
  method construccionPorRegion(unConstructor, unaUnidadDeTiempo, unosRecursos) {
		if(unConstructor.inteligencia() > 100)
			return new Muralla(longitud = unaUnidadDeTiempo * unosRecursos, precioPorUnidad = 1)
		else
			throw new UserException(message = "El constructor no tiene la inteligencia suficiente!")
	}
}

class UserException inherits wollok.lang.Exception {}
