# Videojuegos

## Consigna

Queremos modelar cómo varía la diversión de `delfina`, una niña a la que le gusta jugar videojuegos. 

Las consolas que tiene disponibles son:

- Una `play` que otorga una jugabilidad de 10 unidades
- Y una `portatil` que otorga una jugabilidad de 8, a menos que tenga la _batería baja_, en ese caso solamente 1 unidad

Delfina comienza con la play. Queremos hacer que juegue a un videojuego. Cuando esto sucede:

- primero `delfina` aumenta su nivel de diversión según cuánto otorgue el juego
- Y luego se le asigna un uso a la consola

Cuando alguien usa la `play` no pasa nada, pero cuando la `portatil` se usa queda con _batería baja_.


`delfina` siempre comienza con un nivel de diversión de 0 y tiene muchos videojuegos, por ahora nos interesa modelar:

- `arkanoid`: otorga una diversión de 50 unidades
- `mario`: si la consola tiene la jugabilidad necesaria (mayor que 5) otorga una diversión de 100 unidades, caso contrario 15
- `pokemon`: la diversión que otorga se calcula como 10 * la jugabilidad de la consola


> Se pide:
>
> 1. Las consolas entiendan el mensaje `jugabilidad()` que indica cuánta jugabilidad otorga.
> 2. Las consolas entiendan el mensaje `usar()` que provoca que la consola reciba un uso.
> 3. `delfina` entienda el mensaje `agarrar(consola)` para cambiar la consola que tiene en la mano.
> 4. `delfina` entienda el mensaje `jugar(videojuego)`.
> 5. `delfina` entienda el mensaje `diversion()` que indica su nivel de diversión.

## Conclusiones

Este ejercicio tiene muchos lugares para aplicar _polimorfismo_: de `delfina` hacia las consolas y/o videojuegos, y de los videojuegos hacia las consolas. Recordemos que una solución con _polimorfismo_ implica abstraerse en algún punto de la lógica concreta de cada objeto de un conjunto para poder tratar indistintamente uno u otro. Para lograr esto, es necesario que esos objetos **entiendan los mismos mensajes** (no todos, sino los necesarios para poder tratarlos _polimórficamente_). Esto aparece:

- Al calcular la diversión que otorga un videojuego. En algunos casos eso depende de la consola que se use (para `mario` y `pokemon`) mientras que en otros no (como `arkanoid`). Si queremos tratarlos _polimórficamente_ (como al hacer que `delfina` juegue) será necesario que el mensaje sea el mismo (esto incluye nombre y parámetros), así que si algunos del grupo necesitan algún parámetro (como podría ser la consola) entonces todos lo deberían recibir (por más que en algunos casos no se use).
- Al usar una consola. Si bien `portatil` sufre un efecto al ser usada, `play` no. Entonces, **¿es necesario que el objeto `play` tenga un método `usar()` que no hace nada?** Si queremos tratarlas _polimorficamente_ (como al hacer que `delfina` juegue), entonces sí. Como es indiferente qué consola se esté usando, ambos objetos son posibles candidatos de recibir el mensaje `usar()` y, para el caso particular de `play`, **NO es lo mismo tener un método que no hace nada en vez de no tenerlo: en el primer caso el objeto entiende el mensaje y no hace nada, en el segundo no se entiende el mensaje y _el programa se rompe_**.

Además, todo este esquema es posible de manejar dado que cada objeto tiene _responsabilidades_ bien definidas. Hay que tener cuidado, por ejemplo, al calcular la diversión que otorga un videojuego, que en la mayoría de los casos depende de dos objetos: el videojuego y la consola. Entonces, **¿a quién se le manda el mensaje, a la consola o al videojuego?**

Prestando atención, si bien la lógica necesita de ambos objetos, por cómo está planteado este caso, **el que define cómo se calcula la diversión es el videojuego**, y la consola (en realidad, su jugabilidad) es solamente un dato para resolver la ecuación. Así que lo mejor para saber qué cálculo hacer sería **mandarle el mensaje para saber la diversión que otorga al videojuego** (pasándole la consola por parámetro si es necesario) y aprovechar el _polimorfismo_.

Por último, para reflexionar: **¿cómo modelaste que `portatil` tenga _batería baja_? ¿qué se guarda como atributo? ¿la jugabilidad la calcula en el momento de usarse o se la guarda previamente?**

