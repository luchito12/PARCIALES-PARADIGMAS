type Bien = (String,Float)

--creo tipo de dato ciudadano 
data Ciudadano = UnCiudadano {profesion :: String, sueldo :: Float, 
cantidadDeHijos :: Float, bienes :: [Bien] } deriving Show

--cuidadanos 
homero :: Ciudadano
homero = UnCiudadano "SeguridadNuclear" 9000 3 [("casa",50000), ("deuda",-70000)]
frink :: Ciudadano
frink = UnCiudadano "Profesor" 12000 1 []
krabappel :: Ciudadano
krabappel = UnCiudadano "Profesor" 12000 0 [("casa",35000)]
burns :: Ciudadano
burns = UnCiudadano "Empresario" 300000 1 [("empresa",1000000),("empresa",500000),("auto",200000)]

--defino ciudad y cuidadanos 
type Ciudad = [Ciudadano]
springfield :: [Ciudadano]
springfield = [homero, burns, frink, krabappel] 

{-recibe una ciudad y dice cuál es la
diferencia entre el ciudadano que más patrimonio tiene y el que
menos patrimonio tiene. El patrimonio de cada ciudadano se
obtiene sumando el valor de su sueldo y de sus bienes-}
diferenciaDePatrimonio :: Ciudad -> Float 
diferenciaDePatrimonio ciudad = (patrimonio.ciudadanoSegun maximoPatrimonio) ciudad - (patrimonio.ciudadanoSegun minimoPatrimonio) ciudad


patrimonio :: Ciudadano -> Float
patrimonio (UnCiudadano _ sueldo _ bienes) = foldl (\sem (_, valor) -> sem + valor ) sueldo bienes


ciudadanoSegun :: (Ciudadano -> Ciudadano -> Ciudadano) -> Ciudad -> Ciudadano
ciudadanoSegun f  ciudad = foldl1 f ciudad

maximoPatrimonio :: Ciudadano -> Ciudadano -> Ciudadano
maximoPatrimonio unCiudadano otroCiudadano | patrimonio unCiudadano > patrimonio otroCiudadano = unCiudadano
                                           | otherwise = otroCiudadano


minimoPatrimonio :: Ciudadano -> Ciudadano -> Ciudadano
minimoPatrimonio unCiudadano otroCiudadano | patrimonio unCiudadano < patrimonio otroCiudadano = unCiudadano
                                           | otherwise = otroCiudadano


--   ghci> diferenciaDePatrimonio springfield
--2011000.0
--recibe un ciudadano y dice si tiene un auto de alta gama, ó sea, si tiene entre sus bienes un auto que valga más de 100000

tieneAutoAltaGama :: Ciudadano -> Bool
tieneAutoAltaGama (UnCiudadano _ _ _ bienes) =  any autoAltaGama bienes

autoAltaGama :: Bien -> Bool
autoAltaGama ("auto", valor) = valor > 100000
autoAltaGama _ = False

{-
ghci> tieneAutoAltaGama burns
True
-}
{-Hace que aumente el sueldo de la persona en 1000 por cada hijo, si el patrimonio de la
persona es menor a 0 (en otro caso, el ciudadano no cambia)-}
type Medida = Ciudadano -> Ciudadano
auh :: Medida
auh ciudadano = aplicarMedidaSegun (patrimonio ciudadano < 0) (modificarSueldo ((incremento.cantidadDeHijos)ciudadano)) ciudadano

modificarSueldo :: Float -> Ciudadano -> Ciudadano
modificarSueldo cantidad ciudadano = ciudadano { sueldo = sueldo ciudadano + cantidad}

aplicarMedidaSegun :: Bool -> (Ciudadano -> Ciudadano) -> Ciudadano -> Ciudadano
aplicarMedidaSegun condicion f  ciudadano | condicion = f ciudadano
                                          | otherwise = ciudadano

incremento :: Num a => a -> a
incremento cantidad = cantidad * 1000

{-
ghci> auh homero
UnCiudadano {profesion = "SeguridadNuclear", sueldo = 12000.0, cantidadDeHijos = 3.0, bienes = [("casa",50000.0),("deuda",-70000.0)]}
-}
--si el sueldo supera el mínimo dado , disminuye su sueldo el 30% de la diferencia. Si no supera el mínimo, queda igual

impuestoGanancias :: Float -> Medida
impuestoGanancias minimo ciudadano = aplicarMedidaSegun (sueldo ciudadano > minimo) (modificarSueldo (diferencia minimo (sueldo ciudadano))) ciudadano

diferencia :: Float -> Float -> Float
diferencia minimo sueldo = (minimo - sueldo) * 0.3

{-
impuestoGanancias 10000 burns
UnCiudadano {profesion = "Empresario", sueldo = 213000.0, cantidadDeHijos = 1.0, bienes = [("empresa",1000000.0),("empresa",500000.0),("auto",200000.0)]}
-}
--si el ciudadano tiene algún auto de alta gama, disminuye su sueldo en un 10% del valor del auto, sino no disminuye nada.

impuestoAltaGama :: Medida
impuestoAltaGama ciudadano = aplicarMedidaSegun (tieneAutoAltaGama ciudadano) (modificarSueldo ((impuesto.bienes) ciudadano)) ciudadano


impuesto :: [Bien] -> Float
impuesto bienes =  ((*(-0.1)).snd.head.filter autoAltaGama) bienes
{-ghci> impuestoAltaGama burns
UnCiudadano {profesion = "Empresario", sueldo = 280000.0, cantidadDeHijos = 1.0, bienes = [("empresa",1000000.0),("empresa",500000.0),("auto",200000.0)]}
-}

{-Esta medida recibe una profesión y un porcentaje. Si el ciudadano
tiene esa profesión, entonces aumenta su sueldo el porcentaje indicado. Si no es su profesión,
entonces queda igual.-}

negociarSueldoProfesion :: String -> Float -> Medida
negociarSueldoProfesion unaProfesion porcentaje ciudadano =  aplicarMedidaSegun (((== unaProfesion).profesion)ciudadano)  (modificarSueldo (aumento porcentaje (sueldo ciudadano))) ciudadano

aumento :: Float -> Float -> Float
aumento porcentaje sueldo = (sueldo * porcentaje)/100

{-
ghci> negociarSueldoProfesion "SeguridadNuclear" 20 homero
UnCiudadano {profesion = "SeguridadNuclear", sueldo = 10800.0, cantidadDeHijos = 3.0, bienes = [("casa",50000.0),("deuda",-70000.0)]}
-}

--creo data gobierno 
data Gobierno = UnGobierno {años :: [Float], medidas :: [Ciudadano->Ciudadano ]}

--defino tipos de gobierno 
gobiernoA :: Gobierno
gobiernoA = UnGobierno [1999..2003] [impuestoGanancias 30000, negociarSueldoProfesion "Profesion" 10, negociarSueldoProfesion "Empresario" 40, impuestoAltaGama, auh ]


gobiernoB :: Gobierno
gobiernoB = UnGobierno [2004..2008] [impuestoGanancias 40000, negociarSueldoProfesion "Profesor" 30 , negociarSueldoProfesion "Camionero" 40]

{-recibe un gobierno y una ciudad, y aplica todas las
medidas del gobierno a cada uno de los ciudadanos de la ciudad. Retorna la ciudad cambiada-}
gobernarUnAño :: Gobierno -> Ciudad -> Ciudad
gobernarUnAño gobierno ciudad = map (aplicarMedidas gobierno)  ciudad

aplicarMedidas :: Gobierno -> Ciudadano -> Ciudadano
aplicarMedidas gobierno ciudadano = foldl  (flip ($))  ciudadano (medidas gobierno)

{-
ghci> gobernarUnAño gobiernoA springfield
[UnCiudadano {profesion = "SeguridadNuclear", sueldo = 12000.0, cantidadDeHijos = 3.0, bienes = [("casa",50000.0),("deuda",-70000.0)]},UnCiudadano {profesion = "Empresario", sueldo = 286600.0, cantidadDeHijos = 1.0, bienes = [("empresa",1000000.0),("empresa",500000.0),("auto",200000.0)]},UnCiudadano {profesion = "Profesor", sueldo = 12000.0, cantidadDeHijos = 1.0, bienes = []},UnCiudadano {profesion = "Profesor", sueldo = 12000.0, cantidadDeHijos = 0.0, bienes = [("casa",35000.0)]}]
-}

{-que recibe un gobierno y una ciudad, y gobierna
a esa ciudad todos los años del período (Es decir, gobierna tantos años a la ciudad como haya
durado el mandato)-}
gobernarPeriodoCompleto :: Gobierno -> Ciudad -> Ciudad
gobernarPeriodoCompleto gobierno ciudad = foldl (\unaCiudad _ -> gobernarUnAño gobierno unaCiudad)  ciudad (años gobierno)

{-
ghci> gobernarPeriodoCompleto gobiernoA springfield
[UnCiudadano {profesion = "SeguridadNuclear", sueldo = 21000.0, cantidadDeHijos = 3.0, bienes = [("casa",50000.0),("deuda",-70000.0)]},UnCiudadano {profesion = "Empresario", sueldo = 235626.9, cantidadDeHijos = 1.0, bienes = [("empresa",1000000.0),("empresa",500000.0),("auto",200000.0)]},UnCiudadano {profesion = "Profesor", sueldo = 12000.0, cantidadDeHijos = 1.0, bienes = []},UnCiudadano {profesion = "Profesor", sueldo = 12000.0, cantidadDeHijos = 0.0, bienes = [("casa",35000.0)]}]
-}
{-que dice si un gobierno hizo justamente eso en una
ciudad. Esto es cuando luego de gobernar por todo su período, la diferencia de patrimonio es
menor que al iniciar-}
distribuyoRiqueza :: Gobierno -> Ciudad -> Bool
distribuyoRiqueza gobierno ciudad =  diferenciaDePatrimonio ciudad > (diferenciaDePatrimonio.gobernarPeriodoCompleto gobierno) ciudad

{-
ghci> distribuyoRiqueza gobiernoA springfield      
True
-}
