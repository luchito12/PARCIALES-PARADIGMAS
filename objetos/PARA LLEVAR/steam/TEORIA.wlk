/*
////////////////////////// TEORIA //////////////////////////
Justificar la utilidad de la herencia en la resolución, o el motivo de no haberla utilizado.
* En mi resolución fui cambiando la manera de resolver según los requerimientos. En el punto 1 [DESCUENTOS] decidí no utilizar herencia
 * y utilizar composición en su lugar. Esto se debe que, aunque los descuentos tengan ciertas características en común, me pareció más apropiado
 * hacerlo de esta manera debido a que el descuento del juego no es algo fijo y puede ser cambiado, entonces el cálculo del precio del juego lo delegé
 * al descuento que tuviese en ese momento, sin importar cual fuese.
 * Por otro lado, en el punto 3 [REVIEWS] si decidí utilzar herencia porque me pareció que los tres tipos de críticos posibles podrían ser subcalses
 * de la clase Crítico, ya que los tres tenian puntos en común. Por ejemplo, la manera en la que dan una crítica es igual para todos los casos, por lo
 * tanto el método criticar está definida en la clase padre, mientras que la manera en la que generan el texto de la crítica es diferente para cada 
 * crítico, por lo tanto cada forma está definida en cada subclase. En la clase padre este método está vacío ya que es una clase abstracta, no puede
 * instanciarse ya que no puede haber críticos genéricos.
 * 
Para pensar: ¿qué pasaría si en una revista, entre sus críticos, hay a su vez una revista?
El código funcionaría correctamente, debido a que revista es polimórfica consigo misma, es decir, todos los métodos que aplica en sus integrantes para
* definir distintas características de si misma pueden ser aplicados a su vez en si misma.
* Un ejemplo de esto sería: Una revista esta compuesta de un usuario y otra revista que a su vez está compuesta por dos críticos.
* Para verificar si la revista da una crítica positiva se utiliza el método daCriticaPositiva, el cual se fija si la mayoría de sus
* integrantes den una crítica positiva.
* Primero verifica que el usuario de una crítica positiva haciendo que el usuario utilize su propio método daCriticaPositiva
* Luego verifica que la revista que la compone de una crítica positiva.
* Para esto, la revista que la compone utiliza su método daCriticaPositiva, que a su vez se fija que la mayoría de sus integrantes den
*  una crítica positiva, una vez hecho esto la revista "exterior" va a saber cual es la postura de la crítica de la revista "interior" y a su vez
* definir su propia postura en base a si hay mayoria negativa o positiva.
* */