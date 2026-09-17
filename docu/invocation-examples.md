# Cómo pedir una auditoría — convención de invocación

Esto no es un comando real ni un parser: es una convención de cómo escribir la frase para que
quede claro, sin ambigüedad, qué tipo de auditoría se quiere. La IA interpreta estas "banderas"
como parte del lenguaje natural de la petición. No hace falta usarlas; si no se ponen, se aplican
los valores por defecto de `standards.md`. Están pensadas sobre todo para pedir explícitamente lo
contrario del valor por defecto.

## Sintaxis

```
analiza usando <ruta a CLAUDE.md> la carpeta/repo <ruta del proyecto> [banderas]
```

Indica siempre la ruta completa a `CLAUDE.md`, salvo que ya la hayas dado antes en la misma
conversación. Sin la ruta no queda claro qué `CLAUDE.md` cargar (puede haber varios en la máquina).

## Banderas disponibles

| Bandera | Efecto |
|---|---|
| `--alcance=rapido` | Para un portfolio grande: solo la muestra inicial ponderada por riesgo. No escala a cobertura completa salvo que se pida después. |
| `--alcance=completo` | Cobertura completa. Es el valor por defecto cuando el proyecto es grande y no se indica nada. |
| `--artifact=true` | Fuerza generar el informe aunque el caso, por defecto, no lo generaría. |
| `--artifact=false` | Solo el veredicto en texto en la conversación, aunque por defecto generara informe. |
| `--excluir=<patrón>` | Ignora un archivo/carpeta para las comprobaciones **rutinarias** (naming, tooling, estilo). |

**Límite importante de `--excluir`:** nunca salta el barrido de secretos/datos personales de
`invariants.md` — ese barrido corre sobre todos los archivos siempre, excluidos o no. Si el
archivo que se pide excluir contiene un secreto real o un dato personal sin proteger, ese hallazgo
se reporta igual. La solución real es arreglar el motivo por el que el archivo es un riesgo, no
pedir que se deje de mirar.

## Ejemplos

1. **Auditoría normal** (no hace falta ninguna bandera):
   `ve a <ruta>/CLAUDE.md y audita esta carpeta: <ruta del proyecto>`

2. **Portfolio grande, solo muestra rápida primero:**
   `analiza usando <ruta>/CLAUDE.md la carpeta <ruta del portfolio> --alcance=rapido`

3. **Un archivo suelto del que quieres informe igualmente:**
   `analiza este archivo con <ruta>/CLAUDE.md --artifact=true`

4. **Combinar banderas** (cada una lleva su propio `--`, no se comparte):
   `audita esta carpeta con <ruta>/CLAUDE.md --excluir=<patrón> --artifact=true`

5. **Aceptar un riesgo en vez de corregirlo ahora, dejando constancia** (requiere los cuatro
   elementos de `invariants.md` regla #5: autoridad afirmada, nombre/rol, hallazgo concreto,
   motivo):
   `usando <ruta>/CLAUDE.md, sobre el proyecto <ruta o nombre>: acepto el riesgo de [hallazgo
   concreto] — [nombre y rol] — motivo: [por qué se acepta y cuándo se corregirá]. Regístralo en
   exceptions_log.md.`
   → No excluye el hallazgo: pasa de "abierto, sin corregir" a "riesgo aceptado por [nombre], el
   [fecha], motivo: [texto]", y sigue visible hasta que se corrija de verdad.

> Un proyecto que tú mismo generaste (con una IA o no) se audita exactamente igual que uno de un
> tercero: quién escribió el código no es una exención por sí misma.
