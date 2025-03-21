%% Paradigmas de Programación - Recuperatorio Paradigma Lógico - Jueves Mañana
%% Prode
%% BASE DE CONOCIMIENTO

% resultado(UnPais, GolesDeUnPais, OtroPais, GolesDeOtroPais)
resultado(paises_bajos, 3, estados_unidos, 1).                      % Paises bajos 3 - 1 Estados unidos
resultado(australia, 1, argentina, 2).                              % Australia 1 - 2 Argentina
resultado(polonia, 3, francia, 1).
resultado(inglaterra, 3, senegal, 0).


% pronostico(Jugador, Pronostico)
pronostico(juan, gano(paises_bajos, estados_unidos, 3, 1)).         % 200 puntos
pronostico(juan, gano(argentina, australia, 3, 0)).                 % 100 puntos
pronostico(juan, empataron(inglaterra, senegal, 0)).                % 0 puntos
pronostico(gus, gano(estados_unidos, paises_bajos, 1, 0)).          % 0 puntos
pronostico(gus, gano(japon, croacia, 2, 0)).                        % 0 puntos (aun no jugaron)             
pronostico(lucas, gano(paises_bajos, estados_unidos, 3, 1)).        % 200 puntos
pronostico(lucas, gano(argentina, australia, 2, 0)).                % 100 puntos
pronostico(lucas, gano(croacia, japon, 1, 0)).                      % 0 puntos (aun no jugaron)

% Puntos totales juan: 300
% Puntos totales gus: 0
% Puntos totales lucas: 300

%% PUNTO 1
% Esto lo hago para que el predicado resultado sea simétrico
resultadoSimetrico(Pais1, Goles1, Pais2, Goles2) :- resultado(Pais1, Goles1, Pais2, Goles2).
resultadoSimetrico(Pais1, Goles1, Pais2, Goles2) :- resultado(Pais2, Goles2, Pais1, Goles1).

%% a) Jugaron
% jugaron(Pais1, Pais2, DiferenciaGol)
    % Relaciona dos países que hayan jugado un partido y la diferencia de goles entre ambos.

jugaron(Pais1, Pais2, DiferenciaGol) :-
    resultadoSimetrico(Pais1, Goles1, Pais2, Goles2),
    DiferenciaGol is (Goles1 - Goles2).

%% b) Gano
% gano(Pais1, Pais2)
    % Un país le ganó a otro si ambos jugaron y el ganador metió más goles que el otro 
    % Aca para establecer que el ganador metió más goles que el otro debemos plantear que la diferencia de gol del país ganador es positiva.

gano(PaisGanador, PaisPerdedor) :-
    jugaron(PaisGanador, PaisPerdedor, DiferenciaGol),
    DiferenciaGol > 0.
    
%% PUNTO 2: Puntos pronostico
% Un pronóstico es un functor de cualquiera de estas formas:
    % gano(PaisGanador, PaisPerdedor, GolesGanador, GolesPerdedor).
    % empataron(UnPais, OtroPais, GolesDeCualquieraDeLosDos).
% hayResultadoParaPartido(Pronostico)
    % Con esto estamos chequeando que los paises involucrados en el pronóstico hayan jugado.

hayResultadoParaPartido(gano(PaisGanador, PaisPerdedor, _, _)) :-
    jugaron(PaisGanador, PaisPerdedor, _).

hayResultadoParaPartido(empataron(UnPais, OtroPais, _)) :-
    jugaron(UnPais, OtroPais, _).


% puntosPronostico(Pronostico, Puntos)
    % Chequeamos si hay un resultado para el partido que se está pronosticando y luego se delega en otro predicado el cálculo de los puntos.

puntosPronostico(Pronostico, Puntos) :-
    hayResultadoParaPartido(Pronostico),
    calcularPuntos(Pronostico, Puntos).

% calcularPuntos(Pronostico, Puntos)
    % Aca tenemos los tres casos de cálculo de puntos.

calcularPuntos(Pronostico, 200) :-
    lePegoAlGanadorOEmpate(Pronostico),
    lePegoCantidadDeGoles(Pronostico).

calcularPuntos(Pronostico, 100) :-
    lePegoAlGanadorOEmpate(Pronostico),
    not(lePegoCantidadDeGoles(Pronostico)).

calcularPuntos(Pronostico, 0) :-
    not(lePegoAlGanadorOEmpate(Pronostico)).

% lePegoAlGanadorOEmpate(Pronostico)
lePegoAlGanadorOEmpate(gano(PaisGanador, PaisPerdedor, _, _)) :-
    gano(PaisGanador, PaisPerdedor).

lePegoAlGanadorOEmpate(empataron(Pais1, Pais2, Goles)) :-
    resultadoSimetrico(Pais1, Goles, Pais2, Goles).


% lePegoCantidadDeGoles(Pronostico)
lePegoCantidadDeGoles(gano(PaisGanador, PaisPerdedor, GolesGanador, GolesPerdedor)) :-
    resultadoSimetrico(PaisGanador, GolesGanador, PaisPerdedor, GolesPerdedor).

lePegoCantidadDeGoles(empataron(UnPais, OtroPais, Goles)) :-
    resultadoSimetrico(UnPais, Goles, OtroPais, Goles).

%% PUNTO 3: Invicto
% invicto(Jugador)
    % Un jugador está invicto si hizo algún pronóstico y para todo pronóstico que haya hecho para el cuál hay resultado del partido, sacó al menos 1 punto

invicto(Jugador) :-
    pronostico(Jugador, _),
    forall((pronostico(Jugador, Pronostico), hayResultadoParaPartido(Pronostico)), sacoAlMenos1Punto(Pronostico)).

% sacoAlMenos1Punto(Pronostico)
sacoAlMenos1Punto(Pronostico) :-
    puntosPronostico(Pronostico, Puntos),
    Puntos >= 1.


%% PUNTO 4: Puntaje
% puntaje(Jugador, TotalPuntos)
puntaje(Jugador, TotalPuntos) :-
    pronostico(Jugador, _),
    findall(Puntos, (pronostico(Jugador, Pronostico), puntosPronostico(Pronostico, Puntos)), PuntosDeLosPronosticos),
    sumlist(PuntosDeLosPronosticos, TotalPuntos).


%% PUNTO 5: Favorito
% favorito(Pais)
    % Un pais es favorito si:
        % - Todos los pronósticos que se hicieron sobre ese pais lo ponen como ganador
        % - O si todos los partidos que jugo los gano por goleada (por diferencia de 3 goles).

favorito(Pais) :-
    estaEnElPronostico(Pais, _),
    forall(estaEnElPronostico(Pais, Pronostico), loDaComoGanador(Pais, Pronostico)).

favorito(Pais) :-
    resultadoSimetrico(Pais, _, _, _),
    forall(jugaron(Pais, _, DiferenciaGol), DiferenciaGol >= 3).

% loDaComoGanador(Pais, Pronostico)
loDaComoGanador(Pais, gano(Pais, _, _, _)).

% estaEnElPronostico(Pais, Pronostico)
estaEnElPronostico(Pais, gano(Pais, OtroPais, Goles1, Goles2)) :-
    pronostico(_, gano(Pais, OtroPais, Goles1, Goles2)).
estaEnElPronostico(Pais, gano(OtroPais, Pais, Goles1, Goles2)) :-
    pronostico(_, gano(OtroPais, Pais, Goles1, Goles2)).
estaEnElPronostico(Pais, empataron(Pais, OtroPais, Goles)) :-
    pronostico(_, empataron(Pais, OtroPais, Goles)).
estaEnElPronostico(Pais, empataron(OtroPais, Pais, Goles)) :-
    pronostico(_, empataron(OtroPais, Pais, Goles)).
    