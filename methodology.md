# Metodología — por qué está estructurado así

Este archivo no añade reglas de puntuación (no toca `standards.md` ni `invariants.md`). Explica
el **modelo mental** detrás del repositorio, para que cualquiera que lo retome entienda el porqué
de la estructura, no solo el qué.

## La idea en una frase

Este sistema es un **lazo de control**: tiene un punto de referencia fijo que no se negocia, y
dos bucles de realimentación de signo opuesto que giran a su alrededor — uno que lo estabiliza y
otro que lo acelera. No es una lista de pasos; es un sistema que se corrige a sí mismo con el
tiempo sin perder de vista un núcleo que nunca cambia.

## Las tres piezas

### 1. El punto de referencia fijo (setpoint) → `invariants.md`

Es la vara de medir. Define qué es "correcto" de forma que no dependa del proyecto, del usuario ni
de la conveniencia del momento. En un sistema de control, sin una referencia estable no existe la
idea misma de "corregir", porque corregir significa *acercarse a una referencia*. Si la vara se
dobla cada vez que estorba, deja de medir. Por eso los invariantes están deliberadamente **fuera**
de los bucles: pueden informar el aprendizaje, pero el aprendizaje no puede erosionarlos.

### 2. El bucle balanceador (realimentación negativa) → `remediation_tracker.md`

Es el que da **estabilidad**. Compara la realidad con el setpoint y empuja para cerrar la brecha:
¿el hallazgo se corrigió de verdad, o solo sobre el papel? Su trabajo es hacer que el sistema
*converja* hacia la referencia en lugar de quedarse en buenas intenciones.

Este bucle es también el detector de honestidad del sistema. Mientras ninguna fila llegue al
estado "corregido", el bucle está diciendo la verdad incómoda: *"detecta bien, pero todavía no
demuestra que corrija en la realidad"*. Un sistema sano es uno capaz de medir su propio fracaso.

### 3. El bucle reforzador (realimentación positiva) → `exceptions_log.md` + `examples/`

Es el que da **velocidad**. Acumula las decisiones ya tomadas y los casos ya resueltos, de forma
que cada análisis nuevo reutiliza el razonamiento anterior en vez de partir de cero. Con el
tiempo, cada vuelta es más rápida que la anterior.

Pero un bucle positivo sin freno se dispara: se retroalimenta hasta reforzar cosas que no debería.
Por eso lleva un **amortiguador** explícito — una decisión no se promueve a regla permanente hasta
que varios casos reales (p. ej. 3 o más) la respaldan. Ese freno es lo que separa *aprender* de
*sobreajustar*.

## La regla que lo une todo

> **Ninguna excepción del bucle reforzador puede tocar el núcleo fijo.**

El sistema puede aprender casi cualquier cosa —acelerar, adaptarse, reinterpretar un caso— menos
a saltarse sus propios límites. Esa es la línea que separa un sistema que mejora de uno que se
corrompe poco a poco racionalizando excepciones.

## Dos velocidades, no cuatro pasos

Es importante no dibujar esto como una cinta de montaje de fases iguales. Hay un **bucle rápido**
(dentro de un solo análisis: observar la evidencia → filtrar qué aplica → ejecutar el checklist) y
un **reloj lento** (entre análisis, a lo largo de semanas: comprobar si algo se corrigió y
acumular lo aprendido). El bucle rápido produce la *sensación* de avanzar; solo el reloj lento
demuestra que el sistema aprende de verdad.

## Una nota de honestidad sobre los nombres

Versiones anteriores de este marco usaban cuatro nombres prestados (mnemotecnias de trabajo) para
las fases. Son útiles como recordatorio, pero el modelo que de verdad describe este sistema es el
de la **teoría de control / cibernética**: un setpoint y dos lazos de realimentación de signo
opuesto. Si se usan las mnemotecnias, que sea como apoyo, no como fundamento — lo que hay que
poder defender es el modelo de control, no la atribución literal a ningún autor.

## Disciplina: no añadir más estructura de la que se ha ganado

Formalizar más piezas se siente productivo, pero no lo es por sí mismo. La prueba de que este
marco sirve no es tener una etiqueta bonita para cada cosa: es que un hallazgo real llegue a
corregirse de verdad. Hasta que eso ocurra de forma repetida, cualquier estructura nueva se trata
como ruido, no como progreso — el mismo principio que el amortiguador del bucle reforzador.
