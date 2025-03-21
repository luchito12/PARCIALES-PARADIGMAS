%primeraMarca(Marca)
primeraMarca(laSerenisima).
primeraMarca(gallo).
primeraMarca(vienisima).

%precioUnitario(Producto,Precio)
%donde Producto puede ser arroz(Marca), lacteo(Marca,TipoDeLacteo), salchicas(Marca,Cantidad)
precioUnitario(arroz(gallo),25.10).
precioUnitario(lacteo(laSerenisima,leche), 6.00).
precioUnitario(lacteo(laSerenisima,crema), 4.00).
precioUnitario(lacteo(gandara,queso(gouda)), 13.00).
precioUnitario(lacteo(vacalin,queso(mozzarella)), 12.50).
precioUnitario(salchichas(vienisima,12), 9.80).
precioUnitario(salchichas(vienisima, 6), 5.80).
precioUnitario(salchichas(granjaDelSol, 8), 5.10).

%compro(Cliente,Producto,Cantidad)
compro(juan,lacteo(laSerenisima,crema),2).

%1
%descuento(Producto, Descuento)
descuento(lacteo(laSerenisima,leche), 0.20).
descuento(lacteo(laSerenisima,crema), 0.70).
descuento(lacteo(gandara,queso(gouda)), 0.70).
descuento(lacteo(vacalin,queso(mozzarella)), 0.05).
descuento(arroz(Marca), 1.5):-producto(arroz(Marca)).
descuento(salchichas(Marca, Cantidad), 0.5):- producto(salchichas(Marca, Cantidad)), 
    Marca \= vienisima.
descuento(lacteo(Marca, leche), 2):- producto(lacteo(Marca, leche)).
descuento(lacteo(Marca, queso(PrimeraMarca)), 2):-producto(lacteo(Marca, queso(PrimeraMarca))),
    primeraMarca(Marca).
descuento(Producto, Descuento):-mayorPrecio(Producto, Precio), Descuento is Precio * 0.05.

producto(Producto):-precioUnitario(Producto, _).

mayorPrecio(Producto, Precio):- precioUnitario(Producto, Precio), 
    forall(precioUnitario(_, OtroPrecio), Precio >= OtroPrecio).

