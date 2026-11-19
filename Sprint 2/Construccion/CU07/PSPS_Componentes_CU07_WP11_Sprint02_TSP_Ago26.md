# WP.11 - Componentes de software CU-07

Responsable del CU: Francisco Valdez García (FireBoss12). Fecha de esta entrega: 24/10/2026. Base funcional evaluada: commit 5ae7ed4; versión 0.2.0-dev.2+3.

## 1. Alcance y trazabilidad

Evidencia de la tarea T07 / SI.04.02: construir CU-07 después de la revisión del diseño. El diseño fue aportado por el usuario como aprobado; el PDF identifica su estado como Revisado. Este registro no sustituye una revisión independiente del código.

| Elemento | Correspondencia |
| --- | --- |
| RF-10 / CU-07 / CA-10 | Repasar respuestas incorrectas sin alterar progreso, puntos ni logros. |
| Rama exigida | feature/CU-07-repaso; contiene la versión consolidada del Sprint 2 y estos registros. |
| Integración del equipo | feature/sprint02-app hacia develop; pull request #3, pendiente de revisión. |
| Planeación de la imagen | T07: 1.75 h estimadas, fecha planeada 26/10/2026. Tiempo real de trabajo: no registrado. |

## 2. Componentes construidos

| Componente real | Responsabilidad y archivo |
| --- | --- |
| ReviewEntry | Acceso desde módulo o tema con contador. lib/ui/review_screens.dart (parte de app.dart). |
| ReviewListScreen | Filtrar por contexto, abrir pregunta y presentar el estado vacío o un error de carga. lib/ui/review_screens.dart. |
| ReviewQuestionScreen | Seleccionar, comprobar, mostrar explicación, reintentar y confirmar el acierto guardado. lib/ui/review_screens.dart. |
| LearningController | needsReview, pendingReview, reviewAnswerFor y reviewAnswer. Conserva las respuestas originales y publica solo tras guardar. lib/domain/learning_controller.dart. |
| ProgressSnapshot / LocalProgressStore | Estado independiente reviewAnswers, lectura compatible y escritura local. lib/data/progress_store.dart. |

## 3. Pantallas del diseño

M-07A: pendientes del contexto. M-07B: pregunta y opciones; comprobar permanece deshabilitado sin selección. M-07C: error con explicación y reintento. M-07D: acierto confirmado después de guardar; Continuar repaso vuelve a la lista. M-07E: sin pendientes y retorno al tema o módulo. El color se integra al tema visual común de la aplicación.

## 4. Estado, persistencia y manejo de fallos

Una pregunta se ofrece en repaso si su respuesta original fue incorrecta y todavía no tiene un acierto guardado en reviewAnswers. Un error de repaso mantiene el pendiente; un acierto lo elimina solo después de que el almacenamiento confirma la escritura. Salir sin comprobar no guarda una selección.

La clave local permanece psps.progress.v1. El lector admite formatos 1, 2 y 3; el formato actual incorpora gamificación sin perder respuestas, actividades ni repaso. Los logros heredados no reciben fechas históricas inventadas. Las consultas no escriben.

La escritura del repaso conserva puntos, actividades recompensadas, logros, fechas y tema visual. El controlador verifica la consistencia del snapshot, pero no concede ni anuncia premios desde el repaso. Los fallos de lectura o escritura se notifican sin sustituir el estado guardado.

## 5. Evidencia verificable

| Evidencia | Ubicación relativa a Sprint 2 |
| --- | --- |
| Diseño de referencia | Diseno/CU07/PSPS_DisenoCU07_Sprint02_TSP_Ago26.pdf |
| Código de CU-07 | psps_academy/lib/ui/review_screens.dart y psps_academy/lib/domain/learning_controller.dart |
| Pruebas específicas | psps_academy/test/review_test.dart; registros en Pruebas/CU07. |
| Android en modo avión | psps_academy/integration_test/cu07_offline_test.dart; integracion-modo-avion.log y 5 capturas CU07-AV en Pruebas/CU07. |
| Registro de pruebas WP.14 | Pruebas/CU07/PSPS_CasosPrueba_CU07_WP14_Sprint02_TSP_Ago26.pdf |

## 6. Estado de la entrega

Construcción técnica y pruebas ejecutadas. Pendientes administrativos: revisión por una persona distinta del autor, integración del PR y captura de horas reales por el responsable. No se modifican firmas, fechas planeadas ni estados del plan como si ya existiera esa revisión.

Fuente: diseño aportado como aprobado. SHA-256 del PDF: c544e7398642f26feef3fca2ee7cab1a2b73384a2f2d53a2891c3bbf72079c26
