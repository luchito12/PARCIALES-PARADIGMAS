class Arbol{
    const material 
    const regalos = #{}
    const tarjetas = #{}
    const adornos = []
    
    method capacidadContenerRegalos()
    
    method hayCapacidad(){
        return regalos.size() < self.capacidadContenerRegalos() 
    }
    
    method agregarRegalo(unRegalo){
        if(self.hayCapacidad()){
            regalos.add(unRegalo)
        }else {
            throw new NoHayMasLugarEnElArbolException(message = "Este arbol ya esta lleno de regalos")
        }
    }
    
    method beneficiariosArbol(){
        return self.beneficiariosDe(regalos) + self.beneficiariosDe(tarjetas)
    }
    
    method beneficiariosDe(unosPresentes) = unosPresentes.map({unPresente => unPresente.destinatario()})

    method costoTotalGastadoPorBenefactores() {
      return self.gastoDeBenefactores(regalos)
    }
    
    method gastoDeBenefactores(unosPresentes) = unosPresentes.sum({unPresente => unPresente.precio()})
        
    method importanciaDeAdornos() = adornos.sum({unAdorno => unAdorno.importancia()})
    
    method adornoMasPesado(){
        return adornos.max({unAdorno => unAdorno.peso()})
    }

    method regalosParaPersonasMuyQueridas() = regalos.filter({unRegalo => unRegalo.esDelTipoTeQuierenMucho(self.umbralDePrecio())})

    method umbralDePrecio(){
     return self.costoTotalGastadoPorBenefactores() / regalos.size()  
    }

     method hayTarjetasCaras() = tarjetas.any({unaTarjeta => unaTarjeta.esCara()})

    method esPortentoso() =  self.regalosParaPersonasMuyQueridas().size() > 5 || self.hayTarjetasCaras()


}


class ArbolNatural inherits Arbol{
    const vejez
    const tamañoTronco
 override method capacidadContenerRegalos(){
    return vejez*tamañoTronco
}
}

class ArbolArtificil inherits Arbol{
    const cantidadVaras
    override method capacidadContenerRegalos(){
    return cantidadVaras
}
}

class Regalo{
    const precio
    const destinatario
    method destinaratio() = destinatario
    method precio() = precio
    method esDelTipoTeQuierenMucho(unUmbral) = precio > unUmbral

}

class Tarjeta{
    method destinaratio() = destinatario
    const destinatario
    const valorAdjunto
    method precio() = 2
    const ocupaEspacio = false
    
    method esCara() = valorAdjunto >= 1000


}

class Adorno{
    const peso
    const coeficiente

    method peso() = peso

    method importancia(){
        return self.peso() * coeficiente

    }

}


class Luces inherits Adorno{
const cantidadDeLamparitas

override method importancia(){
    return super() * self.luminosidad()
}

method luminosidad() = cantidadDeLamparitas
}

class Figuras inherits Adorno{
    const volumen
    override method importancia(){
        return super() + volumen
    }
}

class Guirnaldas inherits Adorno{
    const añoDeCompra
    method aniosDeUso() = new Date().year() - añoDeCompra

    
    override method peso(){
        return peso -100 * self.aniosDeUso()
    }
    

}

class NoHayMasLugarEnElArbolException inherits Exception{}