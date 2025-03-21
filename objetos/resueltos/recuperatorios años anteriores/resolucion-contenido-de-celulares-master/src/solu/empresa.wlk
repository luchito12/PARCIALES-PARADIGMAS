
object empresa {
  const usuarios = []
const empresas =[]

method cobrarMonto(unUsuario){
return montoPorDerechoDeAutor + unUsuario.compania().cobrar() + self.ganancia() 
}
method ganancia(){
    return montoPorDerechoDeAutor * 0.25
}

}
class Nacional{
method cobrar(){
    return 0.05 * derechoDeAutor
}
}

class Iternacional inherits Nacional{
var impuesto
method configurarImpuesto(unImpuesto){
 impuesto  = unImpuesto
}
override method cobrar(){
    return super() + impuesto
}
}