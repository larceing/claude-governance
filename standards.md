# Estándares de cumplimiento — checklist

> Esqueleto v0.0. Las secciones marcan la estructura; los ítems concretos se rellenan según la
> realidad de cada empresa. Los cambios en la lógica de puntuación se registran en
> `prompt_changelog.md`.

## 1. Principio de evaluación

**Ausencia = incumplimiento, salvo que se excluya explícitamente.** Si algo que debería estar no
se encuentra, cuenta como no cumplido hasta que se justifique su exclusión — no se asume que
"seguramente está en otro sitio".

## 2. Formato de salida (dos capas)

Toda auditoría devuelve:
- **Resumen en lenguaje llano** — para quien no es técnico: qué está bien, qué falta, qué es
  urgente.
- **Detalle técnico** — ítem por ítem, con evidencia y, si falla, el arreglo concreto y una
  estimación de tiempo.

## 3. Marco de excepciones

- **3.1 Herramientas no aprobadas:** ver `tool_status.md`. Por defecto, señalar (no fallar
  automáticamente) una herramienta no aprobada pero equivalente a una aprobada.
- **3.2 Excepción por desajuste de alcance** ("este proyecto no necesita esto") **vs. renuncia a
  un control** ("decidimos no hacerlo aunque aplicaba"): nunca tratarlas igual en el resultado.
- **3.3 Sanity-check:** una excepción declarada se comprueba contra la evidencia real antes de
  aceptarla. Si contradice algo ya verificado, se marca.
- **3.4 Clasificación por tipo de proyecto (arquetipo):** clasificar el proyecto antes de aplicar
  el checklist técnico permite excluir en bloque secciones que no aplican. Si la forma no encaja
  en ningún arquetipo nombrado, nombrarla como categoría nueva en vez de forzarla en la más
  parecida.
- **Los invariantes nunca se excluyen** por ninguno de estos mecanismos (ver `invariants.md`).

## 4. Checklist técnico

> Rellenar con los ítems concretos de la empresa. Cada ítem: qué se comprueba, ejemplo de PASS,
> ejemplo de FAIL. Categorías sugeridas de partida:

- **4.1 Gestión de secretos y configuración** — `[PENDIENTE]`
- **4.2 Seguridad de transporte / red** — `[PENDIENTE]`
- **4.3 Autenticación y control de acceso** — `[PENDIENTE]`
- **4.4 Datos personales / privacidad (traza del flujo de datos)** — `[PENDIENTE]`
- **4.5 Calidad de código y pruebas** — `[PENDIENTE]`
- **4.6 Documentación mínima** — `[PENDIENTE]`
- **4.7 Control de versiones** — `[PENDIENTE]`
- **4.8 Uso de IA en desarrollo vs. producción** — `[PENDIENTE]`
- **4.9 Traza del flujo de datos** — `[PENDIENTE]`
- **4.10 Canal de distribución adecuado a la sensibilidad** — `[PENDIENTE]`
- **4.11 Uso de API de IA en runtime: modelo y gasto** — aplica a cualquier artefacto que llame
  a un modelo de IA de pago (chatbot, asistente, job que resume o clasifica).
  - **4.11.a Lista cerrada de modelos.** Se comprueba: el código solo admite modelos aprobados en
    `tool_status.md`. PASS: si el modelo aprobado no responde, prueba solo otro aprobado y, si no,
    falla con un error claro. FAIL: cae en cascada a cualquier modelo disponible, o el modelo se
    puede cambiar por configuración a uno no aprobado.
  - **4.11.b Tope duro en el proveedor.** Se comprueba: el proyecto/cuenta del proveedor tiene
    presupuesto mensual y alertas. PASS: presupuesto y alertas configurados, con captura o
    confirmación de quien administra la cuenta. FAIL: sin presupuesto, o solo alertas sin límite.
    No se puede verificar desde el código: si nadie lo confirma, cuenta como FAIL (§1).
  - **4.11.c Tope en la aplicación.** Se comprueba: la app registra los tokens de cada llamada y
    deja de llamar al superar el tope del mes. PASS: registro de consumo y corte con un mensaje
    claro. FAIL: no registra consumo.
  - **4.11.d Respuesta acotada.** Se comprueba: cada llamada fija un máximo de tokens de salida y
    limita el historial que se reenvía. PASS: ambos límites. PARTIAL: solo uno. FAIL: ninguno.
  - **4.11.e Clave dedicada.** Se comprueba: la clave de API es de un proyecto/cuenta usado solo
    por este artefacto. PASS: clave propia. FAIL: reutiliza la clave de otro sistema (el gasto y
    una fuga no se pueden aislar). La clave en sí sigue bajo el invariante 1.
  - **Varios motores:** si el artefacto usa varios modelos según la tarea (p. ej. uno barato por
    defecto y otro más capaz bajo demanda), cada motor se evalúa con 4.11.a y el tope de 4.11.c
    es común a todos.

## 5. Alcance y artefacto de salida

- `[PENDIENTE — cuándo generar un artefacto/informe descargable y cuándo basta la respuesta]`.

## 6. Guía de remediación

- Para cada FAIL/PARTIAL: pasos concretos de arreglo y estimación de tiempo (manual vs. con IA).
- Los ítems excluidos solo necesitan su razón en una línea, sin guía de arreglo.
