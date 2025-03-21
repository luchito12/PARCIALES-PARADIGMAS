--punto 1
data Auto = UnAuto{
  marca :: String,
  modelo :: String,
  desgasteEnChasis :: Desgaste,
  velocidadMaxima :: Float,
  tiempoDeCarrera :: Float
}deriving ( Show, Eq)

type Desgaste = (Float, Float)

chasis :: Desgaste -> Float
chasis = fst
ruedas :: Desgaste -> Float
ruedas = snd

ferrari :: Auto
ferrari = Auto "Ferrari" "F50" (0, 0) 65 0
lambo :: Auto
lambo = Auto "Lamborghini" "Diablo" (7, 4) 73 0
fitito :: Auto
fitito = Auto "Fiat" "600" (33, 27) 44 0

--punto 2
estaEnBuenEstado :: Auto -> Bool
estaEnBuenEstado = estaBien . desgaste

estaBien :: Desgaste -> Bool
estaBien unDesgate = chasis unDesgate < 40 && ruedas unDesgate < 60

--b
noDaMas :: Auto -> Bool
noDaMas = estaMalo . desgaste

estaMalo :: Desgaste -> Bool
estaMalo unDesgate = chasis unDesgate > 80  || ruedas unDesgate > 80

--punto 3 
repararUnAuto :: Auto -> Auto
repararUnAuto = modificarElDesgasteChasis (* 0.15) . modificarElDesgasteRuedas (const 0)

--mappeos
modificarElDesgasteChasis:: (Float -> Float) -> Auto -> Auto
modificarElDesgasteChasis f unAuto = unAuto {
 desgaste = ((f . chasis . desgaste) unAuto, ruedas (desgaste unAuto))
}

modificarElDesgasteRuedas :: (Float -> Float) -> Auto -> Auto
modificarElDesgasteRuedas f unAuto = unAuto {
 desgaste = (chasis (desgaste unAuto), (f . ruedas . desgaste) unAuto)
}

--punto 4
type Tramo = Auto -> Auto


--a
curva :: Float -> Float -> Tramo
curva unAngulo unaLongitud unAuto =
 modificarElDesgasteRuedas (+ desgasteCurva) . aumentarTiempo segundos $ unAuto
 
 where
 desgasteCurva = 3 * unaLongitud / unAngulo
 segundos = unaLongitud / velocidadMaxima unAuto / 2

--mappeo
aumentarTiempo :: Float -> Auto -> Auto
aumentarTiempo unosSegundos unAuto = unAuto {
 tiempoDeCarrera = tiempo unAuto + unosSegundos
}

-- a.i --
curvaPeligrosa :: Tramo
curvaPeligrosa = curva 60 300

-- a.ii --
curvaTranca :: Tramo
curvaTranca = curva 110 550

--punto b 
recta :: Float -> Tramo
recta unaLongitud unAuto =
 modificarElDesgasteChasis (+ (unaLongitud / 100)) . aumentarTiempo segundos $ unAuto
 where
 segundos = unaLongitud / velocidadMaxima unAuto

-- b.i --
rectaClassic :: Tramo
rectaClassic = recta 750

-- b.ii --
tramito :: Tramo
tramito = recta 280


--punto c 
pasarPorBoxes :: Tramo -> Tramo
pasarPorBoxes unTramo unAuto 
 |estaEnBuenEstado unAuto = unTramo unAuto
 |otherwise = aumentarTiempo 10 . repararUnAuto $ unAuto

--punto d 
estaMojada :: Tramo -> Tramo 
estaMojada unTramo unAuto 
aumentarTiempo segundosPorMojado . unTramo $ unAuto
 where
 segundosPorMojado = ( tiempoDeCarrera (unTramo unAuto) - tiempoDeCarrera unAuto) / 2

--punto e 
ripio :: Tramo -> Tramo
ripio unTramo = unTramo . unTramo

--punto f 
obstruccion :: Tramo -> Float -> Tramo
obstruccion unTramo unaLongitud unAuto =
 cambiarDesgasteRuedas (+ (unaLongitud * 2)) . unTramo $ unAuto

--punto 5 
pasarPorTramo :: Tramo -> Auto-> Auto
pasarPorTramo unTramo UnAuto 
 | noDaMas unAuto = unAuto
 | otherwise = unTramo unAuto 

--punto 6
type Pista [Tramos]

superpista :: Pista 
superpista = [
  tramoRectoClassic,
  curvaTranca,
 (tramito . mojar tramito),
 obstruccion (curva 80 400) 2,
 curva 115 650,
 recta 970,
 curvaPeligrosa,
 ripio tramito,
 boxes (recta 800)
]

peganLaVuelta :: Pista -> [Autos] -> [Autos]
peganLaVuelta unaPista = filter (not . noDaMas) . map (darLaVuelta unaPista)

darLaVuelta :: Pista -> Auto -> Auto
darLaVuelta unaPista unAuto = foldl pasarPorTramo unAuto unaPista

--punto 7 
data Carrera = UnaCarrera {
  pista :: Pista,
  numeroDeVueltas :: Int
}

tourBuenosAires :: Carrera
tourBuenosAires = Unacarrera superpista 20

correr :: [Auto] -> Carrera -> [[Auto]]
correr unosAutos unaCarrera =
 take (vueltas unaCarrera) . iterate (peganLaVuelta (pista unaCarrera)) $ unosAutos


