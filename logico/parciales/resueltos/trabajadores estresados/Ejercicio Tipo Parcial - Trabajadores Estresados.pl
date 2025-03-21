
%% quedaEn(lugar, lugar)
quedaEn(venezuela, america).
quedaEn(argentina, america).
quedaEn(patagonia, argentina).
quedaEn(aula522, utn). % Sí, un aula es un lugar!
quedaEn(utn, caba).
quedaEn(caba, argentina).

%nacioEn(Trabajador, Lugar)
nacioEn(dani, caba).
nacioEn(alf, caba).
nacioEn(nico, caba).

%hizoTarea(Persona, TipoTarea, Fecha )
hizoTarea(dani, tomarExamen(paradigmLogico,aula522), fecha(10, 8, 2022)).
hizoTarea(dani, hacerUnGol(primeraDivision, caba), fecha(10, 8, 2022)).
hizoTarea(alf, hacerDiscurso(0, utn),fecha(11, 08, 2022) ).

%1
nuncaSalioDeCasa(Trabajador):-nacioEn(Trabajador, Lugar), 
forall(hizoTarea(Trabajador, TipoTarea, _), lugarTarea(TipoTarea, Lugar)).

lugarTarea(tomarExamen(_, Lugar), Lugar).
lugarTarea(hacerUnGol(_, Lugar), Lugar).
lugarTarea(hacerDiscurso(_, Lugar), Lugar).


%nuncaSalioDeCasaNot(Trabajador):-nacioEn(Trabajador, Lugar), 
%not((hizoTareaEnLugar(Trabajador, OtroLugar), OtroLugar \= Lugar)).

%hizoTareaEnLugar(Trabajador, Lugar):- hizoTarea(Trabajador, TipoTarea, _), 
%lugarTarea(TipoTarea, Lugar). 


%2
esEstresante(Tarea):-
hizoTarea(_, Tarea, _), 
lugarTarea(Tarea, Lugar), 
pertenece(Lugar, argentina), 
cumpleCondicionEstresante(Tarea).

pertenece(Lugar, OtroLugar):-quedaEn(Lugar, OtroLugar).

%pertenece(Lugar, OtroLugar):-quedaEn(Lugar, Lugar2), pertenece(Lugar2, OtroLugar).

cumpleCondicionEstresante(tomarExamen(Tema, _)):- esComplejo(Tema).
cumpleCondicionEstresante(hacerDiscurso(Cantidad, _)):- Cantidad > 30000.
cumpleCondicionEstresante(hacerUnGol(_, _)).

esComplejo(paradigmLogico).
esComplejo(analisMatematico).

%3
calificacion(Trabajador, Calificacion):- 
    trabajador(Trabajador), 
    calificarSegun(Trabajador, Calificacion).

trabajador(Persona):-
hizoTarea(Persona, _, _).

calificarSegun(Persona, zen):-forall(hizoTarea(Persona, Tarea, _), not(esEstresante(Tarea))).
calificarSegun(Persona, locos):- forall(hizoTarea(Persona, Tarea, fecha(_, _, 2017)), esEstresante(Tarea)).
calificarSegun(Persona, sabios):- 
    realizoTareaEstresante(Persona, Tarea), 
    not((realizoTareaEstresante(Persona, OtraTarea), Tarea \= OtraTarea)).

realizoTareaEstresante(Persona, Tarea):- 
    hizoTarea(Persona, Tarea, _),
    esEstresante(Tarea).

%4

masChapita(Persona):- 
    cantidadTareaEstresante(Persona, Cantidad), 
    forall(cantidadTareaEstresante(_, OtraCantidad), Cantidad >= OtraCantidad).

cantidadTareaEstresante(Persona, Cantidad):- 
    trabajador(Persona), 
    findall(Tarea, realizoTareaEstresante(Persona, Tarea), ListaTareas), 
    length(ListaTareas, Cantidad).



