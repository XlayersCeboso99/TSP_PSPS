# WP.11 - Componentes de software CU-06

Responsable del caso de uso: Pablo Valentín Varela Rivera. Entrega técnica: 25/10/2026. Rama: feature/CU-06-logros. Base: COMMIT_BASE; aplicación Flutter 0.2.0-dev.2+3.

## 1. Alcance de la actividad

IDs 41 y 47 del PSR (tarea S2-40 del Plan de iteración), T07 / SI.04.02: construir CU-06 Consultar los logros obtenidos e integrar los logros y desbloqueos acordados (G-02, G-03) en el componente C06. RF-06 / CA-06: consultar los logros obtenidos con su nombre, la condición cumplida y la fecha, sin modificar puntos ni avance.

| Dato | Registro |
| --- | --- |
| Fecha planeada y estimación | 22/10/2026 (1.50 h) y 23/10/2026 (0.50 h): 2.00 h estimadas. No son horas reales. |
| Ejecución documentada | 25/10/2026. Horas reales pendientes de registrar por Pablo. |
| Diseño de referencia | Diseno/CU06/PSPS_DisenoCU06_Sprint02_TSP_Ago26.pdf y SDS v0.2, sección 9. Revisión independiente pendiente; este registro no acredita el ID 30. |
| Catálogo | G-02 y G-03 (S2-37) y G-01 (S2-24), acordados por el equipo en MR-09 (D-02). |
| Referencia de formato | Entrega de CU-05 de Sebastián Guerra Hernández en feature/CU-05-modulos. |

## 2. Componentes y código

Los archivos de esta tabla son relativos a Sprint 2/psps_academy. La pantalla «Logros», los temas de color y el guardado en formato 3 ya estaban en la aplicación integrada publicada por Francisco. Se reutiliza esa base y se completa la entrega específica de CU-06; no se atribuye toda la aplicación a este trabajo.

| Componente | Responsabilidad y archivo real |
| --- | --- |
| Gamification (C06) | Catálogo de 11 logros y 4 temas; reglas por tipo, umbral y módulo; hechos del avance (ProgressFacts); texto del aviso. lib/domain/gamification.dart. |
| LearningController | Evalúa los logros solo al guardar respuestas, actividades y repaso; conserva fechas; acepta datos guardados antes de L-10. lib/domain/learning_controller.dart. |
| AchievementsScreen | Conteo, logros con «Condición cumplida» y fecha, estado vacío A1, próximos logros y temas «En uso», «Disponible» o «Bloqueado». lib/ui/sprint2_screens.dart. |
| reportSave | Aviso único con el texto del catálogo después de guardar. lib/ui/app.dart. |
| ReviewQuestionScreen | Muestra el aviso de L-10 al guardar un acierto del repaso. lib/ui/review_screens.dart. |
| ProgressStore | Formato 3 sin cambios: logros con fecha o nulo, repaso y tema. lib/data/progress_store.dart. |

## 3. Cambios de esta entrega

- Se agrega L-10 «Aprendo del error» (3 preguntas respondidas mal y acertadas en el repaso), con lo que el catálogo queda en 11 logros como lo acordó el equipo. Antes el código y CU07_REPASO.md lo excluían.
- Las condiciones que ve el estudiante usan el texto exacto del catálogo G-02 y se muestran como «Condición cumplida: …».
- Los logros y temas se describen con datos (regla, umbral, módulo y logros que desbloquean cada tema) en lugar de IDs fijos dentro del código, como pide el SDS 9.2 (R-06).
- El aviso usa el texto del catálogo: «¡Logro obtenido: …!» y «Desbloqueaste el tema …», y aparece también en el repaso.
- El estado vacío muestra el mensaje A1 del caso de uso; el tema elegido se identifica como «En uso».
- Un estado guardado por la versión anterior (sin L-10) se carga sin error: si ya cumple L-10, se reconoce sin fecha y sin aviso. Un logro guardado sin su condición sigue rechazándose sin sobrescribir.
- Se agregan claves estables (cu06.empty, cu06.achievement.ID y cu06.theme.ID), pruebas específicas (test/cu06_achievements_test.dart), el objetivo de integración integration_test/cu06_logros_offline_test.dart y su opción en tool/verify_sprint2_android.ps1.
- Se ajustan la prueba G02 de sprint2_test.dart y los documentos README.md, DISENO_SPRINT2.md y CU07_REPASO.md para reflejar L-10.

## 4. Verificación y estado

| Verificación | Resultado y ubicación |
| --- | --- |
| Análisis | RESULTADO_ANALISIS. Pruebas/CU06/analisis-cu06.log. |
| Casos específicos | RESULTADO_CU06 de 13 (CP06-01 a CP06-13). Pruebas/CU06/pruebas-cu06.log. |
| Regresión completa | RESULTADO_REGRESION. Pruebas/CU06/regresion-cu06.log. |
| Android sin red | RESULTADO_TI06 (TI06-01, 5 capturas). Pruebas/CU06/resultado-integracion.json. |

Construcción preparada para revisión del equipo. Pendientes: revisión por una persona distinta del autor, decisión sobre integración de la rama y registro de horas reales. No se modifican firmas, aceptación de la cliente ni estados del PSR.
