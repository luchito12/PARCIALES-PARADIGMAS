class Adulto{
    const niniosQueIntenraronAsustarme =[]
    
    method niniosConMasDeXCaramelos(unaCantidad){
       return niniosQueIntenraronAsustarme.filter({unNinio => unNinio.cantidadDeCaramelos() > unaCantidad})
    }
    method tolerancia(){
        return 10 * self.niniosConMasDeXCaramelos(15)
    }
    
    method darCaramelos(unNinio){
         unNinio.recibirCaramelos(self.tolerancia().div(2))
    }
    method serAsustadoPor(unNinio){
        if(self.tolerancia() < unNinio.capacidadDeAsustar()){
            self.darCaramelos(unNinio)
        }

    }
}


class Abuelo inherits Adulto{
    override method serAsustadoPor(unNinio){
        self.darCaramelos(unNinio)
    }

    override method darCaramelos(unNinio){
        super(unNinio) / 2
    }

 
}

class Necio inherits Adulto{
    override method serAsustadoPor(unNinio) {
      
    }
}