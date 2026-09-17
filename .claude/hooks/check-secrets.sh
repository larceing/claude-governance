#!/usr/bin/env bash
#
# Hook de ejemplo (v0.0) — invariante nº1: nada de secretos en texto plano.
#
# Se dispara en PreToolUse para Write/Edit/MultiEdit. Recibe por stdin un JSON con la
# informacion de la herramienta que Claude Code va a ejecutar (incluye el contenido que
# se va a escribir). Si detecta un patron que parece un secreto, avisa.
#
# NOTA: Es un punto de partida deliberadamente simple y CONSERVADOR (solo avisa, no bloquea).
# El esquema exacto de entrada/salida de los hooks y los codigos de salida pueden variar segun
# la version de Claude Code: contrasta con la documentacion oficial antes de endurecerlo.
#
# Para BLOQUEAR en vez de solo avisar, se puede devolver un codigo de salida distinto de 0
# (revisar en la doc cual corresponde a "bloquear" en tu version).

set -euo pipefail

# Leer el payload que envia Claude Code por stdin.
payload="$(cat)"

# Patrones simples que suelen indicar un secreto en texto plano.
# Ampliar segun el stack real de la empresa.
patterns=(
  'api[_-]?key'
  'secret'
  'password'
  'passwd'
  'token'
  'connection[_-]?string'
  'BEGIN (RSA|OPENSSH|PRIVATE) KEY'
  'AKIA[0-9A-Z]{16}'          # AWS access key id
)

found=""
for p in "${patterns[@]}"; do
  if printf '%s' "$payload" | grep -Eiq "$p"; then
    found="${found}\n  - patron detectado: ${p}"
  fi
done

if [ -n "$found" ]; then
  # Mensaje a stderr para que quede visible. Salida 0 = solo aviso, no bloquea.
  printf 'AVISO DE GOBERNANZA (invariante nº1: secretos en texto plano)\n' >&2
  printf 'Se han detectado posibles secretos en el contenido a escribir:%b\n' "$found" >&2
  printf 'Revisa que ningun secreto quede en texto plano. Ver invariants.md.\n' >&2
fi

exit 0
