%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parte 1 - Sombrero Seleccionador
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

casa(gryffindor).
casa(slytherin).
casa(hufflepuff).
casa(ravenclaw).

sangre(harry, mestiza).
sangre(draco, pura).
sangre(hermione, impura).
sangre(neville, pura).
sangre(luna, pura).

mago(Mago):-
  sangre(Mago, _).

% permiteEntrar(Casa, Mago)
permiteEntrar(Casa, Mago):-
  casa(Casa),
  mago(Mago),
  Casa \= slytherin.

permiteEntrar(slytherin, Mago):-
  sangre(Mago, TipoDeSangre),
  TipoDeSangre \= impura.

% tieneCaracteristica(Mago, Caracteristica)
tieneCaracteristica(harry, coraje).
tieneCaracteristica(harry, orgullo).
tieneCaracteristica(harry, amistad).
tieneCaracteristica(harry, inteligencia).

tieneCaracteristica(draco, inteligencia).
tieneCaracteristica(draco, orgullo).

tieneCaracteristica(hermione, inteligencia).
tieneCaracteristica(hermione, orgullo).
tieneCaracteristica(hermione, responsabilidad).

tieneCaracteristica(neville, responsabilidad).
tieneCaracteristica(neville, coraje).
tieneCaracteristica(neville, amistad).

tieneCaracteristica(luna, amistad).
tieneCaracteristica(luna, inteligencia).
tieneCaracteristica(luna, responsabilidad).

caracteristicaBuscada(gryffindor, coraje).
caracteristicaBuscada(slytherin, orgullo).
caracteristicaBuscada(slytherin, inteligencia).
caracteristicaBuscada(ravenclaw, inteligencia).
caracteristicaBuscada(ravenclaw, responsabilidad).
caracteristicaBuscada(hufflepuff, amistad).

tieneCaracterApropiado(Mago, Casa):-
  % todas las caracteristicas buscadas por la casa
  % las tiene ese mago
  casa(Casa),
  mago(Mago),
  forall(caracteristicaBuscada(Casa, Caracteristica), tieneCaracteristica(Mago, Caracteristica)).

odiariaEntrar(harry, slytherin).
odiariaEntrar(draco, hufflepuff).

puedeQuedarSeleccionadoPara(Mago, Casa):-
  tieneCaracterApropiado(Mago, Casa),
  permiteEntrar(Casa, Mago),
  not(odiariaEntrar(Mago, Casa)).

puedeQuedarSeleccionadoPara(hermione, gryffindor).

cadenaDeAmistades(Magos):-
  todosAmistosos(Magos),
  cadenaDeCasas(Magos).

todosAmistosos(Magos):-
  forall(member(Mago, Magos), amistoso(Mago)).

amistoso(Mago):-
  tieneCaracteristica(Mago, amistad).

% cadenaDeCasas(Magos)
/*
cadenaDeCasas([Mago1, Mago2 | MagosSiguientes]):-
  puedeQuedarSeleccionadoPara(Mago1, Casa),
  puedeQuedarSeleccionadoPara(Mago2, Casa),
  cadenaDeCasas([Mago2 | MagosSiguientes]).
cadenaDeCasas([_]).
cadenaDeCasas([]).
*/

cadenaDeCasas(Magos):-
  forall(consecutivos(Mago1, Mago2, Magos), puedenQuedarEnLaMismaCasa(Mago1, Mago2, _)).

consecutivos(Anterior, Siguiente, Lista):-
  nth1(IndiceAnterior, Lista, Anterior),
  IndiceSiguiente is IndiceAnterior + 1,
  nth1(IndiceSiguiente, Lista, Siguiente).

puedenQuedarEnLaMismaCasa(Mago1, Mago2, Casa):-
  puedeQuedarSeleccionadoPara(Mago1, Casa),
  puedeQuedarSeleccionadoPara(Mago2, Casa),
  Mago1 \= Mago2.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parte 2 - La copa de las casas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hizo(harry, fueraDeCama).
hizo(hermione, irA(tercerPiso)).
hizo(hermione, irA(seccionRestringida)).
hizo(harry, irA(bosque)).
hizo(harry, irA(tercerPiso)).
hizo(draco, irA(mazmorras)).
hizo(ron, buenaAccion(50, ganarAlAjedrezMagico)).
hizo(hermione, buenaAccion(50, salvarASusAmigos)).
hizo(harry, buenaAccion(60, ganarleAVoldemort)).
hizo(cedric, buenaAccion(100, ganarAlQuidditch)).
hizo(hermione, responderPregunta(dondeSeEncuentraUnBezoar, 20, snape)).
hizo(hermione, responderPregunta(comoHacerLevitarUnaPluma, 25, flitwick)).

hizoAlgunaAccion(Mago):-
  hizo(Mago, _).

hizoAlgoMalo(Mago):-
  hizo(Mago, Accion),
  puntajeQueGenera(Accion, Puntaje),
  Puntaje < 0.

puntajeQueGenera(fueraDeCama, -50).

puntajeQueGenera(irA(Lugar), PuntajeQueResta):-
  lugarProhibido(Lugar, Puntos),
  PuntajeQueResta is Puntos * -1.

puntajeQueGenera(buenaAccion(Puntaje, _), Puntaje).

puntajeQueGenera(responderPregunta(_, Dificultad, snape), Puntos):-
  Puntos is Dificultad // 2.

puntajeQueGenera(responderPregunta(_, Dificultad, Profesor), Dificultad):- Profesor \= snape.


lugarProhibido(bosque, 50).
lugarProhibido(seccionRestringida, 10).
lugarProhibido(tercerPiso, 75).

esBuenAlumno(Mago):-
  hizoAlgunaAccion(Mago),
  not(hizoAlgoMalo(Mago)).
%% 1b

% hizo(Mago, Accion).

esRecurrente(Accion):-
  hizo(Mago, Accion),
  hizo(OtroMago, Accion),
  Mago \= OtroMago.

% 2

esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).
esDe(cedric, hufflepuff).

puntajeTotalDeCasa(Casa, PuntajeTotal):-
  esDe(_, Casa),
  findall(Puntos, (esDe(Mago, Casa), puntosQueObtuvo(Mago, _, Puntos)), ListaPuntos),
  sum_list(ListaPuntos, PuntajeTotal).

puntosQueObtuvo(Mago, Accion, Puntos):-
  hizo(Mago, Accion),
  puntajeQueGenera(Accion, Puntos).

% 3

casaGanadora(Casa):-
  puntajeTotalDeCasa(Casa, PuntajeMayor),
  forall((puntajeTotalDeCasa(OtraCasa, PuntajeMenor), Casa \= OtraCasa), PuntajeMayor > PuntajeMenor).

casaGanadora2(Casa):-
  puntajeTotalDeCasa(Casa, PuntajeMayor),
  not((puntajeTotalDeCasa(_, OtroPuntaje), OtroPuntaje > PuntajeMayor)).