% Parcial Logico

% Base de conocimiento

% nombre, su rating y su civilización favorita. 
jugador(juli, 2200, jemeres).
jugador(aleP, 1600, mongoles).
jugador(feli, 500000, persas).
jugador(aleC, 1723, otomanos).
jugador(ger, 1729, ramanujanos).
jugador(juan, 1515, britones).
jugador(marti, 1342, argentinos).

%También sabemos qué unidades, recursos y edificios tiene cada jugador.
tiene(aleP, unidad(samurai, 199)).
tiene(aleP, unidad(espadachin, 10)).
tiene(aleP, unidad(granjero, 10)).
tiene(aleP, recurso(800, 300, 100)).
tiene(aleP, edificio(casa, 40)).
tiene(aleP, edificio(castillo, 1)).
tiene(juan, unidad(carreta, 10)).
tiene(carolina, unidad(granjero, 1)).

% De las unidades sabemos que pueden ser militares o aldeanos. 
% De los militares sabemos su tipo, cuántos recursos cuesta y a qué categoría pertenece.
% De los aldeanos sabemos su tipo y cuántos recursos por minuto produce. Su categoría es aldeano.

% militar(Tipo, costo(Madera, Alimento, Oro), Categoria).
militar(espadachin, costo(0, 60, 20), infanteria).
militar(arquero, costo(25, 0, 45), arqueria).
militar(mangudai, costo(55, 0, 65), caballeria).
militar(samurai, costo(0, 60, 30), unica).
militar(keshik, costo(0, 80, 50), unica).
militar(tarcanos, costo(0, 60, 60), unica).
militar(alabardero, costo(25, 35, 0), piquero).
% … y muchos más tipos pertenecientes a estas categorías.

% aldeano(Tipo, produce(Madera, Alimento, Oro)).
aldeano(lenador, produce(23, 0, 0)).
aldeano(granjero, produce(0, 32, 0)).
aldeano(minero, produce(0, 0, 23)).
aldeano(cazador, produce(0, 25, 0)).
aldeano(pescador, produce(0, 23, 0)).
aldeano(alquimista, produce(0, 0, 25)).
% … y muchos más también

% edificio(Edificio, costo(Madera, Alimento, Oro)).
edificio(casa, costo(30, 0, 0)).
edificio(granja, costo(0, 60, 0)).
edificio(herreria, costo(175, 0, 0)).
edificio(castillo, costo(650, 0, 300)).
edificio(maravillaMartinez, costo(10000, 10000, 10000)).
% … y muchos más también


% Punto 1 %

esUnAfano(Nombre1, Nombre2):-
    jugador(Nombre1, Rating1, _),
    jugador(Nombre2, Rating2, _),
    abs(Rating1 - Rating2) > 500.

% Punto 2 %

esEfectivo(Tipo1, Tipo2):-
    esMilitar(Tipo1, _, Categoria1),
    esMilitar(Tipo2, _, Categoria2),
    puedeGanarSegunCategoria(Categoria1, Categoria2).

esEfectivo(samurai, Tipo):-
    esMilitar(Tipo, _, unica).

puedeGanarSegunCategoria(caballeria, arqueria).
puedeGanarSegunCategoria(arqueria, infanteria).
puedeGanarSegunCategoria(infanteria, piqueros).
puedeGanarSegunCategoria(piqueros, caballeria).

esMilitar(Tipo, Costo, Categoria):-
    militar(Tipo, Costo, Categoria).

% Punto 3 %

alarico(Nombre):-
    tiene(Nombre, _),
    soloTieneUnidadMilitarDe(infanteria, Nombre).
    
% Punto 4 %

leonidas(Nombre):-
    tiene(Nombre, _),
    soloTieneUnidadMilitarDe(piquero, Nombre).

soloTieneUnidadMilitarDe(Categoria, Nombre):-
    forall(tiene(Nombre, unidad(Tipo, _)), esMilitar(Tipo, _, Categoria)).

% Punto 5 %

nomada(Nombre):-
    tiene(Nombre, _),
    not(tieneAlgunEdificio(Nombre, casa)).

tieneAlgunEdificio(Nombre, TipoDeEdificio):-
    tiene(Nombre, edificio(TipoDeEdificio, _)).

% Punto 6 %
% Interpreto como que se quiere saber costo(Madera, Alimento, Oro)

cuantoCuesta(Tipo, Costo):-
    esMilitar(Tipo, Costo, _).

cuantoCuesta(Tipo, Costo):-
    esEdificio(Tipo, Costo).

cuantoCuesta(Tipo, costo(0, 50, 0)):-
    esAldeano(Tipo, _).

cuantoCuesta(Tipo, costo(100, 0, 50)):-
    esCarretaOUrna(Tipo).

esCarretaOUrna(carreta).
esCarretaOUrna(urnaMercante).

esEdificio(Tipo, Costo):-
    edificio(Tipo, Costo).

esAldeano(Tipo, Produccion):-
    aldeano(Tipo, Produccion).

% Punto 7 %
% produccion(madera, alimento, oro)

produccion(Tipo, ProduccionPorMinuto):-
    esAldeano(Tipo, ProduccionPorMinuto).

produccion(Tipo, produccion(0, 0, 32)):-
    esCarretaOUrna(Tipo).

% "Las unidades militares no producen ningún recurso", produce (0, 0, 0) no false
produccion(Tipo, produccion(0, 0, Oro)):-
    esMilitar(Tipo, _, _),
    evaluarOro(Tipo, Oro).

evaluarOro(keshik, 10).
evaluarOro(_, 0).

% Punto 8 %

produccionTotal(Nombre, Recurso, ProduccionTotalPorMinuto):-
    tiene(Nombre, _),
    recursos(Recurso),
    findall(Produccion, loTieneYProduce(Nombre, Recurso, Produccion), ListaDeProduccion),
    sum_list(ListaDeProduccion, ProduccionTotalPorMinuto).

% aca hago tiene(Nombre, unidad(...)). Lo hago con "unidad" porque interpreto que los jugadores tienen
% unidades -->  Pueden ser militar o aldeano (hay que ver cual, porque militar no produce, solo tiene costo pero
%               el aldeano produce).
% recursos -->  Nunca aclara que es pero asumo que son los recursos que tiene el jugador. No cuenta como produccion.
% edificios --> solo tiene costo, no produce.

loTieneYProduce(Nombre, Recurso, Produccion):-
    tiene(Nombre, unidad(Tipo, CuantasTiene)),
    produccion(Tipo, ProduccionTotal),
    produccionDelRecurso(Recurso, ProduccionTotal, ProduccionRecurso),
    Produccion is ProduccionRecurso * CuantasTiene.

% me parece mas ordenado dejar el predicado produccion como esta (con el functor como parametro) y hacer esto para
% obtener la produccion especifica para que no me quede un predicado con aridad muy alta.

produccionDelRecurso(madera, produccion(Madera, _, _), Madera).
produccionDelRecurso(alimento, produccion(_, Alimento, _), Alimento).
produccionDelRecurso(oro, produccion(_, _, Oro), Oro).

recursos(oro).
recursos(madera).
recursos(alimento).

% Punto 9 % no llegue a terminarlo

/*
Definir el predicado estaPeleado/2 que se cumple para dos jugadores cuando no es un afano para ninguno,
tienen la misma cantidad de unidades y la diferencia de valor entre su producción total de recursos por
minuto es menor a 100. ¡Pero cuidado! No todos los recursos valen lo mismo: el oro vale cinco veces su cantidad;
la madera, tres veces; y los alimentos, dos veces.
*/
/*
estaPelado(Nombre1, Nombre2):-
    not(esUnAfano(Nombre1, Nombre2)),
    cantidadDeUnidades(Nombre1, Cantidad),
    cantidadDeUnidades(Nombre2, Cantidad),
    verProduccionSegun(Recurso, Nombre1, Nombre2),
 
verProduccionSegun(oro, Nombre1, Nombre2):-


produccionesTotales(Nombre1, Nombre2, Produccion1, Produccion2):-
    produccionTotal(Nombre1, Recurso, ProduccionTotalPorMinuto)

cantidadDeUnidades(Nombre, Cantidad):-
    findall(Unidad, (tiene(Nombre, Cosa), esUnidad(Cosa)), Unidades),
    length(Unidades, Cantidad).

esUnidad(undad(_,_)).
*/

% Punto 10 %

avanzaA(Nombre, Edad):-
    jugador(Nombre, _, _),
    avanzaSegun(Nombre, Edad).

avanzaSegun(_, edadMedia).

avanzaSegun(Nombre, edadFeudal):-
    cumpleAlimento(Nombre, 500),
    tieneAlgunEdificio(Nombre, casa).

avanzaSegun(Nombre, edadDeLosCastillos):-
    cumpleAlimento(Nombre, 800),
    cumpleOro(Nombre, 200),
    edificioFeudal(EdificioFeudal),
    tieneAlgunEdificio(Nombre, EdificioFeudal).

avanzaSegun(Nombre, edadImperial):-
    cumpleAlimento(Nombre, 1000),
    cumpleOro(Nombre, 800),
    edificioImperial(edificioImperial),
    tieneAlgunEdificio(Nombre, edificioImperial).

cumpleAlimento(Nombre, Cantidad):-
    recursosPersona(Nombre, _, Alimento, _),
    Alimento > Cantidad.

cumpleOro(Nombre, Cantidad):-
    recursosPersona(Nombre, _, _, Oro),
    Oro > Cantidad.

edificioDeEdadFeudal(herreria).
edificioDeEdadFeudal(establo).
edificioDeEdadFeudal(galeriaDeTiro).

edificioImperial(castillo).
edificioImperial(universidad).

recursosPersona(Nombre, Madera, Alimento, Oro):-
    tiene(Nombre, recuso(Madera, Alimento, Oro)).
