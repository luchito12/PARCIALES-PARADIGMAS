class Plato{
    const responsableDelPlato
    const baseCalorias = 100
    method responsableDePlato() = responsableDelPlato
   method cantidadAzucar()
   //Conocer las calorías de un plato. Las calorías de cualquier plato se calculan como 3 * la cantidad de 
   //azúcar que contiene + 100 de base.
   method cantidadDeCalorias() = 3 * self.cantidadAzucar() + baseCalorias
}

//Las entradas nunca tienen azúcar y siempre son bonitas.
class Entrada inherits Plato{
override method cantidadAzucar() = 0

    method esBonito() = true 
}

//Los principales pueden tener una cantidad de azúcar o nada, y pueden o no ser bonitos.
class Principal inherits Plato{
    const esBonito
    const cantidadDeAzucar
	override method cantidadAzucar() = cantidadDeAzucar
    method esBonito() = esBonito
}

//Los postres siempre llevan  120g de azúcar, y son bonitos cuando tienen más de 3 colore
class Postre inherits Plato{
    const cantidadColores
    override method cantidadAzucar() = 120
    method esBonito() = cantidadColores.size() > 3
   


}