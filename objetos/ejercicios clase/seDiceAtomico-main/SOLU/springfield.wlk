import centrales.*

class Region{
    const ciudades = []
    method centralQueMasPoduceEn(unaCiudad){
        return unaCiudad.centralQueMasProduce()
    }
}

object sringfield{
    const vientos = 10
    const riquesaSuelo =0.9
    method riquesaSuelo() = riquesaSuelo 
    const centrales= []
    const  necesidadEnergetica =1

    method produccionDeUnaCentral(unaCentral){
         unaCentral.produccion(self)
    }
    	method centralesContaminantes() {
		return centrales.filter({central => central.esContaminante()})
	}
   method cubrioNecesidads(){
    return necesidadEnergetica - self.suministroDeEnergia()
   }

   method suministroDeEnergia(){
    return centrales.sum({central => central.produccionEnergetica()})
   }
   method sonTodasContaminantes(){
    return centrales.all({unaCentral => unaCentral.esContaminante()})
   }

    method produccionDeCentralesContaminantes(){
   return self.centralesContaminantes().sum({unaCentral => unaCentral.produccion(self)})
    } 
    
    method estaAlHorno(){
        return self.produccionDeCentralesContaminantes() > 0.5 * necesidadEnergetica || self.sonTodasContaminantes()
    }
    method centralQueMasProduce(){
        return centrales.max({unaCentral => unaCentral.produccion(self)})
    }
}

object albuquerque {
    const centrales = [centralHidroElectrica]
  const rioCaudal = 150
  method caudalRio() = rioCaudal
  method centralQueMasProduce(){
        return centrales.max({unaCentral => unaCentral.produccion(self)})
    }
}


