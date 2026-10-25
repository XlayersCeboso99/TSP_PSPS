# WP.14 - Casos de prueba ejecutados CU-07

Responsable del CU: Francisco Valdez García (FireBoss12). Fecha de esta entrega: 24/10/2026. Base funcional evaluada: commit 5ae7ed4; versión 0.2.0-dev.2+3.

## 1. Alcance y resultado

Evidencia de la tarea T08 / SI.04.03 y SI.04.04: desarrollar y ejecutar pruebas unitarias y de widgets de CU-07; corregir defectos encontrados. La estimación de la imagen es 1.00 h para el 26/10/2026. La ejecución aquí documentada es del 24/10/2026; no se inventan horas reales.

Resultado: 12 pruebas específicas aprobadas (7 de lógica/persistencia simulada y 5 de widgets), más 1 prueba adicional de invariantes de gamificación aprobada. El análisis no reporta incidencias. Se aprobó además 1 recorrido integral en Android físico en modo avión y sin red activa.

## 2. Preparación y criterios

Se probó el código publicado de la versión 0.2.0-dev.2+3, en una copia temporal para evitar bloqueos de OneDrive. Los casos de lógica y widgets usan MemoryStore con fallos de lectura y escritura simulados. La prueba Android usa una instalación separada, ID mx.edu.uaz.psps.integration, y una clave de datos exclusiva.

Cada caso se aprueba únicamente si sus aserciones terminan sin error y Flutter informa éxito. Los IDs CP07 de este reporte vinculan pruebas ejecutables; no sustituyen los IDs TU/TW/TI del diseño.

## 3. Pruebas de lógica y persistencia simulada

| ID | Resultado esperado y comprobado | Estado |
| --- | --- | --- |
| CP07-01 / TU-07-01 | Filtrar errores por módulo o tema; excluir respuestas correctas y preguntas ajenas. | Aprobada |
| CP07-02 / TU-07-02 a 04 | Error mantiene pendiente; acierto elimina; respuesta original, avance, estados, actividades y puntos se conservan. | Aprobada |
| CP07-03 | Recargar el controlador y realizar escrituras normales conserva el estado de repaso. | Aprobada |
| CP07-04 | Migrar un estado versión 1 conserva respuestas y práctica previa. | Aprobada |
| CP07-05 | Fallo de escritura mantiene la pregunta pendiente y el dato anterior; reintento permite guardar. | Aprobada |
| CP07-06 | Dato inválido o lectura fallida se informa y nunca se sobrescribe. | Aprobada |
| CP07-07 | Rechazar preguntas sin respuesta original, correctas e índices inválidos. | Aprobada |

## 4. Pruebas de widgets

| ID | Resultado esperado y comprobado | Estado |
| --- | --- | --- |
| CP07-08 / TW-07-01,02 | Sin selección no se comprueba; error muestra reintento y acierto muestra confirmación y estado vacío. | Aprobada |
| CP07-09 | Fallo de guardado no presenta éxito; permite reintentar desde la pantalla. | Aprobada |
| CP07-10 | Salir con selección sin comprobar no registra un intento. | Aprobada |
| CP07-11 / TW-07-03 | Accesos por tema y módulo muestran correctamente el estado vacío sin escribir. | Aprobada |
| CP07-12 | Un error de recuperación muestra aviso y reintento; no simula una lista vacía. | Aprobada |

## 5. Comprobación adicional de gamificación

CP07-13: la prueba review preserves rewards, dates and selected theme byte for byte verifica que un acierto de repaso conserva el total de puntos, los IDs de actividades recompensadas, los logros y sus fechas, y el tema elegido. Resultado: aprobada; no genera avisos ni logros nuevos.

## 6. Defectos y correcciones verificables

La ejecución específica actual terminó con 0 pruebas fallidas y sin incidencias de análisis. No se presenta un listado ficticio de defectos ni se declara corregido todo el producto. El guardado fallido, la lectura inválida, la salida sin confirmar y los intentos inválidos quedan cubiertos por las aserciones de regresión.

INC-CU07-01: la limpieza automática de Flutter retiró la instalación normal aunque el ID de la app temporal fuera distinto. Corrección: se aíslan también el namespace y el paquete de MainActivity, se etiqueta la app temporal como pruebas y se usa --keep-app-running para impedir desinstalaciones implícitas. El registro final confirma la versión normal presente antes y después; resultado-integracion.json informa app_normal_preservada=true. El primer registro se conserva en incidencias/INC-CU07-01-entorno-previo.log.

## 7. Registros de ejecución

| Registro | Contenido |
| --- | --- |
| analisis-cu07.log | Análisis del proyecto sin incidencias. |
| pruebas-cu07.log | 12 pruebas del archivo test/review_test.dart; All tests passed. |
| invariantes-cu07.log | 1 prueba adicional de test/sprint2_test.dart; All tests passed. |
| resultado-ejecucion.json | Códigos de salida: análisis, CU-07 e invariantes = 0. |

## 8. Integración Android en modo avión

CP07-14 / TI-07-02: se verificó airplane_mode_on=1 y Active default network: none antes y después de la ejecución. El recorrido prueba acceso por módulo, respuesta incorrecta, reintento, acierto guardado, desaparición de pendientes y recuperación desde el almacenamiento nativo con una nueva instancia del controlador.

Se comparan respuestas originales, actividades, estado del módulo, puntos y logros antes y después. Resultado: aprobado. Cinco capturas CU07-AV01 a CU07-AV05 acompañan integracion-modo-avion.log, entorno-modo-avion.log y resultado-integracion.json.

| Captura | Verificación visible |
| --- | --- |
| CU07-AV01 | Lista de pendientes antes del repaso. |
| CU07-AV02 | Respuesta incorrecta y reintento. |
| CU07-AV03 | Acierto confirmado después de guardar. |
| CU07-AV04 | Lista sin pendientes. |
| CU07-AV05 | Estado recuperado tras desmontar y crear un nuevo controlador. |

## 9. Reproducción

Desde psps_academy: flutter analyze; flutter test test/review_test.dart --reporter expanded --concurrency 1. La prueba adicional usa flutter test test/sprint2_test.dart --plain-name "review preserves rewards, dates and selected theme byte for byte".

Con el Android en modo avión, desbloqueado y conectado por USB, ejecutar tool/verify_sprint2_android.ps1 con -DeviceId, -EvidenceDirectory y -Target integration_test/cu07_offline_test.dart. Usar este script para aislar la app del estudiante; no ejecutar el objetivo directamente sobre el ID normal.

## 10. Límites y cierre

La persistencia se verificó mediante recuperación del almacenamiento nativo tras recrear controlador e interfaz, no mediante reinicio del sistema operativo ni una prueba independiente de cierre completo del proceso. Los errores locales se inyectaron en MemoryStore; no se provocó una falla física del disco del teléfono. iOS no se verificó.

Las tareas técnicas T07 y T08 cuentan con código, pruebas y evidencia. La revisión por otra persona, la integración en develop y el registro de horas reales permanecen pendientes; este documento no los acredita.
