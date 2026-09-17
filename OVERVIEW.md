# Marco de Gobernanza de IA — documento base

Este documento explica **qué es** el proyecto, **qué problema resuelve** y **cómo piensa** por
dentro. Es la lectura de contexto: para el detalle operativo, cada archivo del repositorio tiene
lo suyo (ver el mapa al final).

---

## 1. El problema

Extender una IA de desarrollo (por ejemplo, un asistente tipo Claude Code) a toda una organización
multiplica cuánta gente puede crear o modificar desarrollos. El problema es que no todas esas
personas conocen las prácticas mínimas de seguridad, arquitectura y cumplimiento que la empresa
espera de sus proyectos.

El riesgo típico no nace de la mala intención, sino de la lógica de *"en mi máquina funciona,
quiero que lo vean los demás"* — sin que nadie se pregunte por el camino si el archivo o el
servicio resultante es seguro de compartir tal cual. Más gente generando cosas por su cuenta es
**más superficie de riesgo, no solo más productividad**, si no se pone nada en medio.

El objetivo de este marco no es frenar la adopción por miedo. Es **habilitar con barreras**: que
cualquiera, sepa o no de tecnología, reciba un aviso en el momento justo, que los casos graves
tengan una barrera técnica real, y que revisar lo ya construido sea rápido y consistente.

---

## 2. La idea central: un sistema que se corrige a sí mismo

Este repositorio no es una lista de normas sueltas. Está diseñado como un **lazo de control**: la
misma lógica con la que un termostato mantiene una temperatura, aplicada a la gobernanza.

Tiene tres piezas:

### El punto de referencia fijo (setpoint) → `invariants.md`
Es la vara de medir. Define qué es inaceptable de una forma que **no depende del proyecto, del
usuario ni de la conveniencia del momento**. En un sistema de control, sin una referencia estable
no existe la idea misma de "corregir", porque corregir significa acercarse a una referencia. Si la
vara se dobla cada vez que estorba, deja de medir. Por eso los invariantes están fuera de todo lo
demás: el sistema puede aprender, pero el aprendizaje no puede erosionarlos.

### El bucle balanceador (realimentación negativa) → `remediation_tracker.md`
Es el que da **estabilidad**. Compara la realidad con la referencia y empuja para cerrar la
brecha: ¿el hallazgo se corrigió de verdad, o solo sobre el papel? Es, además, el detector de
honestidad del sistema: mientras un hallazgo siga abierto, este bucle dice la verdad incómoda —
*"se detecta, pero todavía no se ha demostrado que se corrija en la realidad"*. Un sistema sano es
uno capaz de medir su propio fracaso.

### El bucle reforzador (realimentación positiva) → `exceptions_log.md` + `examples/`
Es el que da **velocidad**. Acumula decisiones ya tomadas y casos ya resueltos, para que cada
análisis nuevo reutilice el razonamiento anterior en vez de partir de cero. Pero un bucle positivo
sin freno se dispara, así que lleva un **amortiguador**: una decisión no se convierte en regla
permanente hasta que varios casos reales la respaldan. Ese freno es lo que separa *aprender* de
*sobreajustar*.

### La regla que lo une todo
> **Ninguna excepción del bucle reforzador puede tocar el núcleo fijo.**

El sistema puede aprender casi cualquier cosa —acelerar, adaptarse, reinterpretar un caso— menos a
saltarse sus propios límites. Esa es la línea que separa un sistema que mejora de uno que se
corrompe poco a poco racionalizando excepciones.

---

## 3. Dos velocidades

No conviene imaginar esto como una cinta de fases iguales. Hay un **bucle rápido** (dentro de un
solo análisis: observar la evidencia → filtrar qué aplica → ejecutar el checklist) y un **reloj
lento** (entre análisis, a lo largo de semanas: comprobar si algo se corrigió y acumular lo
aprendido). El bucle rápido produce la sensación de avanzar; solo el reloj lento demuestra que el
sistema aprende de verdad.

> Nota de honestidad intelectual: versiones anteriores describían esto con cuatro nombres
> prestados de distintos autores. Son útiles como mnemotecnia, pero el modelo que de verdad
> describe el sistema es el de la **teoría de control / cibernética** (un setpoint y dos lazos de
> realimentación de signo opuesto). Lo que hay que poder defender es el modelo, no la atribución.

---

## 4. Las cuatro capas de defensa

Avisar, recordar, bloquear y auditar no son alternativas: son capas complementarias.

| Capa | Mecanismo | Qué resuelve |
|---|---|---|
| 1. Aviso | `CLAUDE.md` gestionado en cada máquina | Que la política llegue automáticamente en el momento del riesgo, sin depender de que la persona lo sepa. |
| 2. Memoria | Este repositorio central, enlazado a cada proyecto | Que cada caso se resuelva más rápido reutilizando lo aprendido. |
| 3. Bloqueo | Hooks técnicos (`PreToolUse`) | Que los casos graves tengan una barrera real, no solo un aviso. |
| 4. Auditoría | Analizador de cumplimiento, bajo demanda o periódico | Que lo ya construido se revise entero y de forma consistente. |

Detalle e implementación de cada capa: `docu/architecture.md`.

---

## 5. Principios de diseño (el "alma" del proyecto)

1. **La realidad tiene derecho a veto.** Observar directamente en vez de inferir: cargar la URL en
   vivo en lugar de asumir que hay cifrado, mirar el contenido real de un archivo en vez de fiarse
   del nombre. El modelo del mundo siempre está por debajo del mundo; cuando chocan, gana el mundo.
2. **Un bucle necesita un punto fijo o se va a la deriva.** De ahí los invariantes fuera del bucle.
3. **El bucle solo cuenta si se cierra.** Detectar no es corregir. La prueba de que el sistema
   sirve no es tener una etiqueta bonita para cada pieza: es que un hallazgo real llegue a
   arreglarse de verdad.
4. **No añadir más estructura de la que se ha ganado.** Una idea se vuelve regla solo cuando varios
   casos reales la respaldan. Hasta entonces, es ruido, no progreso.
5. **Nunca copiar secretos ni datos personales reales** en los archivos de esta base de
   conocimiento: se describen los hallazgos, nunca se pega el valor.

---

## 6. Mapa del repositorio

| Archivo | Rol en el modelo |
|---|---|
| `invariants.md` | El punto de referencia fijo (setpoint). |
| `standards.md` | El checklist contextual que se ejecuta en cada análisis. |
| `00-CONTEXT.md` | Los hechos de la organización, separados de la política. |
| `remediation_tracker.md` | El bucle balanceador (¿se corrigió de verdad?). |
| `exceptions_log.md` + `examples/` | El bucle reforzador (acumula y acelera). |
| `prompt_changelog.md` | El historial de cambios de las propias reglas. |
| `tool_status.md` | Herramientas aprobadas / desaconsejadas / prohibidas. |
| `methodology.md` | El porqué del diseño, en detalle. |
| `docu/architecture.md` | Las cuatro capas y la hoja de ruta. |
| `docu/invocation-examples.md` | Cómo pedir una auditoría. |
| `docu/feedback-loops.svg` | El diagrama del modelo de control. |
| `.claude/` | Los hooks de bloqueo (capa 3). |

---

## 7. Estado

Versión 0.0 — esqueleto inicial, genérico y sin datos de ninguna organización. Pensado para
copiarse a un repositorio, rellenar los campos `[PENDIENTE]` y crecer caso a caso. El historial de
cambios vive en `prompt_changelog.md`.
