# ID 32 — Integración y trazabilidad del CU-12 | Sprint 03

**Proyecto:** PSPS · **Responsable:** Marco Antonio de Jesús Oliva Santos  
**Actividad:** ID 32 · **Tarea:** T09 · **ISO:** SI.05.03 · **WP:** WP.08 Repositorio  
**Descripción PSR:** Integrar CU-12 mediante PR revisado y completar trazabilidad de los cambios.  
**Antecedentes:** S3-24 (flujo CU-12); S3-25 (pruebas de CU-11 y CU-12).  
**Horas estimadas:** 1.50 h.
**Repositorio del PSR:** https://github.com/XlayersCeboso99/TSP_PSPS

## 1. Resultado verificado en GitHub (consulta del 12/11/2026)

- **PR #20, CU-12** — `feature/cu12-recordatorios` → `feature/cu11-notas`. Estado: **merged** el 12/11/2026. Contiene código del recordatorio, persistencia local, permisos, programación, pantalla y pruebas. En GitHub figuran **dos revisiones APPROVED** por `PabloValentinn` registradas el 09/11/2026. Enlace: https://github.com/XlayersCeboso99/TSP_PSPS/pull/20
- **PR #21, calidad** — `test/sprint3-cu11-cu12-id21` → `feature/cu12-recordatorios`. Estado: **merged** el 12/11/2026. Agrega pruebas de calidad a CU-11 y CU-12. Enlace: https://github.com/XlayersCeboso99/TSP_PSPS/pull/21
- **PR #22, integración conjunta** — `feature/cu11-notas` → `develop`. Estado: **merged** el 12/11/2026; lleva CU-11, CU-12 y pruebas a `develop`. **La página del PR #22 no muestra revisiones de aprobación registradas**. Enlace: https://github.com/XlayersCeboso99/TSP_PSPS/pull/22
- **PR #23, revisión formal posterior** — registrado como merged, pero **no aparecen revisiones formales en GitHub**. No debe presentarse como prueba de aprobación del PR #22. Enlace: https://github.com/XlayersCeboso99/TSP_PSPS/pull/23

**Conclusión técnica:** el CU-12 ya está incorporado en `develop`. No corresponde volver a incorporar el mismo código ni declarar un PR nuevo de integración cuando no hay una diferencia real por integrar. Para cerrar documentalmente el ID 32, conservar las referencias anteriores y verificar con el equipo si la revisión del PR #20 basta como revisión independiente de CU-12; si se exige revisión previa de la integración final a `develop`, registrar esa salvedad, ya que no puede retroactivamente aprobarse el PR #22.

## 2. Trazabilidad CU-12 / RF-13 / CA-13

Los siguientes artefactos se verificaron en el repositorio original bajo `Sprint 2/psps_academy/`, rama `develop`, o en la lista de archivos del PR #20:

| Necesidad verificada | Implementación | Evidencia de prueba / revisión |
|---|---|---|
| Configurar recordatorio semanal: hora y días, desactivado inicialmente, 18:00 y siete días por defecto | `lib/data/reminder_store.dart`; `lib/domain/reminder_controller.dart`; `lib/ui/reminder_screens.dart` | `test/cu12_reminders_test.dart` y `test/sprint3/cu12_quality_test.dart` |
| Guardar de modo local e independiente del progreso | `lib/data/reminder_store.dart` con clave `psps.reminder.v1` | Pruebas de persistencia en `test/cu12_reminders_test.dart` |
| Pedir permiso al activar y abrir ajustes del sistema si se niega | `lib/domain/reminder_controller.dart`; `lib/platform/reminder_notifications.dart`; `lib/ui/reminder_screens.dart` | Escenarios de permisos en pruebas CU-12, entre otros TU-S3-12-23 y TW-S3-12-13 |
| Programar los días seleccionados, sustituir horarios y cancelar días retirados sin duplicados | `lib/domain/reminder_controller.dart`; `lib/platform/reminder_notifications.dart` | Pruebas de programación y cancelación en `test/cu12_reminders_test.dart` y pruebas de calidad |
| Validar horas/días, proteger doble guardado y recuperar un estado previo si falla la programación | `lib/data/reminder_store.dart`; `lib/domain/reminder_controller.dart` | TU-S3-12-22, TU-S3-12-24, TU-S3-12-28 y TU-S3-12-29 en pruebas Sprint 3 |
| Navegación de inicio a recordatorio y vuelta al inicio al tocar aviso | `lib/ui/app.dart`; `lib/ui/reminder_screens.dart`; `lib/platform/reminder_notifications.dart` | Pruebas de widget CU-12; pruebas reales de notificación deben respaldarse con WP.15 |
| Configuración Android de avisos | `android/app/src/main/AndroidManifest.xml`; `android/app/build.gradle.kts`; `pubspec.yaml` | PR #20, archivos modificados; validar en dispositivo para WP.15 |

**Nota de alcance:** las pruebas unitarias o de widgets comprueban el controlador y sus dobles, pero por sí solas no demuestran la recepción de una notificación en un teléfono físico ni la persistencia después de reiniciar el dispositivo.

## 3. Evidencias y criterio de cierre para ID 32

**Evidencias disponibles:** PR #20 aprobado y fusionado, PR #21 fusionado, PR #22 fusionado a `develop`; código de CU-12 visible en `develop`. Se identificaron ejecuciones correctas del workflow «CU-11 and CU-12 Flutter validation» asociadas al commit integrado (runs 43314357662 y 43312398766). Estos registros no sustituyen las pruebas físicas del WP.15.

**Pendiente para dejarlo completamente documentado:**

1. Conservar capturas o enlaces permanentes de la pestaña *Conversation* y *Files changed* del PR #20, y de la pestaña *Conversation* del PR #22.
2. Guardar esta trazabilidad en la carpeta documental del Sprint 3 o en el repositorio, según el acuerdo de equipo.
3. Registrar nombre del revisor, fecha y observaciones reales. No inventar una aprobación en PR #22.
4. Si el equipo decide realizar un PR documental para ID 32, abrir una rama **solo para la trazabilidad** y solicitar revisión de otro integrante antes de fusionar; **no afirmar que dicho PR documental revisó retroactivamente el código**.
5. Registrar las horas reales y actualizar el PSR únicamente después de validar los criterios anteriores.

**Estado del ID 32 al elaborar este documento:** integración de código ya efectuada; trazabilidad preparada; pendiente de validar el criterio de revisión del merge final y registrar las evidencias de cierre de la actividad. 

## 4. Referencias verificables

- PSR Sprint 03, hoja `Control_Diario`, fila 33 (ID 32), fila 32 (ID 31), fila 34 (ID 33).
- PR CU-12 (#20): https://github.com/XlayersCeboso99/TSP_PSPS/pull/20
- PR de pruebas (#21): https://github.com/XlayersCeboso99/TSP_PSPS/pull/21
- PR de integración (#22): https://github.com/XlayersCeboso99/TSP_PSPS/pull/22
- PR de revisión posterior (#23): https://github.com/XlayersCeboso99/TSP_PSPS/pull/23
- Código integrado: https://github.com/XlayersCeboso99/TSP_PSPS/tree/develop/Sprint%202/psps_academy
- CI de integración: https://github.com/XlayersCeboso99/TSP_PSPS/actions/runs/43314357662
