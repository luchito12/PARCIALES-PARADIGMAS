object municipalidad {
  const dependencias = []
  const rodados=[]
}

class Dependencias{
    const rodadosDeLaDependencia = []
    const empleados = []
    method cantidadDeEmpleados() = empleados.size()

    method agregarFlota(unRodado){
        rodadosDeLaDependencia.add(unRodado)
    }
    method quitarFlora(unRodado){
        rodadosDeLaDependencia.remove(unRodado)
    }
    method pesoTotalFlota(){
        rodadosDeLaDependencia.sum({unRodado => unRodado.peso()})
    }
    method estaBienEquipada(){
        return self.cumpleConCondiciones()
    }

    method cumpleConCondiciones(){
        return self.tieneUnaCantidadDerodados(3) && self.todosLosRodadosPuedenIrA(100)
    }
    method tieneUnaCantidadDerodados(unaCantidad) = rodadosDeLaDependencia.size() >= unaCantidad
    method todosLosRodadosPuedenIrA(unaVelocidad) = rodadosDeLaDependencia.forEach({unRodado => unRodado.velocidadMaxima() >= unaVelocidad}) 
    method rodadoMasRapido() = rodadosDeLaDependencia.max(({unRodado => unRodado.velocidadMaxima()}))
    method colorDelRodadoMasRapido() = self.rodadoMasRapido().color()
    method tieneAlMenosXEmpleados(unaCantidad) = empleados.size() >= unaCantidad
    method esGrande() = self.tieneAlMenosXEmpleados(40) && self.tieneUnaCantidadDerodados(5)
    method capacidadDeLaFlota() = rodadosDeLaDependencia.sum({unRodado => unRodado.capacidad()})
    method capacidadFaltante() = self.cantidadDeEmpleados() - self.capacidadDeLaFlota()
    method capacidadTotalEnColor(unColor) = self.rodadosDeUnColor(unColor).sum({unRodado => unRodado.capacidad()})
    method rodadosDeUnColor(unColor) = rodadosDeLaDependencia.filter({unRodado => unRodado.color(unColor)})
}



class Rodado{
  method capacidad()
  method color()
  method peso()
  method velocidadMaxima()
}

class ChevoletCorsa inherits Rodado{
var colorAInformar

override method peso(){
    return 1300
}
override method velocidadMaxima() = 150
override method capacidad() = 4
override method color() = colorAInformar

}
class RenaultKwid inherits Rodado{
var tieneTanqueAdicional

override method peso(){
    if(tieneTanqueAdicional){
        return 1350
    }else{
        return 1200
    }
}

override method velocidadMaxima(){
if(tieneTanqueAdicional){
    return 110
}else{
    return 120
}
}

override method capacidad(){
if(tieneTanqueAdicional){
    return 3
}else{
    return 4
}
}

override method color() = "Azul"
}

object trafic inherits Rodado {
var interior
var motor 

override method peso() = 4000 + interior.peso()
override method color() = "blanco"

override method velocidadMaxima() = motor.velocidadMaxima()

override method capacidad() = interior.capacidad()
}

object comodo {
  method peso() = 700
  method capacidad() = 5
}

object popular {
  method peso() = 1000
  method capacidad() =12
}

object pulenta {
  method velocidadMax()=130
}

object bataton {
  method velocidadMax()=80
  
}
