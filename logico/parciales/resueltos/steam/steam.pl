juego(accion(callOfDuty), 5).
juego(accion(batmanAA), 10). 
juego(mmorpg(wow, 5000000), 30). 
juego(mmorpg(lineage2, 6000000), 15).  
juego(puzzle(plantsVsZombies, 40, media), 10). 
juego(puzzle(tetris, 10, facil), 0).


oferta(callOfDuty, 10). 
oferta(plantsVsZombies, 50).
oferta(lineage2, 60).

usuario(nico, [plantsVsZombies, tetris], [compra(lineage2)]). 
usuario(fede, [callOfDuty], [regalo(callOfDuty, nico), regalo(wow, nico)]). 
usuario(rasta, [lineage2, wow], []). 
usuario(agus, [], []). 
usuario(felipe, [plantsVsZombies], [compra(tetris)]).

%1 good
cuantoSale(Juego, Precio):-
    esUnJuego(Juego),
    precioJuego(Juego, Precio).

esUnJuego(Juego):-
    juego(accion(Juego), _);
    juego(mmorpg(Juego, _), _);
    juego(puzzle(Juego, _, _), _).


precioJuego(Juego, Precio):-  precioOriginal(Nombre, Precio).

precioJuego(Nombre, Precio) :-
    oferta(Nombre, Descuento),
    precioOriginal(Nombre, PrecioOriginal),
    Precio is PrecioOriginal * (1 - Descuento / 100).

precioOriginal(Nombre, Precio):- precioOriginal(accion(Juego), Precio).
precioOriginal(Nombre, Precio):- precioOriginal(mmorpg(Juego, _), Precio).
precioOriginal(Nombre, Precio):- precioOriginal(puzzle(Juego, _, _), Precio).



%2 GOOD
juegoPopular(accion(_)).
juegoPopular(mmorpg(_,Usuarios)) :- integer(Usuarios),Usuarios > 1000000.
juegoPopular(puzzle(_,_,facil)).
juegoPopular(puzzle(_, 25, _)).


%3 goood
tieneUnBuenDescuento(Juego):-
    esUnJuego(Juego),
    tieneDescuento(Juego, Descuento),
    Descuento > 50.

tieneDescuento(Juego, Descuento):-
    oferta(Juego, Descuento).

%4 good
adictoALosDescuentos(Usuario):-
    usuario(Usuario, _, Juegos),
    Juegos \= [],
    forall(adquirio(Juego, Juegos), tieneUnBuenDescuento(Juego)).

adquirio(Juego, Juegos):- member(compra(Juego), Juegos).
adquirio(Juego, Juegos):- member(regalo(Juego, _), Juegos).
    
%5
fanaticoDe(Usuario, Genero):-
    Juegos \= [],
    usuario(Usuario, Juegos , _),
    tieneDosJuegosDe(Juegos, Genero).

tieneDosJuegosDe(Juegos, Genero):-
    member(Juego1, Juegos),
    member(Juego2, Juegos),
    esDelGenero(Juego1, Genero),
    esDelGenero(Juego2, Genero),
    Juego1 \= Juego2.

esDelGenero(accion(_), accion).
esDelGenero(mmorpg(_, _), mmorpg).
esDelGenero(puzzle(_, _, _), puzzle).

%6 GOOD
monotematico(Usuario, Genero):-
    usuario(Usuario,Juegos,_),
    Juegos \= [],
    forall(juegoEnBiblioteca(Juego, Juegos), esDelGenero(Juego, Genero)).

juegoEnBiblioteca(Juego, Juegos):- member(accion(Juego), Juegos).
juegoEnBiblioteca(Juego, Juegos):- member(mmorpg(Juego,_), Juegos).
juegoEnBiblioteca(Juego, Juegos):- member(puzzle(Juego,_,_), Juegos).

%7
buenosAmigos(Usuario1, Usuario2):-
    usuario(Usuario1, _, Adquisiciones1),
    usuario(Usuario2, _, Adquisiciones2),
    regalaJuegoPopular(Usuario1, Usuario2, Adquisiciones1),
    regalaJuegoPopular(Usuario1, Usuario2, Adquisiciones2).

regalaJuegoPopular(Usuario1, Usuario2, Adquisiciones):-
    usuario(Usuario1, _, Adquisiciones),
    member(regalo(Juego, Usuario2), Adquisiciones),
    juegoPopular(Juego).


%8
cuantoGastara(Usuario, GastoTotal) :-
    usuario(Usuario, _, Adquisiciones),
    findall(Costo, (member(Adquisicion, Adquisiciones), costoAdquisicion(Adquisicion, Costo)), Costos),
    sumlist(Costos, GastoTotal).
    
costoAdquisicion(compra(Juego), Costo) :- cuantoSale(Juego, Costo).
costoAdquisicion(regalo(Juego,_), Costo) :- cuantoSale(Juego, Costo).