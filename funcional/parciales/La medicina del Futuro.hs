import Distribution.PackageDescription (BuildInfo(otherExtensions))

data Animal= Raton {nombre :: String, edad :: Double, peso :: Double,
 enfermedades :: [String]} deriving Show

-- Ejemplo de raton
cerebro :: Animal
cerebro = Raton "Cerebro" 9.0 0.2 ["brucelosis", "sarampión", "tuberculosis"]

orejudo :: Animal
orejudo = Raton "Orejudo" 4.0 10.0 ["obesidad", "sinusitis"]

-- Estos son las enfermedades infecciosas
enfermedadesInfecciosas :: [String]
enfermedadesInfecciosas = [ "brucelosis", "tuberculosis"]

--funciones auxiliares 
modificarNombre :: (String -> String ) -> Animal -> Animal
modificarNombre f animal = animal { nombre = (f.nombre) animal}

modificarEdad :: ( Double -> Double) -> Animal -> Animal
modificarEdad f animal = animal {edad = (f.edad) animal}

modificarPeso :: (Double -> Double) -> Animal -> Animal
modificarPeso f animal = animal {peso = f.peso $ animal}

modificarEnfermedades :: ([String]-> [String]) -> Animal -> Animal
modificarEnfermedades f raton = raton { enfermedades  = f.enfermedades $ raton}





{-a. hierbaBuena, que rejuvenece al ratón a la raíz cuadrada de su edad.
Por ejemplo, si a cerebro le doy hierbaBuena, se transforma en un ratón de 3 años.-}
hierbaBuena :: Animal -> Animal
hierbaBuena raton = modificarEdad sqrt raton

{-b. hierbaVerde, elimina una enfermedad dada.
Por ejemplo, si a cerebro le doy la hierbaVerde para la “brucelosis”, queda con
sarampión y con tuberculosis.-}
hierbaVerde :: String -> Animal -> Animal
hierbaVerde enfermedad raton = modificarEnfermedades (filter (/= enfermedad)) raton


{-c. alcachofa, hace que el ratón pierda peso en un 10% si pesa más de 2kg, sino pierde
un 5%.
Por ejemplo, un ratón de 3 kg queda con 2,7 kg y cerebro queda con 0.19 kg.-}

alcachofa :: Animal -> Animal
alcachofa raton = modificarPeso perderPeso raton

--funcion auxiliar 
perderPeso :: Double -> Double
perderPeso peso | peso > 2 = peso * 0.9  
                 | otherwise = peso * 0.95


{-d. hierbaMagica, hace que el ratón pierda todas sus infecciones y quede con 0 años de
edad.-}
hierbaMagica :: Animal -> Animal
hierbaMagica unAnimal = modificarEdad (0*).modificarEnfermedades (const [])  $ unAnimal



{-Hacer la función medicamento, que recibe una lista de hierbas, un ratón, y administra
al ratón todas las hierbas.-}
medicamento :: [(Animal -> Animal)] -> Animal -> Animal
medicamento hierbas raton = foldl  (flip ($)) raton  hierbas

medicamento' :: [(Animal -> Animal)] -> Animal -> Animal
medicamento' hierbas raton = foldl (\unRaton unaHierba -> unaHierba unRaton)  raton hierbas

{-b. Hacer antiAge que es un medicamento que está hecho con 3 hierbas buenas y una
alcachofa.
> antiAge (Raton "bicenterata" 256.0 0.2 [])
Raton "bicenterata" 2.0 0.19 []-}
antiAge :: Animal -> Animal
antiAge raton = medicamento (replicate 3 hierbaBuena ++ [alcachofa]) raton

{-c. Hacer reduceFatFast (que viene en distintas potencias) y es un medicamento
compuesto por una hierbaVerde de “obesidad” y tantas alcachofas como indique su
potencia-}
reduceFatFast  :: Int -> Animal -> Animal
reduceFatFast nro raton = medicamento ([hierbaVerde "obesidad"]++ ( replicate nro alcachofa)) raton

hierbaMilagrosa :: Animal -> Animal
hierbaMilagrosa raton = medicamento (map hierbaVerde enfermedadesInfecciosas) raton


{-
Hacer la función que encuentra la cantidadIdeal. Recibe una condición y dice cuál es
el primer número natural que la cumple.
> cantidadIdeal even  > cantidadIdeal (>5) 6-}

cantidadIdeal :: (Int -> Bool) -> Int
cantidadIdeal criterio = head . filter criterio $ [1..] 

{-b. Hacer la función estanMejoresQueNunca que dado un conjunto de ratones y un
medicamento, es cierto cuando cada uno pesa menos de 1 kg después de aplicarle el
medicamento dado.-}
estanMejoresQueNunca :: [Animal] -> (Animal -> Animal) -> Bool
estanMejoresQueNunca  ratones unMedicamento =   all ((<1).peso.unMedicamento) ratones

{-c. Diseñar el siguiente experimento: dado un conjunto de ratones, encontrar la potencia
ideal del reduceFatFast necesaria para que todos estén mejores que nunca.-}
potenciaIdeal :: [Animal] -> Int
potenciaIdeal ratones = cantidadIdeal (estanMejoresQueNunca ratones.reduceFatFast)

