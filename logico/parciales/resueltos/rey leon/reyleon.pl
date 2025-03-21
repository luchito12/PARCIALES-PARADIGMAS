%comio(Personaje, Bicho)
comio(pumba, vaquitaSanAntonio(gervasia, 3)).
comio(pumba, hormiga(federica)).
comio(pumba, hormiga(tuNoEresLaReina)).
comio(pumba, cucaracha(ginger, 15, 6)).
comio(pumba, cucaracha(erikElRojo, 25, 70)).
 
comio(timon, vaquitaSanAntonio(romualda,4)).
comio(timon, cucaracha(gimeno, 12, 8)).
comio(timon, cucaracha(cucurucha, 12, 5)).
 
comio(simba, vaquitaSanAntonio(remeditos, 4)).
comio(simba, hormiga(schwartzenegger)).
comio(simba, hormiga(niato)).
comio(simba, hormiga(lula)).
 
pesoHormiga(2).
 
%peso(Personaje, Peso)
peso(pumba, 100).
peso(timon, 50).
peso(simba, 200).
peso(scar, 300).
peso(shenzi, 400).
peso(banzai, 500).

esPersonaje(simba).
esPersonaje(pumba).
esPersonaje(timon).
esPersonaje(scar).
esPersonaje(shenzi).
esPersonaje(banzai).
esPersonaje(mufasa).

%1a
jugosita(cucaracha(_,Tamanio,Peso1)) :-
    findall(Peso,comio(_, cucaracha(_,Tamanio,Peso)),ListaPesos),
    length(ListaPesos,Cantidad),
    Cantidad > 1,
    max_member(Peso1, ListaPesos).

%1b
hotmigofilico(Personaje):- %good
    esPersonaje(Personaje),
    comio(Personaje, hormiga(Nombre)),
    comio(Personaje, hormiga(OtroNombre)),
    OtroNombre \= Nombre.

comioMasDeDosHormigas(Personaje):-
    findall(H, comio(Personaje,hormiga(H)), Hormigas),
    length(Hormigas, Cantidad),
    Cantidad >= 2.

cucarachofobico(Personaje):- %GOOD
    esPersonaje(Personaje),
    not(comio(Personaje, cucaracha(_, _, _))).

%d good
picarones(Personajes):-
    findall(Personaje, condiciones(Personaje), Personajes).
  
condiciones(pumba).
condiciones(Personaje):-
    (comio(Personaje, Cucaracha), jugosita(Cucaracha), esPersonaje(Personaje));
    comio(Personaje, vaquitaSanAntonio(remeditos, _)).
  

%2 A GOOD
persigue(scar, timon).
persigue(scar, pumba).
persigue(shenzi, simba).
persigue(shenzi, scar).
persigue(banzai, timon).

comio(shenzi,hormiga(conCaraDeSimba)).

cuantoEngorda(Personaje, Peso):-
    findall(Peso, comio(Personaje, cucaracha(_, _, Peso)), ListaDeCucaracha),
    findall(Peso, comio(Personaje, vaquitaSanAntonio(_, Peso)), ListaDevaquita),
    findall(Personaje, comio(Personaje, hormiga(_)), ListaDeHormiga),
    length(ListaDeHormiga, CantidadHormigas),
    append(ListaDeCucaracha, ListaDevaquita, ListaFinal),
    sumlist(ListaFinal, PesoDeBichos),
    Peso is PesoDeBichos + CantidadHormigas * 2.
    
%B good

cuantoEngorda2(Personaje, PesoFinal):-
    persigue(Personaje, PersonajePerseguido), 
    persigue(Personaje, OtroPersonajePerseguido), 
    PersonajePerseguido \= OtroPersonajePerseguido,
    peso(PersonajePerseguido, PesoDelPersonajePerseguido),
    findall(PesoDelPersonajePerseguido, peso(PersonajePerseguido, PesoDelPersonajePerseguido), ListaDePesoDelPersonajePerseguido),
    findall(PesoDelPersonajePerseguido2, peso(OtroPersonajePerseguido, PesoDelPersonajePerseguido2), ListaDePesoDelPersonajePerseguido2),
    append(ListaDePesoDelPersonajePerseguido, ListaDePesoDelPersonajePerseguido2, TotalPesos),
    sumlist(TotalPesos, PesoDeLosQuePersiguio),
    cuantoEngorda(Personaje,Peso),
    PesoFinal is Peso + PesoDeLosQuePersiguio.

%c good 
cuantoEngorda3(Personaje, PesoUltimo):-
cuantoEngorda2(Personaje, PesoFinal),    
persigue(Personaje, PersonajePerseguido), 
persigue(Personaje, OtroPersonajePerseguido), 
PersonajePerseguido \= OtroPersonajePerseguido,
findall(Peso, cuantoEngorda(PersonajePerseguido, Peso), ListaDePesos),
findall(Peso, cuantoEngorda(OtroPersonajePerseguido, Peso), ListaDePesos2),
append(ListaDePesos, ListaDePesos2, ListaDePesosFinal),
sumlist(ListaDePesosFinal, Pesos),
PesoUltimo is PesoFinal + Pesos.



%3
rey(R) :-
    persigue(_, R),                                                     %Inversivilidad
    unicoPerseguidor(R),
    esAdoradoPorTodos(R).

esAdoradoPorTodos(Animal) :-
   findall(OtroAnimal, noAdora(OtroAnimal, Animal), NoAdoradores),
   length(NoAdoradores, 0).

noAdora(Animal1, Animal2) :-
    persigue(Animal2, Animal1).
noAdora(Animal1, Animal2) :-
    comio(Animal2, Animal1).

unicoPerseguidor(Animal) :-
    findall(Persiguiendo, persigue(Persiguiendo, Animal), Perseguidores),
    length(Perseguidores, 1).

