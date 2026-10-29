# WP.14 - Casos de prueba ejecutados CU-05

Responsable del caso de uso: Sebastián Guerra Hernández. Entrega técnica: 24/10/2026. Rama: feature/CU-05-modulos. Base: main, commit 57b8b8356b2932b52b915612887a366369b069a3; aplicación Flutter 0.2.0-dev.2+3.

## 1. Resultado y alcance

Se verificó RF-01 / CU-05 / CA-01 con 12 pruebas específicas aprobadas y una prueba de integración en Android. La suite completa terminó con 52 pruebas aprobadas, incluidas esas 12; el análisis no reportó incidencias. La ejecución es del 24/10/2026, sin atribuir horas reales ni aprobación de un par.

## 2. Casos específicos y procedimiento

Ejecutable: psps_academy/test/module_exploration_test.dart. Dos casos comprueban catálogo/lógica; diez prueban widgets. MemoryStore permite comparar el dato guardado y contar escrituras. Los IDs CP05 identifican estas pruebas ejecutables; no afirman ejecución de todas las propuestas de WP.14 del equipo ni sustituyen sus identificadores.

| ID | Nivel | Resultado esperado y comprobado | Estado |
| --- | --- | --- | --- |
| CP05-01 | Catálogo / lógica | CT-01 a CT-10 aparecen una sola vez; IDs de módulos y subtemas son únicos y las materias no están vacías. | Aprobada |
| CP05-02 | Lógica / persistencia simulada | Consultar la jerarquía y sus estados conserva respuestas, actividades, repaso, puntos, logros, tema y almacenamiento. | Aprobada |
| CP05-03 | Widget | Inicio muestra cada módulo y su materia o área. | Aprobada |
| CP05-04 | Widget | El último módulo se abre sin completar el primero ni actividades. | Aprobada |
| CP05-05 | Widget | Cada módulo muestra exclusivamente sus temas y subtemas; recorrido por los cuatro módulos. | Aprobada |
| CP05-06 | Widget | Abrir un tema y su contenido no completa preguntas ni cambia puntos. | Aprobada |
| CP05-07 | Widget | Estados completado, en progreso y sin iniciar distinguibles mediante texto e ícono. | Aprobada |
| CP05-08 | Widget | Cambiar libremente de módulo y recrear la app conserva el estado guardado, sin escrituras por navegación. | Aprobada |
| CP05-09 | Widget | Error de carga visible con reintento; no reemplaza datos ni simula éxito. | Aprobada |
| CP05-10 | Widget | Exploración con pantalla de 320 x 640 y texto ampliado 1.4, sin errores de disposición. | Aprobada |
| CP05-11 | Widget / fixture | Conteos derivados y acceso a un quinto módulo de prueba sin error de índice. | Aprobada |
| CP05-12 | Widget / fixture | Catálogo vacío con mensaje explícito y cero módulos inventados. | Aprobada |

## 3. Integración Android TI05-01

Ejecutable: psps_academy/integration_test/cu05_offline_test.dart. Entorno: emulador Android 17, modelo sdk_gphone64_x86_64, AVD de solo lectura. No fue un teléfono físico. Se comprobaron modo avión = 1 y ausencia de red predeterminada antes y después de la ejecución.

Se preparó un estado nativo de prueba con respuestas, una actividad realizada, puntos y logros. El recorrido abrió módulos fuera de orden, consultó temas/subtemas y contenido y volvió al inicio. Se comparó el texto persistido antes y después: sin cambios. Tras desmontar la interfaz y crear otro controlador, se conservaron estados, puntos y logros.

Resultado: aprobado. Se usó el paquete aislado mx.edu.uaz.psps.integration y la clave psps.integration.cu05.offline. El ejecutor de CU-07 se adaptó para conservar la instalación normal; el registro indica el estado de esa instalación antes y después. No se utilizaron datos personales del estudiante.

| Captura PNG | Comprobación visible |
| --- | --- |
| CU05-AV01-modulos | Lista de módulos del catálogo. |
| CU05-AV02-acceso-libre | Apertura del último módulo sin completar los anteriores. |
| CU05-AV03-estructura | Jerarquía de temas y subtemas del primer módulo. |
| CU05-AV04-tema | Índice del tema y acceso al estudio. |
| CU05-AV05-contenido-sin-avance | Entrada a CU-01 sin responder preguntas ni cambiar el avance. |
| CU05-AV06-estado-recuperado | Lista tras recrear controlador e interfaz con almacenamiento nativo. |

## 4. Registros de esta carpeta

| Archivo | Evidencia |
| --- | --- |
| analisis-cu05.log | Análisis de Flutter sin incidencias. |
| pruebas-cu05.log | 12 pruebas específicas; cierre All tests passed. |
| regresion-cu05.log | 52 pruebas de la suite completa; cierre All tests passed. |
| resultado-ejecucion.json | Códigos de salida de dependencias, análisis, CU-05 y regresión. |
| entorno-modo-avion.log | Estado de conectividad del emulador antes y después. |
| integracion-modo-avion.log | Compilación y ejecución TI05-01. |
| resultado-integracion.json | Entorno, código de salida y verificaciones de aislamiento y conectividad. |
| incidencias/INC-CU05-01-configuracion-gradle.log | Primer intento de compilación bloqueado por el almacén de certificados forzado; se corrigió el ejecutor y se repitió la prueba. Es una incidencia del entorno, no un defecto funcional de la app. |

## 5. Reproducción y límites

Desde Sprint 2/psps_academy, ejecutar flutter analyze y flutter test test/module_exploration_test.dart --reporter expanded --concurrency 1. Para la suite completa, flutter test --reporter expanded --concurrency 1.

En un Android de pruebas sin red, usar tool/verify_sprint2_android.ps1 con -DeviceId, -EvidenceDirectory y -Target integration_test/cu05_offline_test.dart. La carpeta README de esta entrega detalla las órdenes.

La recuperación nativa se verificó recreando controlador e interfaz, sin reiniciar Android ni forzar un cierre completo del proceso. Los fallos de lectura se simularon en MemoryStore; no se provocó una falla física del disco. iOS no se verificó. La revisión por otro integrante, la integración y la captura de horas permanecen pendientes.
