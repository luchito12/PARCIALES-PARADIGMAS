
//_murallas_: su valor depende de su longitud, a razón de 10 monedas por unidad de medida.
class Muralla {
const longitud 
const precioPorUnidad

method valor(){
    return longitud * precioPorUnidad
}
}
//_museo_: su valor se calcula como su superficie cubierta multiplicada por su índice de importancia, que va de 1 a 5. 
class Museo {
    const superficieCubierta
    const indiceDeImportancia
    
    
    method valor(){
        return superficieCubierta * indiceDeImportancia
    }
}