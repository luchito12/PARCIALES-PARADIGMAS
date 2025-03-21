% esPersonaje/1 nos permite saber qué personajes tendrá el juego
esPersonaje(aang).
esPersonaje(katara).
esPersonaje(zoka).
esPersonaje(appa).
esPersonaje(momo).
esPersonaje(toph).
esPersonaje(tayLee).
esPersonaje(zuko).
esPersonaje(azula).
esPersonaje(iroh).

% esElementoBasico/1 nos permite conocer los elementos básicos que pueden controlar algunos personajes
esElementoBasico(fuego).
esElementoBasico(agua).
esElementoBasico(tierra).
esElementoBasico(aire).

% elementoAvanzadoDe/2 relaciona un elemento básico con otro avanzado asociado
elementoAvanzadoDe(fuego, rayo).
elementoAvanzadoDe(agua, sangre).
elementoAvanzadoDe(tierra, metal).

% controla/2 relaciona un personaje con un elemento que controla
controla(zuko, rayo).
controla(toph, metal).
controla(katara, sangre).
controla(aang, aire).
controla(aang, agua).
controla(aang, tierra).
controla(aang, fuego).
controla(azula, rayo).
controla(iroh, rayo).

% visito/2 relaciona un personaje con un lugar que visitó. Los lugares son functores que tienen la siguiente forma:
% reinoTierra(nombreDelLugar, estructura)
% nacionDelFuego(nombreDelLugar, soldadosQueLoDefienden)
% tribuAgua(puntoCardinalDondeSeUbica)
% temploAire(puntoCardinalDondeSeUbica)
visito(aang, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(iroh, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(zuko, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(toph, reinoTierra(fortalezaDeGralFong, [cuartel, dormitorios, enfermeria, salaDeGuerra, templo, zonaDeRecreo])).
visito(aang, nacionDelFuego(palacioReal, 1000)).
visito(katara, tribuAgua(norte)).
visito(aang, tribuAgua(norte)).

visito(aang, tribuAgua(sur)).
visito(zuko, tribuAgua(sur)).
visito(iroh, tribuAgua(sur)).
visito(katara, tribuAgua(sur)).
visito(toph, tribuAgua(sur)).

visito(aang, temploAire(norte)).
visito(aang, temploAire(oeste)).
visito(aang, temploAire(este)).
visito(aang, temploAire(sur)).

%punto 1 good
esElAvatar(Personaje):-
    esPersonaje(Personaje),
    forall(controla(Personaje, ElementoBasico), esElementoBasico(ElementoBasico)).

%punto 2 goof

clasificacion(UnPersonaje, UnaClasificacion):-
    esPersonaje(UnPersonaje),
    clasificacionPersonaje(UnPersonaje, UnaClasificacion).
  
  clasificacionPersonaje(UnPersonaje, noEsMaestro):-
    not(controla(UnPersonaje, _)).
  
  clasificacionPersonaje(UnPersonaje, esMaestroPrincipiante):-
    controla(UnPersonaje, _),
    not(controlaElementoAvanzado(UnPersonaje)).
  
  controlaElementoAvanzado(UnPersonaje):-
    controla(UnPersonaje, UnElemento),
    elementoAvanzadoDe(_, UnElemento).
  
  clasificacionPersonaje(UnPersonaje, esMaestroAvanzado):-
    controlaElementoAvanzado(UnPersonaje).
  
  clasificacionPersonaje(UnPersonaje, esMaestroAvanzado):-
    esElAvatar(UnPersonaje).


%punto 3 good
sigueA(zuko,aang).

sigueA(Personaje,Personaje2):- 
    esPersonaje(Personaje),
    esPersonaje(Personaje2),
    Personaje2 \= Personaje,
   forall(visito(Personaje, Unlugar), visito(Personaje2, Unlugar)).
    

%punto 4 good
%dignoDeConocer(nombreDelLugar).

esDignoDeConocer(NombreDelLugar):- 
   visito(_, NombreDelLugar),
   dignoDeConocer(NombreDelLugar).

dignoDeConocer(temploAire(_)).
dignoDeConocer(tribuAgua(norte)).
dignoDeConocer(reinoTierra(_, Estructura)):-
    not(member(muro, Estructura)).

%punto 5 good
esPopular(NombreDelLugar):- 
    visito(_, NombreDelLugar),
    findall(Personaje, visito(Personaje, NombreDelLugar), PersonasQueVisitaron),
    length(PersonasQueVisitaron, CantidadDeVisitas),
    CantidadDeVisitas > 4.

%punto 6 
esPersonaje(bumi).
esPersonaje(suki).

controla(bumi, tierra).


visito(bumi, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo,
sectorMedio])).

visito(suki, nacionDelFuego(pricionMaximaSeguridad, 200)).


