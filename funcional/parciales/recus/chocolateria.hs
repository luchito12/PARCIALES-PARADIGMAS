module Library where
import PdePreludat
{-Primera parte
Los chocolates que vamos a hacer pueden tener una combinación de ingredientes que resultará en los distintos sabores que vamos a ofrecer a nuestros clientes. 
Cada ingrediente aporta un determinado nivel de calorías. Por ejemplo agregar naranja aporta 20 calorías.
La gente de marketing de la empresa nos sugirió que los chocolates tengan un nombre fancy para la venta. 
Por ejemplo "chocolate Rap a Niu" o "Roca blanca con almendras".
Lo que tenemos que determinar en primer lugar es cuánto nos sale cada chocolate: los chocolates amargos 
(que tienen más de un 60% de cacao) se calculan como el gramaje del chocolate multiplicado por el precio premium. 
Por el contrario, si tiene más de 4 ingredientes, el precio es de $8 por la cantidad de ingredientes que tiene. Caso contrario, el costo es de $1,5 por gramo.
El precio premium varía si es apto para diabéticos (es decir que el chocolate tiene porcentaje cero de azúcar) en cuyo caso es de $8 por gramo o bien es de $5 por gramo.-}

{-Punto 1 (3 puntos)
Modelar el chocolate e implementar el cálculo de su precio en base a la descripción anterior.-}
type Nombre = String
type Calorias = Number
type Gramos = Number
type Porcentaje = Number

type Ingrediente = (Nombre, Calorias)
{-
Otra alternativa es definir un Data

data Ingrediente = Ingrediente {
  nombre:: String,
  calorias :: Calorias
}
Incluso el nombre no es utilizado en los cálculos porque solo dependen de las claorías que aportan. 
Entonces podría ser solamente: 
type Ingrediente = Calorias-}

{-Creamos las funciones que nos permiten acceder a la tupla. En caso de optar por un data, estas funciónes están implícitas.-}

caloriasIngrediente ::Ingrediente -> Calorias
caloriasIngrediente = snd

nombreIngrediente ::Ingrediente -> String
nombreIngrediente = fst

data Chocolate = Chocolate {
  nombre :: String,
  porcentajeCacao :: Porcentaje,
  gramaje :: Gramos,
  porcentajeAzucar ::Porcentaje,
  ingredientes :: [Ingrediente]
} deriving (Eq)

{-
El porcentaje de cacao podría modelarse como un ingrediente pero no matchea con lo modelado anteriormente.
El ingrediente es modelado por un nombre y una cantidad de calorías, no por un porcentaje o un gramaje
Si adaptamos al ingrediente para que acepte un porcentaje o un gramaje y lo agregamos a la lista, 
nos veremos forzados que cuando necesitemos acceder al porcentaje de chocolate, tenemos que hacer un find 
para encontrar el ingrediente chocolate y luego acceder al porcentaje de chocolate. -}

instance Show Chocolate where
  show choco = nombre choco

--calculo la cantidad de ingredientes 
cantidadDeIngredientes :: Chocolate -> Number
cantidadDeIngredientes = length.ingredientes

--determino el precio
precioPorchoco:: Chocolate -> Number
precio choco 
 | ((>60).porcentajeCacao) choco = gramaje choco * precioPorGramoPremium choco
 | ((>4).cantidadDeIngredientes) choco = (8 *).cantidadDeIngredientes $ choco
 | otherwise = gramaje choco * 1.5

--funcion auxiliar para chocolates amargos
precioPorGramoPremium:: Chocolate -> Number
precioPorGramoPremium choco | esAptoDiabeticos choco = 8
 | otherwise = 5

esAptoDiabeticos:: Chocolate -> Bool
esAptoDiabeticos = (==0).porcentajeAzucar

{-Punto 2 (3 puntos)
Necesitamos saber:
Cuándo un chocolate esBombonAsesino que ocurre cuando tiene algún ingrediente de más de 200 calorías.
También queremos saber el totalCalorias para un chocolate que es la sumatoria de los aportes de cada ingrediente.
Y por último, dada una caja de chocolates, queremos tomar los chocolates aptoParaNinios donde separamos 3 chocolates 
que no sean bombones asesinos, sin importar cuáles.-}

type Caja = [Chocolate]

esBombonAsesino :: Chocolate -> Bool
esBombonAsesino = any ((>200).caloriasIngrediente).ingredientes

totalCalorias :: Chocolate -> Calorias
totalCalorias = sum.map caloriasIngrediente.ingredientes 

aptosParaNinios :: Caja -> Caja
aptosParaNinios = take 3.filter (not.esBombonAsesino)

{-Segunda Parte
¡¡Excelente!! Ahora nos toca pensar qué procesos podemos realizar sobre el chocolate. 
La acción de agregar un ingrediente no incrementa el gramaje del chocolate: el mismo ya está contemplado en el valor establecido. 
Si bien hay fanáticos del chocolate amargo (como quien les escribe) también podemos realizar modificaciones o agregados:

Por ejemplo el frutalizado permite agregarle como ingrediente una cierta cantidad de unidades de una fruta. Toda fruta tiene 
dos calorías por cada unidad. Un clásico es el dulceDeLeche que agrega dicho ingrediente el cual siempre aporta 220 calorías. Además al nombre 
del chocolate le agrega al final la palabra "tentación": Por ejemplo el "Chocolate con almendras" pasa a ser "Chocolate con almendras tentación".
Otro famoso proceso es la celiaCrucera que dada un cierto porcentaje de azúcar, aumenta el nivel del mismo en el chocolate.
Por último contamos con la embriagadora que para un determinado grado de alcohol aporta como ingrediente Licor con una caloría por cada grado 
de alcohol, hasta un máximo de 30 calorías. Es decir que si agregamos una bebida con 40 grados, son 30 calorías de licor. 
En cambio si ponemos una bebida con 20 grados, son 20 calorías aportadas. Además agrega un porcentaje de 20 en azúcar. -}

{-
Punto 3 (3 puntos)
Modelar cada uno de los procesos sobre el chocolate. Tengamos en cuenta que a futuro podemos implementar nuevos procesos para generar chocolates 
más novedosos. Evitar la repetición de lógica y código.-}

type Proceso = Chocolate -> Chocolate

{-Creamos la abstracción de agregarIngrediente para no repetir lógica en las funciones que modelan los procesos.-}
agregarIngrediente :: Ingrediente -> Proceso
agregarIngrediente ingrediente chocolate = chocolate {
  ingredientes = ingrediente:ingredientes chocolate
}

frutalizado :: String -> Number -> Proceso
frutalizado fruta unidades = agregarIngrediente  (fruta, unidades * 2)

dulceDeLeche :: Proceso
dulceDeLeche choco = agregarIngrediente ("ddl",220) choco {
  nombre = nombre choco ++ " Tentacion"
}

celiaCrucera :: Porcentaje -> Proceso
celiaCrucera porcentaje chocolate = chocolate {
  porcentajeAzucar = porcentajeAzucar chocolate + porcentaje
} 

embriagadora :: Number -> Proceso
embriagadora grados = celiaCrucera 20 .agregarIngrediente ("Licor", min 30 grados)

{-}
Punto 4 (1 punto)
Dar un ejemplo de una receta que conste de los siguientes procesos: agregar 10 unidades de naranja, dulce de leche y un licor de 32 grados.-}

type Receta = [Proceso]

recetaPunto4 :: Receta
recetaPunto4 = [frutalizado "naranja" 10, dulceDeLeche, embriagadora 32]

{-Punto 5 (2 puntos)
Implementar la preparación de un chocolate que a partir de un determinado chocolate tomado como base y una serie de procesos nos permite 
obtener el chocolate resultante. En este punto NO se puede utilizar recursividad.-}

prepararChocolate:: Chocolate -> Receta -> Chocolate
prepararChocolate = foldr ($)

{-
¡Última parte!
Por otra parte tenemos a las personas, de las cuales se sabe que tienen un límite de saturación para las calorías que consumen
 y además tienen un criterio para rechazar ciertos ingredientes. Por ejemplo a Juan no le gusta la naranja 
 y a Cecilia no le gusta los ingredientes pesados (de más de 200 calorías). Cada persona podría tener un criterio distinto.

Punto 6 (2 Puntos)
Resolver la función hastaAcaLlegue que dada una persona y una caja de chocolates, devuelve los chocolates que puede comer. La persona comerá todos los chocolates que pueda hasta que llegue al nivel de saturación de calorías. Al mismo tiempo debe descartar los chocolates que tengan un ingrediente que rechace por el criterio de la persona.

Es decir, si tenemos 4 chocolates de 300, 400, 150 y 50 calorías respectivamente, y Juan tiene un límite de 800 calorías, 
la función debe devolver los tres primeros chocolates (por más que a Juan le hubiera encantado comer el último chocolate). 
Esto es porque cuando come el tercer chocolate suma 850 calorías que es más que el tope de 800 calorías.

Si tenemos 4 chocolates, todos de 100 calorías, en el segundo chocolate hay naranja y en los otros tres no.
 Recordemos que a Juan no le gusta la naranja y soporta 800 calorías. Si invocamos la función con Juan y estos 4 chocolates, 
 nos debe devolver una lista con los chocolates que originalmente están en la posición 1, 3 y 4, descartando el chocolate de naranja 
 y teniendo en cuenta que los tres bombones suman 300 calorías < 800 de tope.

Tener en cuenta que el criterio de aceptación depende de cada persona.

Este punto tiene que ser resuelto utilizando recursividad.-}

data Persona = Persona {
  noLeGusta:: Ingrediente -> Bool,
  limiteDeSaturacion:: Calorias
}

hastaAcaLlegue:: Persona -> [Chocolate] -> [Chocolate]
hastaAcaLlegue _ [] = [] 
hastaAcaLlegue persona (chocolate:chocolates) | any (noLeGusta persona).ingredientes $ chocolate = hastaAcaLlegue persona chocolates
-- Alternativa que evalúa después de comer el chocolate
-- aquí se fija cómo está la persona, esto implica que pudo haber comido de más, pero solo un chocolatito más
 | (<=0).limiteDeSaturacion $ persona  = []
 | otherwise = chocolate:hastaAcaLlegue (come persona chocolate) chocolates
-- Alternativa que evalúa antes de comer el chocolate
-- | (<=0).limiteDeSaturacion.come persona $ chocolate = []

come :: Persona -> Chocolate -> Persona 
come persona choco = persona {limiteDeSaturacion = limiteDeSaturacion persona - totalCalorias choco }

{-Punto 7 (1 Punto)
Dada una caja de chocolates infinitos ¿es posible determinar cuáles son los chocolates aptosParaNinios 
y si existiese una función totalCalorias' que calcula el total de calorías para una caja de chocolate?
 Justifique su respuesta, relacionándolo con un concepto visto en la materia.-}

-- aptosParaNinios puede terminar porque toma los 3 primeros bombones, mientras cumpla está todo bien
-- totalCalorias' no converge porque queremos obtener la sumatoria de la lista infinita


