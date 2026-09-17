# Base de conocimiento de cumplimiento

Este repositorio es la fuente de verdad compartida para la IA (p. ej. Claude Code) cuando se
le pide revisar, auditar o aconsejar sobre el cumplimiento de un proyecto con los estándares
de tecnología y gobernanza de la empresa.

## Cuándo usar esto

Si se pide auditar, revisar o comprobar el cumplimiento de un proyecto, carpeta o artefacto
(código, hoja de cálculo, macro, app, job de ETL, etc.), o algo como "¿esto cumple?",
"¿está listo para producción?" o "¿puedo compartir esto?":

0. **Lee `00-CONTEXT.md` primero, siempre.** Es la foto factual de quiénes somos. Si tiene
   campos `[PENDIENTE]` de los que depende tu respuesta, dilo en vez de suponer.
1. **Lee `invariants.md` y `standards.md` enteros** antes de nada. No te fíes de una versión
   recordada de una sesión anterior; pueden haber cambiado (mira `prompt_changelog.md`).
2. **Sigue `standards.md` tal cual:** su principio de evaluación, su marco de excepciones, su
   checklist y su formato de salida. Aplica `invariants.md` por encima, sin excepción.
3. **Antes de tratar un hallazgo como nuevo**, revisa `examples/` por si hay un caso parecido
   ya resuelto, y `exceptions_log.md` por si ya se concedió una excepción aplicable.
4. **Cada hallazgo FAIL/PARTIAL** genera una fila en `remediation_tracker.md` con estado `Open`.
   Si es una re-auditoría, actualiza las filas existentes en vez de solo repetir el hallazgo.

## Cerrar el bucle tras cada auditoría

El repositorio se vuelve más útil con cada caso. Al terminar una auditoría:

1. Escribe un archivo nuevo en `examples/` resumiendo el caso (nunca copies valores reales de
   secretos ni datos personales — describe el hallazgo, no pegues el valor).
2. Añade una fila por cada excepción concedida en `exceptions_log.md`.
3. Si cambiarías `standards.md`, anota la propuesta en `prompt_changelog.md`.

## Qué NO hacer

- No resumas `standards.md` de memoria en vez de leerlo.
- No te saltes el marco de excepciones porque un proyecto "obviamente" no lo necesite.
- **Nunca escribas secretos ni datos personales reales** en ningún archivo de esta base de
  conocimiento — descríbelos en términos generales.
