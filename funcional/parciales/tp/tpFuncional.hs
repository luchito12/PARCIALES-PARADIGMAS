--                Entrega 1
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
{-# HLINT ignore "Avoid lambda using `infix`" #-}

import Text.Show.Functions ()

data Ciudad = UnaCiudad {
    nombre :: String,
    anioDeFundacion :: Int,
    atracciones :: [Atraccion],
    costoDeVida :: Float
} deriving Show

type Atraccion = String


--                   Punto 1: Valor de una ciudad

-- “Baradero”, fundada en 1615, cuyas atracciones son “Parque del Este” y “Museo Alejandro Barbich”, con un costo de vida de 150
baradero :: Ciudad
baradero = UnaCiudad {
    nombre = "Baradero",
    anioDeFundacion = 1615,
    atracciones = ["Parque del Este", "Museo Alejandro Barbich"],
    costoDeVida = 150
}

-- “Nullish”, fundada en 1800, sin atracciones y un costo de vida de 140
nullish :: Ciudad
nullish = UnaCiudad {
    nombre = "Nullish",
    anioDeFundacion = 1800,
    atracciones = [],
    costoDeVida = 140
}

-- “Caleta Olivia”, fundada en 1901, cuyas atracciones son “El Gorosito” y “Faro Costanera”, y un costo de vida de 120
caletaOlivia :: Ciudad
caletaOlivia = UnaCiudad {
    nombre = "Caleta Olivia",
    anioDeFundacion = 1901,
    atracciones = ["El Gorosito", "Faro Costanera"],
    costoDeVida = 120
}


valorDeUnaCiudad :: Ciudad -> Float
valorDeUnaCiudad ciudad
  | esCiudadVieja ciudad = (1800 - (fromIntegral . anioDeFundacion $ ciudad)) * 5
  | noTieneAtracciones ciudad = 2 * costoDeVida ciudad
  | otherwise = 3 * costoDeVida ciudad

esCiudadVieja :: Ciudad -> Bool
esCiudadVieja ciudad = anioDeFundacion ciudad < 1800

noTieneAtracciones :: Ciudad -> Bool
noTieneAtracciones ciudad = null (atracciones ciudad)


--                   Punto 2: Características de las ciudades

isVowel :: Char -> Bool
isVowel character = character  `elem` "aeiouAEIOU"

tieneAtraccionCopada :: Ciudad -> Bool
tieneAtraccionCopada ciudad = any (isVowel.head) (atracciones ciudad)

ciudadSobria :: Int -> Ciudad -> Bool
ciudadSobria valor ciudad = all ((> valor) . length) (atracciones ciudad)

ciudadConNombreRaro :: Ciudad -> Bool
ciudadConNombreRaro ciudad = (length . nombre $ ciudad) < 5

-- “Maipú”, fundada en 1878, cuya atracción es el “Fortín Kakel” con un costo de vida de 115
maipu :: Ciudad
maipu = UnaCiudad {
    nombre = "Maipu",
    anioDeFundacion = 1878,
    atracciones = ["Fortin Kakel"],
    costoDeVida = 115
}

-- “Azul”, fundada en 1832, cuyas atracciones son “Teatro Español”, “Parque Municipal Sarmiento” y “Costanera Cacique Catriel”, con un costo de vida de 190
azul:: Ciudad
azul = UnaCiudad {
    nombre = "Azul",
    anioDeFundacion = 1832,
    atracciones = ["Teatro Español", "Parque Municipal Sarmiento", "Costanera Cacique Catriel"],
    costoDeVida = 190
}


--                   Punto 3: Eventos

modificarCostoDeVida :: Float -> Ciudad -> Ciudad
modificarCostoDeVida porcentaje ciudad = ciudad { costoDeVida = costoDeVida ciudad * porcentaje}

modificarAtracciones :: ([Atraccion] -> [Atraccion]) -> Ciudad -> Ciudad
modificarAtracciones funcion ciudad = ciudad { atracciones = funcion . atracciones $ ciudad }

sumarNuevaAtraccion :: Atraccion -> Ciudad -> Ciudad -- Aparacen muchos 0's dsp de la coma
sumarNuevaAtraccion atraccion ciudad = modificarAtracciones (atraccion:) . modificarCostoDeVida 1.2 $ ciudad

crisis :: Ciudad -> Ciudad
crisis ciudad = modificarAtracciones quitarAtracciones . modificarCostoDeVida 0.9 $ ciudad

quitarAtracciones :: [Atraccion] -> [Atraccion]
quitarAtracciones [] = []
quitarAtracciones atracciones = tail atracciones

remodelacion :: Float -> Ciudad -> Ciudad
remodelacion porcentaje ciudad = modificarCostoDeVida (1 + porcentaje / 100) . modificarNombre $ ciudad

modificarNombre :: Ciudad -> Ciudad
modificarNombre ciudad = ciudad { nombre = "New " ++ nombre ciudad }

reevaluacion :: Int -> Ciudad -> Ciudad
reevaluacion valor ciudad
 | ciudadSobria valor ciudad = modificarCostoDeVida 1.1 ciudad
 | otherwise = ciudad { costoDeVida = costoDeVida ciudad - 3} -- Como no se trata de un porcentaje no aplicamos modificarCostoDeVida


--                   Punto 4: La transformación no para

{-

Reflejar de qué manera podemos hacer que una ciudad tenga
- el agregado de una nueva atracción
- una remodelación
- una crisis
- y una reevaluación

Para ello, vamos a hacer:
> reevaluacion 14 . crisis . remodelacion 50 . sumarNuevaAtraccion "Balneario Municipal Alte. Guillermo Brown" $ azul

El resultado es:
> UnaCiudad {nombre = "New Azul", anioDeFundacion = 1832, atracciones = ["Teatro Espa\241ol","Parque Municipal Sarmiento","Costanera Cacique Catriel"], costoDeVida = 305}

-}
--                Entrega 2

--              Punto 1: Los años pasan...
data Anio = UnAnio {
    numero :: Int,
    eventos :: [Evento]
} deriving Show

type Evento = Ciudad -> Ciudad

veinteVeintiDos :: Anio
veinteVeintiDos = UnAnio {
    numero = 2022,
    eventos = [crisis, remodelacion 5, reevaluacion 7]
}

veinteQuince :: Anio
veinteQuince = UnAnio {
    numero = 2015,
    eventos = []
}

veinteVeintiTres :: Anio
veinteVeintiTres = UnAnio {
    numero = 2023,
    eventos = [crisis, sumarNuevaAtraccion "parque", remodelacion 10, remodelacion 20]
}

veinteVeintiUno :: Anio
veinteVeintiUno = UnAnio {
    numero = 2021,
    eventos = [crisis, sumarNuevaAtraccion "playa"]
}

--              1.1 Los años pasan...
pasoDeAnio :: Anio -> Ciudad -> Ciudad
pasoDeAnio anio ciudad = foldr ($) ciudad (eventos anio)

--              1.2 Algo mejor
algoMejor :: Ord a => Ciudad -> (Ciudad -> a) -> Evento -> Bool
algoMejor ciudad criterio evento  = criterio ciudad < criterio (evento ciudad)

--              1.3 Costo de vida que suba
filtrarEventos :: Anio -> (Evento -> Bool) -> Anio
filtrarEventos anio condicion = anio { eventos = filter condicion (eventos anio) }

aplicarEventosFiltrados :: Anio -> Ciudad -> (Evento -> Bool) -> Ciudad
aplicarEventosFiltrados anio ciudad condicion = pasoDeAnio (filtrarEventos anio condicion) ciudad

aplicarMejoresEventos :: Anio -> Ciudad -> (Ciudad -> Float) -> Ciudad
aplicarMejoresEventos anio ciudad funcion = aplicarEventosFiltrados anio ciudad . algoMejor ciudad $ funcion

costoDeVidaQueSuba :: Anio -> Ciudad -> Ciudad
costoDeVidaQueSuba anio ciudad = aplicarMejoresEventos anio ciudad costoDeVida

--              1.4 Costo de vida que baje 
costoDeVidaQueBaje :: Anio -> Ciudad -> Ciudad
costoDeVidaQueBaje anio ciudad = aplicarMejoresEventos anio ciudad (negate . costoDeVida)

--              1.5 Valor que suba 
valorQueSuba :: Anio -> Ciudad -> Ciudad
valorQueSuba anio ciudad = aplicarMejoresEventos anio ciudad valorDeUnaCiudad


--              2.1 Eventos ordenados
eventosOrdenados :: Anio -> Ciudad -> Bool
eventosOrdenados anio ciudad = compararEventos (eventos anio) ciudad

compararEventos :: [Evento] -> Ciudad -> Bool
compararEventos [_] _ = True
compararEventos (evento1 : evento2 : eventos) ciudad = compararCostoDeVida ciudad evento1 evento2 && compararEventos (evento2 : eventos) ciudad

compararCostoDeVida :: Ciudad -> Evento -> Evento -> Bool
compararCostoDeVida ciudad evento1 evento2 = costoDeVidaEsMenorSegun (\evento -> evento ciudad) evento1 evento2

costoDeVidaEsMenorSegun :: (a -> Ciudad) -> a -> a -> Bool
costoDeVidaEsMenorSegun criterio unValor otroValor = esMenorSegun (costoDeVida . criterio) unValor otroValor

esMenorSegun :: Ord b => (a -> b) -> a -> a -> Bool
esMenorSegun ponderador unValor otroValor = ponderador unValor < ponderador otroValor

--              2.2 Ciudades ordenadas
ciudadesOrdenadas :: Evento -> [Ciudad] -> Bool
ciudadesOrdenadas _ [_] = True
ciudadesOrdenadas evento (ciudad1 : ciudad2 : ciudades) = compararCiudades evento ciudad1 ciudad2 && ciudadesOrdenadas evento (ciudad2 : ciudades)

compararCiudades :: Evento -> Ciudad -> Ciudad -> Bool
compararCiudades evento ciudad1 ciudad2 = costoDeVidaEsMenorSegun evento ciudad1 ciudad2

------------              2.3 Años ordenados
aniosOrdenados :: [Anio] -> Ciudad -> Bool
aniosOrdenados [_] _ = True
aniosOrdenados (primerAnio : segundoAnio : anios) ciudad = compararAnios ciudad primerAnio segundoAnio && aniosOrdenados (segundoAnio : anios) ciudad

compararAnios :: Ciudad -> Anio -> Anio  -> Bool
compararAnios ciudad anio1 anio2 = costoDeVidaEsMenorSegun (\anio -> pasoDeAnio anio ciudad) anio1 anio2


aniosPrueba :: [Anio]
aniosPrueba = [veinteVeintiUno, veinteVeintiDos, veinteVeintiTres]

aniosPrueba2 :: [Anio]
aniosPrueba2 = [veinteVeintiDos, veinteVeintiUno, veinteVeintiTres]

listaCiudades1 :: [Ciudad]
listaCiudades1 = [caletaOlivia, nullish, baradero, azul]
listaCiudades2 :: [Ciudad]
listaCiudades2 = [caletaOlivia, azul, baradero]

--------------              3 Al infinito, y más allá...

veinteVeintiCuatro :: Anio
veinteVeintiCuatro = UnAnio {
    numero = 2024,
    eventos = [crisis, reevaluacion 7] ++ map remodelacion [1..]
}

discoRayado :: [Ciudad]
discoRayado = [azul, nullish] ++ cycle [caletaOlivia, baradero]

laHistoriaSinFin :: [Anio]
laHistoriaSinFin = [veinteVeintiUno, veinteVeintiDos] ++ repeat veinteVeintiTres


{-
---------------Eventos Ordenados----------------
¿Puede haber un resultado posible para la función del punto 2.1 (eventos ordenados) para el año 2024? Justificarlo relacionándolo con conceptos vistos en la materia.
Si, como Haskell es un lenguaje con Lazy Evaluation (es decir, primero evalua las funciones, después los parámetros),
puede haber resultado SI la ciudad es sobria para el valor 7.
Esto es así puesto que en dicho caso el aumento del costo de vida de reevaluacion 7 es mayor al de remodelacion 1 y retornará False.
Si no, será menor y entonces seguira comparando hasta el infinito (puesto que el aumento de remodelacion 1 es menor al de remodelacion 2, y así).

---------------Ciudades Ordenadas----------------
¿Puede haber un resultado posible para la función del punto 2.2 (ciudades ordenadas) para la lista “disco rayado”? Justificarlo relacionándolo con conceptos vistos en la materia.
Sí, y será siempre False.
Esto es así pues, hay Lazy Evaluation y Azul tiene mucho mayor coste de vida que Nullish.
Entonces, luego de aplicar cualquier evento a las dos, Azul tendrá más coste de vida que Nullish y retornará False.
De todas formas, aún en el hipotético caso de que haya un evento que modifique el costo de vida de Nullish a un valor mayor que el de Azul, también retornará False.
Esto es así pues aún si luego de aplicar los eventos el costo de vida de caletaOlivia es menor al de Baradero, cuando vuelva a compararlos en orden inverso dará False.

------------- Años Ordenados ----------------
¿Puede haber un resultado posible para la función del punto 2.3 (años ordenados) para “la historia sin fin”? Justificarlo relacionándolo con conceptos vistos en la materia.
Sí, como hay Lazy Evaluation el resultado será siempre False.
Esto es así pues aún si la ciudad es sobria, 2022 aumentaría un 5% el coste de vida, mientras que 2021 lo aumentaría un 10%.
De todas formas, aún si estuviesen esos en orden, cuando compare el coste de vida de 2023 con sigo mismo, dará False. 
-}
