import Text.Show.Functions ()
import Data.Char ()

--defino produccion 
type Produccion = Serie -> Serie

--defino tipo de dato serie 
data Serie = Serie {
    nombre :: String,
    actores :: [Actor],
    presupuesto :: Int,
    temporadas :: Int,
    rating :: Int,
    cancelada :: Bool
} deriving Show

--defino tipo de dato autor 
data Actor = Actor {
    nombreActor :: String,
    sueldo :: Int,
    restricciones :: [String]
} deriving Show

------------------------------------------------------------------------------------- Punto 1

--Saber si la serie está en rojo, esto es si el presupuesto no alcanza a cubrir lo que quieren cobrar todos los actores
estaEnRojo :: Serie -> Bool
estaEnRojo serie = (presupuesto serie) > (cobranActores (actores serie))
--si cumple con la condicion debuelve bool

--funcion auxiliar 
cobranActores :: [Actor] -> Int
cobranActores = sum . map sueldo

 
--Saber si una serie es problemática, esto ocurre si tienen más de 3 actores o actrices con más de 1 restricción
esProblematica :: Serie -> Bool
esProblematica = (>3) . (tieneRestricciones 1)

--funciones auxiliares
tieneRestricciones :: Int -> Serie -> Int
tieneRestricciones num serie = length $ filter (masDeXRestricciones num) (actores serie)
--filtra teniendo en cuenta la funcion auxiliar 

--funcion auxiliar 
masDeXRestricciones :: Int -> Actor -> Bool
masDeXRestricciones num = (>num) . length . restricciones 
--dado un numero hace el length
-------------------------------------------------------------------------------------- Punto 2

--elimina a los dos primeros actores de la serie y los reemplaza por sus actores favoritos
conFavoritismo :: [Actor] -> Produccion
conFavoritismo actoresFavoritos = reemplazarActores actoresFavoritos . (eliminarActores 2)

--funcion auxiliar 
mapActoresSerie :: ([Actor] -> [Actor]) -> Serie -> Serie
mapActoresSerie funcion serie = serie { actores = funcion (actores serie) }

--funcion auxiliar 
eliminarActores :: Int -> Serie -> Serie
eliminarActores num = mapActoresSerie (drop num)

--funcion auxiliar
reemplazarActores :: [Actor] -> Serie -> Serie
reemplazarActores actoresFavoritos = mapActoresSerie (++ actoresFavoritos)

--es un caso particular de un productor con favoritismos, siempre  reemplaza a los primeros dos actores por johnny depp y helena bonham 
timBurton :: Produccion
timBurton = conFavoritismo [johnnyDepp, helenaBonhamCarter]

--defino autores
johnnyDepp :: Actor
johnnyDepp = Actor "johnny depp" 20000000 []

helenaBonhamCarter :: Actor
helenaBonhamCarter = Actor "helema bonham carter" 15000000 []

--gatopardeitor​: no cambia nada de la serie. 
gatopardeitor :: Produccion
gatopardeitor serie = serie

--estireitor​: duplica la cantidad de temporadas estimada de la serie
estireitor :: Produccion
estireitor = mapTemporadas (*2)

--funcion auxiliar  estireitor
mapTemporadas :: (Int -> Int) -> Serie -> Serie
mapTemporadas funcion serie = serie { temporadas = funcion (temporadas serie) }

--desespereitor​: hace un combo de alguna de las anteriores ideas, mínimo 2.
desespereitor :: Produccion
desespereitor = gatopardeitor . estireitor

--canceleitor​: si la serie está en rojo o el rating baja de una cierta cifra, la serie se cancela
canceleitor :: Int -> Produccion
canceleitor cifra serie
  | estaEnRojo serie || (rating serie) > cifra = mapCancelada (const True) serie
  | otherwise = serie

--funcion auxiliar canceleitor
mapCancelada :: (Bool -> Bool) -> Serie -> Serie
mapCancelada funcion serie = serie { cancelada = funcion (cancelada serie) }

----------------------------------------------------------------------------------------------- Punto 3
{-Calcular el bienestar de una serie, en base a la sumatoria de estos conceptos: 
 
- Si la serie tiene estimadas más de 4 temporadas, su bienestar es 5, de lo contrario  es (10 - cantidad de temporadas estimadas) * 2 
- Si la serie tiene menos de 10 actores, su bienestar es 3, de lo contrario es (10 -  cantidad de actores que tienen restricciones), con un mínimo de 2 
 
Aparte de lo mencionado arriba, si la serie está cancelada, su bienestar es 0 más  allá de cómo diesen el bienestar por longitud y por reparto-}

bienestarLongitud :: Serie -> Int
bienestarLongitud serie
  | (temporadas serie) > 4 = 5
  | otherwise = (10 - (temporadas serie)) *2
--depende de lo que cumpla devuelve un numero 

bienestarReparto :: Serie -> Int
bienestarReparto serie
  | (length $ actores serie) < 10 = 3
  | otherwise = 10 - (tieneRestricciones 2 serie) 
--depende de lo que cumpla devuelve un numero 

bienestar :: Serie -> Int
bienestar serie
  | (cancelada serie) = 0
  | otherwise = (bienestarLongitud serie) + (bienestarReparto serie)
--depende de lo que cumpla devuelve un numero 

---------------------------------------------------------------------------------------------------------- Punto 4
{-Dada una lista de series y una lista de productores, aplicar para cada serie el  productor que la haga más efectiva: es decir, el que le deja más bienestar-}

productorMasEfectivo :: [Serie] -> [Produccion] -> [Serie]
productorMasEfectivo series productores = map (masEfectivo productores) series

--funcion auxiliar 
masEfectivo :: [Produccion] -> Serie -> Serie
masEfectivo (x:[]) serie = x serie 
masEfectivo (x:xs) serie
  | bienestar (x serie) > bienestar (head xs $ serie) = x serie
  | otherwise = masEfectivo xs serie

-- Punto 5

-- ¿Se puede aplicar el productor gatopardeitor cuando tenemos una lista infinita de actores?
-- si, se puede aplicar gatopardeitor con una lista infinita de actores. no se traba en consola.
-- como la funcion es la funcion id (identidad) devuelve infinitamente la serie que le paso, con la lista infinita de actores.
-- wl problema es que como tiene que mostrar una lista infinita de actores, nunca llego a ver los demas
-- atributos de la serie (temporadas, rating, etc).
-- si bien funciona en consola, no cumple con el proposito de la funcion.

serieEjemplo :: Serie
serieEjemplo = Serie "serie ejemplo" actoresInfinitos 100 2 5 False

actoresInfinitos :: [Actor]
actoresInfinitos = johnnyDepp : actoresInfinitos

-- > Resultados : 
-- Serie {nombre = "serie ejemplo", actores = [Actor {nombreActor = "johnny depp", sueldo = 20000000, restricciones = []},Actor {nombreActor = "johnny depp", sueldo = 20000000, restricciones = []} ....

-- ¿Y a uno con favoritismos? ¿De qué depende?

-- al aplicar conFavoritismo no hay problema al hacer el drop de los primero 2 elementos.
-- cuando se quiere agregar los favoritos a la lista puede ocurrir el problema: si se agregan al principio de la lista
-- no hay problema alguno, pero sí lo hay si se agregan al final de la lista (ya que nunca encontrara el final
-- de una lista infinita). 
-- por lo que depende de si agregamos a los actores al principio o al final

-- Punto 6

esControvertida :: Serie -> Bool
esControvertida serie = not $ cobraMasQueElSiguiente (actores serie)

--funcion auxiliar 
cobraMasQueElSiguiente :: [Actor] -> Bool
cobraMasQueElSiguiente (x:[]) = True
cobraMasQueElSiguiente (x:xs) = (sueldo x) > (sueldo $ head xs) 

-- Punto 7

-- funcionLoca x y = filter (even.x) . map (length.y)

-- primero sabemos que hay dos parametro : x e y
-- como la primer funcion que se va a aplicar es map, sabemos que hay un tercer parametro implicito: z
-- z es una lista, no sabemos de que
-- funcionLoca :: -> -> [a] -> 
-- como y recibe la lista de z, debe tener su mismo tipo, pero puede devolver algo de otro tipo. lo unico que 
-- sabemos de este algo es que debe ser una lista, pues luego se le aplica la funcion length
-- funcionLoca :: -> (a -> [b]) -> [a] -> 
-- luego, se aplica filter. sabemos que el map devuelve una lista de Int y que sobre esa lista se aplicara el filter.
-- por lo que x es una funcion que recibe Int y devuelve un Int (ya que luego se le aplica even)
-- finalmente la funcion funcionLoca devuelve una lista de Int:
-- funcionLoca :: (Int -> Int) -> (a -> [b]) -> [a] -> [Int]