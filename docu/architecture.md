# Arquitectura — cuatro capas complementarias

Extender el uso de una IA de desarrollo (p. ej. Claude Code) a toda una organización multiplica
quién puede crear o modificar desarrollos, sin que todos conozcan las prácticas mínimas de
seguridad y cumplimiento. Más gente generando cosas por su cuenta es más superficie de riesgo, no
solo más productividad — salvo que se ponga algo en medio.

El objetivo no es frenar la adopción por miedo, sino **habilitar con barreras**. Las opciones que
se suelen barajar (avisar, recordar, bloquear, auditar) no son alternativas entre las que elegir
una: son capas complementarias que resuelven problemas distintos y se apoyan entre sí.

| Capa | Mecanismo | Qué problema resuelve |
|---|---|---|
| 1. Aviso | `CLAUDE.md` gestionado, desplegado a todas las máquinas | Que cualquier persona reciba automáticamente el aviso de la política en el momento en que pide algo riesgoso, sin depender de que sepa que el riesgo existe. |
| 2. Memoria | Repositorio central compartido (estándares, ejemplos, excepciones, historial) | Que cada caso nuevo se resuelva más rápido porque la IA ya conoce el stack aprobado y los casos anteriores, en vez de partir de cero. |
| 3. Bloqueo | Hooks técnicos (`PreToolUse`) que impiden una acción pase lo que pase | Que los casos más graves no dependan solo de que la persona haga caso al aviso: hay una barrera técnica real detrás. |
| 4. Auditoría | Analizador de cumplimiento ejecutado bajo demanda o de forma periódica | Que lo ya construido se pueda revisar entero contra el checklist y obtener un resumen simple más el detalle técnico. |

## Cómo se implementa cada capa

**1. Aviso.** Un `CLAUDE.md` gestionado se despliega en la ruta del sistema de cada máquina (vía
MDM, directiva de grupo o equivalente). La IA lo carga en cada sesión sin que nadie lo configure.
Ahí vive la política en lenguaje llano: qué stack está aprobado, qué herramientas están permitidas
y qué verificar antes de ayudar a "publicar" algo.

**2. Memoria.** Un repositorio central (fuera de cada proyecto) con los archivos vivos de esta
base de conocimiento. Cada proyecto lo enlaza (p. ej. un symlink en su carpeta `.claude/rules/`),
de forma que todos comparten el mismo conocimiento sin duplicarlo y una actualización central se
refleja en todos a la vez.

**3. Bloqueo.** Para los riesgos más graves no basta con avisar: hooks (`PreToolUse`) que impiden
una acción concreta pase lo que pase (p. ej. bloquear un intento de escribir o compartir un
archivo si se detecta un patrón de secreto en texto plano). Ver `.claude/hooks/`.

**4. Auditoría.** El analizador de cumplimiento se ejecuta contra cualquier proyecto y devuelve un
resumen simple (cumple / no cumple, qué falta) más el detalle técnico, incluyendo cómo corregir
cada hallazgo.

## Hoja de ruta sugerida (de la barrera más rápida a la más completa)

1. Redactar y desplegar el `CLAUDE.md` de política (capa de aviso), empezando en modo informativo
   antes de convertir cualquier regla en bloqueo duro.
2. Crear el repositorio central de memoria compartida y enlazarlo a los proyectos existentes.
3. Definir e implementar los primeros hooks de bloqueo, priorizando la detección de secretos.
4. Extender el acceso a toda la organización, con las capas anteriores ya activas.
5. Establecer una cadencia de auditoría periódica sobre los proyectos activos.

> El diagrama del modelo de control (setpoint + bucles de realimentación) está en
> `docu/feedback-loops.svg`. El porqué del modelo, en `methodology.md`.
