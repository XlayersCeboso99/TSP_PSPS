# CU-08 — Construcción y relación actividad–recompensa

**Proyecto:** PSPS Academy · **Sprint:** 02 · **Responsable:** Marco Antonio de Jesús Oliva Santos.
**Rama objetivo:** `feature/CU-08-actividades`.
**Estado:** código preparado para integrar; no se presume compilación, prueba ni commit.

## Comportamiento comprobable

- CU-08 / RF-09 / CA-09A: lista actividades agrupadas por módulo y tema, indicando `Pendiente` o `Realizada`. Consultar no cambia estados ni recompensas.
- Abrir una actividad delega el flujo a CU-02.
- MR-09: G-01 otorga **10 puntos** solo por primera finalización válida y guardada de una actividad elegible.
- MR-09: logros por actividades L-03, L-04, L-05 (una sola vez) y desbloqueo visual U-01 por L-03. **L-10 no existe en el catálogo aprobado**.
- Si falla el guardado, no se anuncia una recompensa confirmada.

## Archivos Dart

- `lib/features/cu08/activity_models.dart`: modelos y contrato de estado local.
- `lib/features/cu08/activity_engine.dart`: lectura sin efectos, finalización única y recompensas.
- `lib/features/cu08/activity_page.dart`: vista CU-08 con callback de navegación hacia CU-02.
- `test/cu08_activity_engine_test.dart` y `test/cu08_activity_page_test.dart`: pruebas preparadas.

## Integración necesaria ANTES de cerrar SI.04.02

1. **Conectar `ActivityStore` a `C07/ProgressStore` existente**; NO crear un segundo almacenamiento. Se deben conservar `answers`, `practices`, `achievedAt`, `reviewed`, `theme` y demás propiedades del estado vigente. La implementación del adaptador exige ver el código exacto que utiliza el equipo.
2. Registrar la ruta CU-08 en la navegación real de `psps_academy/lib`; conectar `onOpenActivity` con CU-02. No registrar finalización desde CU-08.
3. Mapear el catálogo de actividades real a `ActivityDefinition` con IDs únicos y los elementos obligatorios publicados.
4. Invocar `completeActivity` **desde CU-02/C05** después de validar los elementos. Coordinar recompensas con C06 existente y evitar duplicar su lógica.
5. Ejecutar pruebas y verificación en Android sin conexión, adjuntar resultados reales y completar revisión de código.

No se declara integración ni pruebas ejecutadas: el paquete se preparó sin acceso autenticado de escritura al repositorio ni SDK Flutter en este entorno.
