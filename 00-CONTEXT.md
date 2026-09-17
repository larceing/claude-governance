# Contexto — leer esto antes que nada en este repositorio

Este archivo existe para que cada auditoría o respuesta parta de la misma foto real de quiénes
somos, en vez de que la IA adivine el contexto a partir de una carpeta suelta. Todo lo demás
en este repositorio asume los datos de aquí.

Si algo en otro archivo parece contradecir esto, **este archivo manda para "quiénes somos y
cómo estamos organizados"**; `invariants.md` sigue mandando para "qué nunca es aceptable".

## Quiénes somos

- **Empresa / sector:** `[PENDIENTE]`
- **Audiencia principal de esta base de conocimiento:** `[PENDIENTE — p. ej. IT hoy; a futuro,
  personal no técnico]`. Asume, salvo que se diga lo contrario, que quien pide una auditoría
  puede no ser desarrollador.
- **Identidad de marca** (para cualquier cosa de cara al cliente): color(es) primario(s):
  `[PENDIENTE]`. Color(es) de acento: `[PENDIENTE]`. Logo / assets: `[PENDIENTE]`.
- **Propiedad de la infraestructura** (a quién apuntar cuando algo requiere que un humano lo
  compruebe): infra on-prem / servidores / AD: `[PENDIENTE — nombre del equipo]`.
  Cloud: `[PENDIENTE — nombre del equipo]`.
- **Autoridad de sign-off / excepciones:** `[PENDIENTE]`. Definir quién puede aceptar un riesgo
  o aprobar una excepción, y para qué ámbito. **No los desarrolladores por defecto.**
  Recomendado: por ámbito (aplicaciones, infraestructura, y una autoridad final de escalado).
- **Quién suele pedir una auditoría:** `[PENDIENTE — p. ej. personal de IT sobre sus propios
  proyectos o los de otros]`.

## Cómo mantener útil este archivo

Este archivo debe quedarse **corto y factual** — realidad organizativa, no política (la política
vive en `standards.md` e `invariants.md`). Actualiza los campos `[PENDIENTE]` según se conozcan,
en vez de dejarlos indefinidamente. Una auditoría que necesite un dato y encuentre un
`[PENDIENTE]` debe decirlo claramente en su salida, no adivinar.

Si la estructura de la empresa cambia, actualiza este archivo directamente — no necesita el
mismo control de cambios que `standards.md`, porque aquí van hechos, no política.
