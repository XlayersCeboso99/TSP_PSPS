# Corrección del defecto H-01: Respuesta repetida sin retroalimentación nueva

Responsable: Pablo Valentín Varela Rivera. Entrega técnica: 26/10/2026. Pruebas ejecutadas el 26/10/2026. Rama: fix/H-01-respuesta-repetida. Base: main, commit 53355a9913e36a06115ffd10997a519b8660701f; aplicación Flutter 0.2.0-dev.2+3.

## 1. Defecto

| Dato | Registro |
| --- | --- |
| ID | H-01 |
| Requisito | RP-02 (SRS v0.1 §2); CU-01; TU-04 |
| Evidencia | WP.15 del Sprint 01, hallazgo H-01 «Repetición de respuestas» (estado parcial); auditoría del Sprint 01; TU-04 parcial. |
| Actividad | IDs 33 y 40 del PSR, T07 / SI.04.02 (planeada 21 y 22/10/2026, 3.00 h estimadas para los cinco defectos). Horas reales pendientes de registrar por Pablo. |
| Verifica | Sebastián Guerra Hernández, ID 61 del PSR (27/10/2026). |

Después de comprobar una pregunta, las opciones quedaban deshabilitadas y no había forma de responder otra vez. RP-02 pide que las respuestas posteriores actualicen la retroalimentación sin incrementar las preguntas respondidas.

## 2. Causa

QuestionsScreen bloqueaba las opciones en cuanto existía una respuesta guardada, y LearningController.answer ignora (correctamente) una segunda respuesta a la misma pregunta.

## 3. Corrección

- En QuestionsScreen se agrega «Responder de nuevo». Se elige otra opción y «Comprobar de nuevo» muestra la retroalimentación de ese intento (correcta o «Sigue aprendiendo» con la respuesta correcta y la explicación).
- El nuevo intento no se guarda: la primera respuesta se conserva, la pregunta cuenta una sola vez y el repaso de CU-07 sigue basándose en la primera respuesta.
- «Cancelar nuevo intento» regresa a la retroalimentación guardada; cambiar de pregunta reinicia el intento.

Archivos, relativos a Sprint 2/psps_academy:

- lib/ui/app.dart (QuestionsScreen)
- test/fix_h01_respuesta_repetida_test.dart (nuevo)

## 4. Pruebas

Ejecutable: psps_academy/test/fix_h01_respuesta_repetida_test.dart.

| ID | Nivel | Resultado esperado | Estado |
| --- | --- | --- | --- |
| H01-01 | Widget | Incorrecta, «Responder de nuevo», correcta y «Comprobar de nuevo»: «¡Respuesta correcta!» y explicación; primera respuesta conservada; 1 respondida; 1 escritura; sigue en repaso. | Aprobada |
| H01-02 | Widget | Correcta y nuevo intento incorrecto: «Sigue aprendiendo» con la respuesta correcta; sin cambios guardados. | Aprobada |
| H01-03 | Widget | Cancelar el intento restaura la retroalimentación; la siguiente pregunta empieza sin intento. | Aprobada |
| H01-04 | Lógica | Responder de nuevo en el controlador no guarda ni cuenta otra vez. | Aprobada |

| Verificación | Resultado y ubicación |
| --- | --- |
| Análisis | Sin incidencias. Sprint 2/Defectos/H-01/analisis.log. |
| Pruebas del defecto | 4 aprobadas de 4. Sprint 2/Defectos/H-01/pruebas.log. |
| Regresión completa | 56 aprobadas. Sprint 2/Defectos/H-01/regresion.log. |

## 5. Verificación (ID 61, Sebastián)

Responder mal una pregunta, tocar «Responder de nuevo», elegir la correcta y «Comprobar de nuevo»: aparece «¡Respuesta correcta!» y el conteo de preguntas respondidas no cambia.

Pendientes: verificación por Sebastián, revisión del pull request por una persona distinta del autor, integración y registro de horas reales. No se modifican firmas, aceptación de la cliente ni estados del PSR.
