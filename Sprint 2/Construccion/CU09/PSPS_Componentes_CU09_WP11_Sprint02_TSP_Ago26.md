# WP.11 - Componentes de software CU-09

Responsable del caso de uso: Pablo Valentín Varela Rivera. Entrega técnica: 25/10/2026. Rama: feature/CU-09-busqueda. Base: COMMIT_BASE; aplicación Flutter 0.2.0-dev.2+3.

## 1. Alcance de la actividad

IDs 48 y 55 del PSR (tarea S2-41 del Plan de iteración), T07 / SI.04.02: construir CU-09 Buscar contenidos por palabra clave, con búsqueda local en módulos, temas, subtemas y contenido. RF-11 / CA-11: al escribir una palabra del catálogo se muestran los contenidos que coinciden y se puede abrir uno; buscar y abrir no modifica progreso ni recompensas y funciona sin conexión.

| Dato | Registro |
| --- | --- |
| Fecha planeada y estimación | 23/10/2026 (2.25 h) y 26/10/2026 (2.75 h): 5.00 h estimadas. No son horas reales. |
| Ejecución documentada | 25/10/2026. Horas reales pendientes de registrar por Pablo. |
| Diseño de referencia | Diseno/CU09/PSPS_DisenoCU09_Sprint02_TSP_Ago26.pdf y borrador S2-36. Revisión independiente pendiente; este registro no acredita el ID 30. |
| Revisión de código | Francisco Valdez García, IDs 60 y 68 del PSR. Pendiente. |
| Referencia de formato | Entrega de CU-05 de Sebastián Guerra Hernández en feature/CU-05-modulos. |

## 2. Componentes y código

Los archivos de esta tabla son relativos a Sprint 2/psps_academy. La lupa, la pantalla de búsqueda y ContentSearch ya estaban en la aplicación integrada publicada por Francisco. Se reutiliza esa base y se completa la entrega específica de CU-09; no se atribuye toda la aplicación a este trabajo.

| Componente | Responsabilidad y archivo real |
| --- | --- |
| ContentSearch (C02) | Normaliza, busca en los campos permitidos, arma un resultado por subtema con su fragmento y ordena títulos antes que contenido. lib/domain/content_search.dart. |
| SearchResult / MatchField | Datos de cada resultado: módulo, tema, subtema, grupo, fragmento y posición resaltada. lib/domain/content_search.dart. |
| SearchScreen (C01) | Estados A2, resultados, A1 y E1; abre LessonScreen. lib/ui/sprint2_screens.dart. |
| HomeScreen | Lupa «Buscar contenidos» en la barra superior. lib/ui/app.dart. |
| LearningController (C04) | Solo lectura de lessonStatus para la insignia. lib/domain/learning_controller.dart (sin cambios). |

## 3. Cambios de esta entrega

- La búsqueda acepta frases con espacios repetidos y frases que en el ejemplo cambian de renglón; el fragmento se muestra en una sola línea.
- El mínimo de 3 caracteres queda en una constante (ContentSearch.minLength) y la pantalla usa la misma regla que la búsqueda (canSearch).
- Con un solo resultado se muestra «1 resultado» en lugar de «1 resultados».
- Se agregan claves estables (cu09.short, cu09.empty, cu09.error y cu09.result.ID) para verificar los estados reales.
- Se agregan pruebas específicas (test/cu09_search_test.dart), el objetivo de integración integration_test/cu09_busqueda_offline_test.dart y su opción en tool/verify_sprint2_android.ps1.
- No cambia el formato guardado ni el catálogo; no se tocan C06 ni C07.

## 4. Verificación y estado

| Verificación | Resultado y ubicación |
| --- | --- |
| Análisis | RESULTADO_ANALISIS. Pruebas/CU09/analisis-cu09.log. |
| Casos específicos | RESULTADO_CU09 de 15 (CP09-01 a CP09-15). Pruebas/CU09/pruebas-cu09.log. |
| Regresión completa | RESULTADO_REGRESION. Pruebas/CU09/regresion-cu09.log. |
| Android sin red | RESULTADO_TI09 (TI09-01, 5 capturas). Pruebas/CU09/resultado-integracion.json. |

Construcción preparada para revisión del equipo. Pendientes: revisión de código por una persona distinta del autor, decisión sobre integración de la rama y registro de horas reales. No se modifican firmas, aceptación de la cliente ni estados del PSR.
