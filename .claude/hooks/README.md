# Hooks de Claude Code

Los hooks son comandos que Claude Code ejecuta automáticamente en ciertos momentos (antes o
después de usar una herramienta, al enviar un prompt, etc.). Aquí se usan para reforzar los
invariantes de forma automática, sin depender de que alguien se acuerde de comprobarlos.

## Qué hay aquí (v0.0)

- **`check-secrets.sh`** — se dispara antes de escribir/editar archivos (`PreToolUse` con
  matcher `Write|Edit|MultiEdit`) y avisa si el contenido parece contener un secreto en texto
  plano (invariante nº1). Por defecto **solo avisa**, no bloquea.

La configuración que activa el hook está en `../settings.json`.

## Cómo usarlo

1. Dale permisos de ejecución al script:
   ```
   chmod +x .claude/hooks/check-secrets.sh
   ```
2. Comprueba que `../settings.json` está presente y con el esquema correcto para tu versión de
   Claude Code.

## Importante

El esquema exacto de los hooks (nombres de eventos, formato del payload por stdin, códigos de
salida para "avisar" vs. "bloquear") **puede cambiar según la versión de Claude Code**. Estos
archivos son un punto de partida funcional y conservador: **contrasta con la documentación
oficial de Claude Code** antes de endurecer el comportamiento (por ejemplo, pasar de avisar a
bloquear un commit).

## Ideas para ampliar (pendiente)

- Un hook `PreToolUse` que impida escribir datos personales reales en `examples/`.
- Un hook que recuerde "cerrar el bucle" (`examples/`, `remediation_tracker.md`) al terminar.
- Un hook de pre-commit (git) equivalente, para la barrera antes de subir al repositorio.
