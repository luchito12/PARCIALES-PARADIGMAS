data Gimnasta = CGimnasta String Float Float Float deriving(Show)

nombre :: Gimnasta -> String
nombre (CGimnasta nombre _ _ _ ) = nombre
edad :: Gimnasta -> Float
edad (CGimnasta  _ edad _ _ ) = edad
peso :: Gimnasta -> Float
peso (CGimnasta _ _ peso _ ) = peso
tonificacion :: Gimnasta -> Float
tonificacion (CGimnasta _ _ _ tonificacion) = tonificacion


pancho :: Gimnasta
pancho = CGimnasta "Francisco" 40.0 120.0 1.0
andres :: Gimnasta
andres = CGimnasta "Andy" 22.0 80.0 6.0

--1)

saludable :: Gimnasta -> Bool
saludable gimnasta = (not.esObeso) gimnasta && ((>5).tonificacion) gimnasta
esObeso :: Gimnasta -> Bool
esObeso gimnasta = ((>100).peso) gimnasta

--2) 

quemarCalorias :: Gimnasta -> Float -> Gimnasta
quemarCalorias gimnasta caloriasQuemadas
	|esObeso gimnasta = bajarPeso gimnasta ((/150) caloriasQuemadas)
	|(not.esObeso) gimnasta && ((>30).(edad)) gimnasta && (>200) caloriasQuemadas = bajarPeso gimnasta 1
	|otherwise = bajarPeso gimnasta ( ((caloriasQuemadas/).((edad gimnasta)*)) (peso gimnasta) )

bajarPeso :: Gimnasta -> Float -> Gimnasta
bajarPeso (CGimnasta nom eda pes ton) caloriasQuemadas = (CGimnasta nom eda ((pes-) caloriasQuemadas) ton)

--3)

caminataEnCinta :: Float -> Gimnasta -> Gimnasta
caminataEnCinta tiempo gimnasta = quemarCalorias gimnasta ((5*) tiempo)

entrenamientoEnCinta :: Float -> Gimnasta -> Gimnasta
entrenamientoEnCinta tiempo gimnasta = quemarCalorias gimnasta ( ((tiempo*).(/2).(12+).(/5)) tiempo )

pesas :: (Ord a, Num a) => Float -> a -> Gimnasta -> Gimnasta
pesas kilos tiempo gimnasta
	|tiempo > 10 = tonificar gimnasta ((/10) kilos)
	|otherwise = gimnasta

tonificar :: Gimnasta -> Float -> Gimnasta
tonificar (CGimnasta nom eda pes ton) tonificacionAumentada = (CGimnasta nom eda pes ((tonificacionAumentada+) ton))

colina :: Float -> Float -> Gimnasta -> Gimnasta
colina inclinacion tiempo gimnasta =  quemarCalorias gimnasta ( ((2*).(inclinacion*)) tiempo )

montania :: Float -> Float -> Gimnasta -> Gimnasta
montania inclinacion tiempo gimnasta = tonificar (quemarCalorias gimnasta (calculoMontaña inclinacion tiempo)) 1

calculoMontaña :: Fractional a => a -> a -> a
calculoMontaña inclinacion tiempo = (+) ( ((2*).(inclinacion*)) ((/2) tiempo) ) ( ((2*).(((3+) inclinacion)*)) ((/2) tiempo) )

--4)
--	A
data Rutina = CRutina String Float [(String, Float)] deriving(Show)

nombreRutina :: Rutina -> String
nombreRutina (CRutina nombreRutina _ _ ) = nombreRutina
listaEjercicios :: Rutina -> [(String, Float)]
listaEjercicios (CRutina _ _ listaEjercicios) = listaEjercicios
duracion :: Rutina -> Float
duracion (CRutina _ duracion _) = duracion 

duracionEjercicio :: Rutina -> Float
duracionEjercicio (CRutina _ duracion lista) = (duracion) / fromIntegral (length lista)

rutinaCompleta :: Rutina
rutinaCompleta = CRutina "rutina completa" 100 [("caminataEnCinta",0),("entrenamientoEnCinta",0), ("pesas", 50), ("colina",5), ("montania",5)]
simple :: Rutina
simple = CRutina "rutina completa" 500 [("caminataEnCinta",0),("entrenamientoEnCinta",0)]


hacerRutina :: Rutina -> Gimnasta -> Gimnasta
hacerRutina rutina gimnasta = calculoRutina (listaEjercicios rutina) gimnasta (duracionEjercicio rutina)

calculoRutina :: [(String, Float)] -> Gimnasta -> Float -> Gimnasta
calculoRutina [] gimnasta tiempo = gimnasta
calculoRutina (x:xs) gimnasta tiempo
	|fst x == "caminataEnCinta" = calculoRutina xs ( caminataEnCinta tiempo gimnasta ) tiempo
	|fst x == "entrenamientoEnCinta" = calculoRutina xs ( entrenamientoEnCinta tiempo gimnasta ) tiempo
	|fst x == "pesas" = calculoRutina xs ( pesas (snd x) tiempo gimnasta ) tiempo
	|fst x == "colina" = calculoRutina xs ( colina (snd x) tiempo gimnasta ) tiempo
	|fst x == "montania" = calculoRutina xs ( montania (snd x) tiempo gimnasta ) tiempo
	
--FALTA EL FOLD
--hacerRutinaFold rutina gimnasta = foldl (calculoRutinaFold) gimnasta rutina

--calculoRutinaFold 

--	B

resumenRutina :: Rutina -> Gimnasta -> (String, Float, Float)
resumenRutina rutina gimnasta = calculoResumen (nombreRutina rutina) (hacerRutina rutina gimnasta) gimnasta

calculoResumen :: a -> Gimnasta -> Gimnasta -> (a, Float, Float)
calculoResumen nombre gimnastaEntrenado gimnasta = (nombre, ((peso gimnasta) - (peso gimnastaEntrenado) ), ( (tonificacion gimnastaEntrenado)-(tonificacion gimnasta) ) )

-- 5)

resumenSaludable :: Gimnasta -> [Rutina] -> [String]
resumenSaludable gimnasta rutina = map nombreRutina (filter ( saludable.(flip (hacerRutina) gimnasta) ) rutina)

--FALTA EL DE LISTAS POR COMPRENSION 

--resumenSaludable' gimnasta rutina = [ x | x <- rutina , x <- (hacerRutina x gimnasta), x <- (saludable x)]

--resumenSaludable' gimnasta rutina =  map nombreRutina [x | x <- rutina, (saludable.(hacerRutina x gimnasta))]





