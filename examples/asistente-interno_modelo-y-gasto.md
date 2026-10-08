# Caso: asistente interno con API de IA de pago (modelo y gasto)

**Arquetipo:** aplicación web local (servidor Python + página HTML) que responde preguntas
internas llamando a la API de un proveedor de IA de pago. Prueba de campo en el PC de una
usuaria, sin datos reales del ERP todavía.

**Resultado general (primera auditoría):** el uso de IA era razonable para desarrollo, pero no
tenía ningún control de modelo ni de gasto. Motivó el nuevo §4.11 de `standards.md`.

| Ítem | Resultado | Hallazgo (descrito, sin valores) |
|---|---|---|
| 4.11.a | FAIL | Si el modelo aprobado fallaba, probaba en cascada una lista de ~10 modelos, incluidos otros más caros y no aprobados. |
| 4.11.b | Sin verificar → FAIL | El presupuesto del proyecto en el proveedor no se puede ver desde el código y nadie lo había confirmado. |
| 4.11.c | FAIL | No se guardaba el consumo de tokens de cada respuesta. |
| 4.11.d | PARTIAL | Historial limitado a 20 mensajes, pero sin máximo de tokens de salida. |
| 4.11.e | FAIL | Buscaba la clave en los `.env` de otros sistemas del mismo equipo y usaba la primera que encontraba. |
| Invariante 1 | OK | La clave se leía de un `.env`, no estaba en el código. |

**Arreglo aplicado:** lista cerrada de dos modelos aprobados (uno barato por defecto y otro más
capaz), dos "motores" (`rapido` / `preciso`) que solo pueden apuntar a modelos aprobados, máximo
de tokens de salida, tabla de consumo con coste estimado y corte al pasar el tope mensual
(configurable), un endpoint para consultar el gasto, y aviso al arrancar si la clave no es
propia. Cuando no se conoce el precio de un modelo, se estima con el de uno caro para que el
tope nunca se quede corto.

**Pendiente:** crear una clave dedicada (4.11.e) y confirmar el presupuesto en el proveedor
(4.11.b).

**Lección:** una lista de modelos "de respaldo" pensada para que la app no falle es, a efectos de
gobernanza, una puerta a usar herramientas no aprobadas (invariante 4) y a gastar sin control.
El respaldo debe quedarse dentro de la lista aprobada.
