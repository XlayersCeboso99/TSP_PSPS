# Verificación de CU-07 y revisión local de CU-08 y CU-09

Proyecto: PSPS Academy · Sprint 02  
Fecha de trabajo: 27/10/2026  
Responsable de la tarea: Francisco Valdez García  
Código examinado: rama local `feature/sprint02-app`, revisión `c51ad9db287d7402d4e62877a26242af4b261980`.

## Resultado

Se ejecutaron 13 pruebas específicas de CU-07, incluidas 12 existentes y una nueva prueba de invariantes de recompensas. Todas aprobaron. La regresión completa de `test/` aprobó sus 41 pruebas; este total incluye las 13 anteriores, no se suma a ellas. Flutter analyze terminó sin incidencias.

| Comprobación | Resultado | Evidencia |
| --- | --- | --- |
| CU-07 unitarias y widgets | 13 aprobadas | pruebas_cu07.log |
| Regresión completa de test/ | 41 aprobadas | regresion_sprint02.log |
| Análisis estático | Sin incidencias | analisis_estatico.log |

## Cobertura de CU-07

- Preguntas incorrectas filtradas por tema y módulo.
- Respuesta incorrecta permanece pendiente; el acierto retira la pregunta del repaso.
- Persistencia tras reconstruir el controlador y migración de datos anteriores.
- Fallos de lectura y escritura sin sobrescribir datos ni confirmar un guardado inexistente.
- Opciones inválidas y preguntas que no requieren repaso rechazadas.
- Selección, retroalimentación, reintento, salida y estado sin pendientes en widgets.
- Conservación de respuestas originales, actividades, puntos, logros, fecha de obtención, temas disponibles y tema seleccionado durante el repaso.

La prueba adicional `review_rewards_regression_test.dart` prepara una actividad válida y el tema Océano, ejecuta un error y un acierto de repaso y vuelve a cargar el estado. Comprueba que no cambian las recompensas ni se emiten nuevos premios. Se entrega como archivo independiente; todavía no se incorporó al repositorio original.

## Revisión local de CU-08 y CU-09

Se inspeccionaron `lib/ui/sprint2_screens.dart`, `lib/domain/content_search.dart`, sus llamadas al controlador y las pruebas de `test/sprint2_test.dart`.

| Caso | Aspectos revisados | Resultado del alcance local |
| --- | --- | --- |
| CU-08 Actividades | Agrupación por módulo y tema, distinción realizada/pendiente, apertura sin completar la actividad, estado sin actividad y tratamiento de carga fallida. | No se identificaron hallazgos bloqueantes en el código examinado. Las pruebas de consulta sin escritura y navegación aprobaron. |
| CU-09 Búsqueda | Mínimo de tres caracteres, normalización de mayúsculas y vocales acentuadas conservando ñ, campos permitidos, exclusión de preguntas/respuestas, prioridad de títulos, resultado único por subtema y apertura sin alterar avance. | No se identificaron hallazgos bloqueantes en el código examinado. Las pruebas de búsqueda, resultados vacíos y navegación aprobaron. |

Esta es una revisión local del código combinado. No se identificaron números o enlaces de PR de CU-08/CU-09; no se emitió aprobación en GitHub ni se realizó merge. `origin/develop` es una referencia local sin actualización de red, por lo que no acredita el estado actual del remoto.

## Entorno y reproducibilidad

Se usó Flutter mediante el SDK instalado y Dart 3.13.2, en una copia de trabajo. El `pubspec.lock` coincidió con el entorno de dependencias existente; no se actualizaron paquetes. Las órdenes exactas y los códigos de salida están en `ejecuciones.json`. El manifiesto incluye las rutas relativas y SHA-256 de los 29 archivos fuente utilizados. Se verificó al cierre que los originales seguían iguales.

El intento inicial se detuvo por falta de acceso al archivo de bloqueo del SDK. Tras habilitar la ejecución, los controles finalizaron correctamente. Las pruebas no requieren modificar el proyecto original.

## Pendientes que este registro no cierra

- No se ejecutó una prueba nueva en Android físico ni una sesión nueva en modo avión. Las comprobaciones de recarga del controlador y los widgets no sustituyen cerrar y reabrir el proceso Android.
- Falta incorporar la prueba adicional a la rama correspondiente, identificar los PR de CU-08/CU-09 y registrar su revisión formal antes de integrar.
- No se declara completada la incorporación de CU-07 a `develop`.
- Las horas humanas reales del 27/10 y el Daily deben registrarse con los datos efectivos; la duración automática de las pruebas no se convierte en horas de trabajo.

## Archivos del paquete

`pruebas_cu07.log`, `regresion_sprint02.log`, `analisis_estatico.log`, `ejecuciones.json`, `fuentes_verificadas.json` y `review_rewards_regression_test.dart`.
