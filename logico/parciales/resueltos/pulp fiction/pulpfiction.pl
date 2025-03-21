personaje(pumkin,     ladron([licorerias, estacionesDeServicio])). 
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])). 
personaje(vincent,    mafioso(maton)). 
personaje(jules,      mafioso(maton)). 
personaje(marsellus,  mafioso(capo)). 
personaje(winston,    mafioso(resuelveProblemas)). 
personaje(mia,        actriz([foxForceFive])). 
personaje(butch,      boxeador). 
 
pareja(marsellus, mia). 
pareja(pumkin,    honeyBunny). 
 
%trabajaPara(Empleador, Empleado) 
trabajaPara(marsellus, vincent). 
trabajaPara(marsellus, jules). 
trabajaPara(marsellus, winston).


%1 good
esPeligroso(Personaje):-
    personaje(Personaje, _),
    actividadPeligrosa(Personaje);
    tieneEmpleadosPeligrosos(Personaje).


actividadPeligrosa(Personaje):-
        personaje(Personaje, mafioso(maton));
        personaje(Personaje, ladron([licorerias,_])).

tieneEmpleadosPeligrosos(Personaje):-
    trabajaPara(Personaje, Empleado),
    actividadPeligrosa(Empleado).

%2 GOOD
amigo(vincent, jules). 
amigo(jules, jimmie). 
amigo(vincent, elVendedor).

duoTemible(Personaje1, Personaje2):-
    esPeligroso(Personaje1),
    esPeligroso(Personaje2),
    requisitos(Personaje1, Personaje2).

requisitos(Personaje1, Personaje2):-
    amigo(Personaje1,Personaje2).

requisitos(Personaje1, Personaje2):-
    pareja(Personaje1,Personaje2).
    

    
 
%encargo(Solicitante, Encargado, Tarea).  
%las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar) 
encargo(marsellus, vincent,   cuidar(mia)). 
encargo(vincent,  elVendedor, cuidar(mia)). 
encargo(marsellus, winston, ayudar(jules)). 
encargo(marsellus, winston, ayudar(vincent)). 
encargo(marsellus, vincent, buscar(butch, losAngeles)).
encargo(marsellus, jules, buscar(butch, losAngeles)).


%3 good
estaEnProblemas(Personaje):-
    trabajaPara(Jefe, Personaje),
    condiciones(Jefe, Personaje).

condiciones(Jefe, Personaje):-        
    esPeligroso(Jefe),
    pareja(Jefe, MujerJefe),
    encargo(Jefe, Personaje, cuidar(MujerJefe)).
    
condiciones(Personaje):-    
    encargo(Jefe, Personaje, buscar(Persona, _)),
    personaje(Persona, boxeador).


estaEnProblemas(butch).

%punto 4 good
sanCayetano(Personaje):-
    esPersonaje(Personaje),
 	tieneCerca(Personaje, _),
    forall(tieneCerca(Personaje, PersonaCercana),lesDaTrabajo(Personaje, PersonaCercana)).

esPersonaje(Personaje):-
    personaje(Personaje, _).

tieneCerca(Personaje, PersonaCercana):-
    amigo(Personaje, PersonaCercana).

tieneCerca(Personaje, PersonaCercana):-
    trabajaPara(Personaje, PersonaCercana).

lesDaTrabajo(Personaje, PersonaCercana):-
    encargo(Personaje, PersonaCercana, _).

%5 
masAtareado(Personaje) :-
    esPersonaje(Personaje),
    forall(personaje(Persona, _), tieneMasTareas(Personaje, Persona)).
       
tieneMasTareas(Personaje, Persona) :-
    cantidadDeTareasDe(Personaje, CantidadDeTareas),
    cantidadDeTareasDe(Persona, CantidadDeTareasPersona),    
    CantidadDeTareas >= CantidadDeTareasPersona.        
       
cantidadDeTareasDe(Personaje, CantidadDeTareas) :-
    findall(Tarea, tieneTarea(Personaje, Tarea), Tareas),
    length(Tareas, CantidadDeTareas).
    
tieneTarea(Personaje, Tarea) :-
    encargo(_, Personaje, Tarea).      


%6 good
esRespetable(Personaje):-
    personaje(Personaje, Labor),
    nivelDeRespeto(Labor, Nivel),
    Nivel > 9.

nivelDeRespeto(mafioso(resuelveProblemas), 10).
nivelDeRespeto(mafioso(maton), 1).
nivelDeRespeto(mafioso(capo), 20).

nivelDeRespeto(actriz(Peliculas), Respeto):-
	length(Peliculas, CantidadDePeliculas),
	Respeto is CantidadDePeliculas / 10.

nivelDeRespeto(Labor, 0) :-
    Labor \= mafioso(_),
    Labor \= actriz(_).
    

%7 

hartoDe(PersonajeHarto, Personaje2):-
    sonPersonajes(PersonajeHarto,Personaje2),
	tieneAlgunaTarea(PersonajeHarto),
    tieneQueAyudar(PersonajeHarto, Personaje2);
    tieneQueCuidar(PersonajeHarto, Personaje2);
    tieneQueBuscar(PersonajeHarto, Personaje2).

sonPersonajes(PersonajeHarto,Personaje2):-
    esPersonaje(PersonajeHarto),
    esPersonaje(Personaje2),
    PersonajeHarto \= Personaje2.
    
tieneAlgunaTarea(PersonajeHarto):-
    encargo(_,PersonajeHarto,_).

tieneQueCuidar(PersonajeHarto, Personaje2):-
    encargo(_, PersonajeHarto, cuidar(Personaje2)).

tieneQueCuidar(PersonajeHarto, Personaje2):-
    amigo(Personaje2, Amigo),
    encargo(_, PersonajeHarto, cuidar(Amigo)).

tieneQueBuscar(PersonajeHarto,Personaje2):-
    encargo(_, PersonajeHarto, buscar(Personaje2, _)).

tieneQueBuscar(PersonajeHarto,Personaje2):-
    amigo(Personaje2, Amigo),
    encargo(_, PersonajeHarto, buscar(Amigo, _)).

tieneQueAyudar(PersonajeHarto, Personaje2):-
    encargo(_, PersonajeHarto, ayudar(Personaje2)).

tieneQueAyudar(PersonajeHarto, Personaje2):-
    amigo(Personaje2, Amigo),
    encargo(_, PersonajeHarto, ayudar(Amigo)).



caracteristicas(vincent,  [negro, muchoPelo, tieneCabeza]). 
caracteristicas(jules,    [tieneCabeza, muchoPelo]). 
caracteristicas(marvin,   [negro]).

%8
duoDiferenciable(Personaje, OtroPersonaje):-
	caracteristicasDelPersonaje(Personaje, ListaDeCaracteristicas),
	caracteristicasDelPersonaje(OtroPersonaje, ListaDeCaracteristicasDelOtro),
	tieneUnaQueElOtroNo(ListaDeCaracteristicas, ListaDeCaracteristicasDelOtro),
	Personaje \= OtroPersonaje.
	
caracteristicasDelPersonaje(Personaje, ListaDeCaracteristicas):-
	caracteristicas(Personaje, ListaDeCaracteristicas).

tieneUnaQueElOtroNo(ListaDeCaracteristicas, ListaDeCaracteristicasDelOtro):-
	member(Caracteristica,ListaDeCaracteristicas),
	not(member(Caracteristica,ListaDeCaracteristicasDelOtro)).