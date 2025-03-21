object pamela {
	var energia = 6000
	var botiquin = ["algodón", "aguaOxigenada", "cintaDePapel", "cintaDePapel"]
	const gritoDeVictoria = "Acá pasó la Pamela"
	
	method equipamiento() = botiquin
	
	method energia() = energia
	
	method gritoDeVictoria() = gritoDeVictoria
	
	method estaVivo() = energia > 0
		
	method cantidadDeEquipamiento() = botiquin.size()
	
	method luchar(unEnemigo) {
		energia += 400
	}
	
	method perderEnergia(unaCantidad) {
		energia -= unaCantidad
	}
	
	method ultimoObjeto() = botiquin.last()
	
	method perderUltimoObjeto() {
		botiquin.remove(self.ultimoObjeto())
	}
}

object pocardo {
	var energia = 5600
	var botiquin = ["guitarra", "curitas", "cotonetes"]
	const gritoDeVictoria = "¡Siente el poder de la música!"
	
	method equipamiento() = botiquin

	method energia() = energia
	
	method estaVivo() = energia > 0
	
	method gritoDeVictoria() = gritoDeVictoria
		
	method cantidadDeEquipamiento() = botiquin.size()
	
	method luchar(unEnemigo) {
		energia += 500
	}
	
	method perderEnergia(unaCantidad) {
		energia -= unaCantidad
	}
	
	method ultimoObjeto() = botiquin.last()
	
	method perderUltimoObjeto() {
		botiquin.remove(self.ultimoObjeto())
	}
	
}

object tulipan {
	var energia = 8400
	var galpon = ["rastrillo", "manguera", "maceta", "maceta"]
	const gritoDeVictoria = "Hora de cuidar a las plantas"
	
	method energia() = energia

	method equipamiento() = galpon
	
	method gritoDeVictoria() = gritoDeVictoria
	
	method estaVivo() = energia > 0
			
	method cantidadDeEquipamiento() = galpon.size()
	
	method luchar(unEnemigo) {
		unEnemigo.perderEnergia(unEnemigo.energia() * 0.5)
	
	}
	
	method perderEnergia(unaCantidad) {
		energia -= unaCantidad
	}
	
	method ultimoObjeto() = galpon.last()
	
	method perderUltimoObjeto() {
		galpon.remove(self.ultimoObjeto())
	}
}

object toro {
	var energia = 7800
	var botin = #{}
	const gritoDeVictoria = "No se metan con el toro"
	
	method equipamiento() = botin

	method energia() = energia
	
	method gritoDeVictoria() = gritoDeVictoria
	
	method estaVivo() = energia > 0
		
	method cantidadDeEquipamiento() = botin.size()
	
	method luchar(unEnemigo) {
		self.quitarEnergiaPorObjeto(unEnemigo)
		self.quitarElUltimoObjeto(unEnemigo)
	}
	
	method perderEnergia(unaCantidad) {
		energia -= unaCantidad
	}
	
method quitarEnergiaPorObjeto(unEnemigo){
  unEnemigo.perderEnergia(200 * unEnemigo.cantidadDeEquipamiento())
}

method TengoObjeto(unObjeto){
    return botin.contains(unObjeto)
  }
method quitarElUltimoObjeto(unEnemigo){
	if(!self.TengoObjeto(unEnemigo.ultimoObjeto())){
    const ultimoObjeto = unEnemigo.ultimoObjeto()
    botin.add(ultimoObjeto)
		unEnemigo.perderUltimoObjeto()
    }
    
}
	
}