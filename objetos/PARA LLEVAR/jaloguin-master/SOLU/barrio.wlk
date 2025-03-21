  
  class Barrio{
    const habitantes = []
    method losTresNiniosQueMasCaramelosTienen() {
    return self.ordenarALesPibesPorCaramelos().take(3)
  }
  
  method ordenarALesPibesPorCaramelos() {
    return habitantes.sortedBy { unNinio, otroNinio => unNinio.caramelos() > otroNinio.caramelos() }
  }
  
    method elementosSinRepetidosUsadosPorLosNiniosConMasDe10Caramelos() {
    return self.niñosConMasDe10Caramelos().flatMap { unNinio => unNinio.elementosQueLLeva() }.asSet()
  }
  
    method niñosConMasDe10Caramelos() {
    return habitantes.filter { unChico => unChico.caramelos() > 10 }
  }

  }
  