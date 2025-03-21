class Legiones{
    const miembros = []
    method capacidadDeAsustar(){
        return miembros.sum({unMiembro => unMiembro.capacidadDeAsustar()})
    } 
    method caramelosDeLaLegion(){
        return miembros.sum()({unMiembro => unMiembro.cantidadDeCaramelos()})
    }
    method intentarAsustar(unAdulto){
        unAdulto.serAsustadoPor(self)
    }
    method lider() {
      return miembros.max({unMiembro => unMiembro.capacidadDeAsustar()})
    }
    method recibirCaramelos(unaCantidad) {
      self.lider().recibirCaramelos(unaCantidad) 
    }

    method validarMiembros(unosMiembros) {
    if(unosMiembros.size() < 2) {
      throw new LegionException(message = "Una legión debe tener al menos 2 miembros!")
    }  	
  }
    method crearLegion(unosMiembros){
        self.validarMiembros(unosMiembros)
        miembros.add(unosMiembros)
        
    }

    
    
}

class LegionException inherits Exception {}
