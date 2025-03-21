object imdep {
    const listaArtistas = #{}
    const listaPeliculas = #{}

  method artistaConMejorPaga(){
    return listaArtistas.max({unArtista => unArtista.sueldo()})
  }
  method listaDePeliculasEconomicas(){
    return listaPeliculas.filter({unaPelicula => unaPelicula.peliculaEconomica()})
  }

  method sumaDeGananciasPelisEconomicas(){
    return self.listaDePeliculasEconomicas().sum({unaPelicula => unaPelicula.ganacia()})
  }
}