# Intensamente

[Acá](https://docs.google.com/document/d/1E9wfEvoxYP9xE8I98DNfMjLCUQWLH7qy47zu5PZE2rQ/edit#) podés encontrar el enunciado del ejercicio.

## Decisiones

Para el `Punto 7`, el cual habla de los procesos mentales, decidí que railey tenga un atributo a un objeto instancia de la clase `ProcesosMentales` para que quede separada la lógica de lograr que siempre se ejecute último el proceso mental `liberacionDeRecuerdosDelDia`.

Además decidí que cada proceso mental entienda el mensaje `apply(unaPersona)` ya que eso los hace polimórficos con los bloques de código.

También notarán que cada **proceso mental** no cumple con una de las bases del paradigma. Esto está hecho a propósito con el fin de enfatizar que el proceso mental esta muy acoplado a **riley** y es tan invasivo de sus recuerdos que agregarle comportamiento al objeto riley es más molesto que romper el encapulamiento de ella. ¿Es discutible? Sí, completamente discutible pero procrastinemos esa discusión hasta que cursen `Diseño de Sistemas`.