> Antecedente de la rama original CU-06. El catálogo vigente tiene diez logros y no recompensa el repaso. La candidata conciliada y sus resultados están en Sprint 2/Pruebas/Integracion_28Oct. Este antecedente no acredita por sí solo el cierre actual.

# WP.14 - Casos de prueba ejecutados CU-06

Responsable del caso de uso: Pablo Valentín Varela Rivera. Entrega técnica: 25/10/2026. Rama: feature/CU-06-logros. Base: main, commit 4478f4f70beba45d5b4b6db964c116ba14785e5a; aplicación Flutter 0.2.0-dev.2+3.

## 1. Resultado y alcance

Se verifica RF-06 / CU-06 / CA-06, CA-06b y CA-07 con 13 pruebas específicas y una prueba de integración en Android. Resultado: 13 aprobadas de 13 específicas; suite completa 65 aprobadas; análisis Sin incidencias. Fecha de ejecución: 28/10/2026. No se atribuyen horas reales ni aprobación de un par.

## 2. Casos específicos y procedimiento

Ejecutable: psps_academy/test/cu06_achievements_test.dart. MemoryStore permite comparar el dato guardado, contar escrituras y simular fallos. Los IDs CP06 identifican estas pruebas ejecutables.

| ID | Nivel | Resultado esperado | Estado |
| --- | --- | --- | --- |
| CP06-01 | Catálogo | L-01 a L-11 con las condiciones exactas de G-02; logros de módulo ligados a m1 a m4; 10 actividades; 4 temas cuyos desbloqueos usan logros del catálogo. | Aprobada |
| CP06-02 | Widget | A1: «0 de 11», «Aún no tienes logros» y su mensaje; Noche bloqueado sin «Usar»; cero escrituras. | Aprobada |
| CP06-03 | Lógica | L-01 con la primera respuesta, aunque sea incorrecta, con fecha y aviso «¡Logro obtenido: Primer paso!»; L-02 al completar el subtema; responder otra vez no guarda ni cambia la fecha. | Aprobada |
| CP06-04 | Lógica | L-03 con la primera actividad y aviso con Océano; L-04 con la quinta; L-05 con todas; los puntos solo dependen de actividades. | Aprobada |
| CP06-05 | Lógica | L-06 al completar el módulo 1 y desbloqueo de Atardecer; L-07 a L-09 y L-11 con los demás; Noche disponible; 0 puntos. | Aprobada |
| CP06-06 | Lógica | L-10 con el tercer acierto del repaso; un fallo o dos aciertos no bastan; no cambia puntos ni avance; se conserva al recargar sin aviso. | Aprobada |
| CP06-07 | Lógica | Si falla el guardado no se otorga nada; al reintentar se otorga una vez; repetir no avisa (P-07). | Aprobada |
| CP06-08 | Widget | Cada logro muestra nombre, «Condición cumplida: …» y «Obtenido el dd/mm/aaaa» o «Fecha no disponible»; consultar no escribe. | Aprobada |
| CP06-09 | Widget | El aviso aparece una sola vez con el texto del catálogo. | Aprobada |
| CP06-10 | Widget | Tema bloqueado sin «Usar»; Océano queda «En uso», se conserva al recargar y no cambia puntos, logros ni avance (CA-07). | Aprobada |
| CP06-11 | Lógica / compatibilidad | Un estado de la versión anterior sin L-10 se carga sin escribir; L-10 aparece sin fecha y sin aviso. | Aprobada |
| CP06-12 | Lógica / persistencia simulada | Un logro guardado sin su condición se rechaza y no se sobrescribe. | Aprobada |
| CP06-13 | Widget | «Logros» se abre desde «Mi progreso» en 320 x 640 con texto 1.4, sin errores de disposición ni escrituras. | Aprobada |

Además, se ajustó la prueba G02 de sprint2_test.dart: con el catálogo de 11 logros, responder todas las preguntas y realizar todas las actividades otorga todos menos L-10, que solo se obtiene en el repaso (CP06-06).

## 3. Integración Android TI06-01

Ejecutable: psps_academy/integration_test/cu06_logros_offline_test.dart. Entorno: pendiente (se ejecuta con las pruebas de integración). Comprobar modo avión = 1 y ausencia de red predeterminada antes y después de la ejecución.

El recorrido parte de un estado vacío en la clave aislada psps.integration.cu06.offline: abre «Logros» desde «Mi progreso» (A1), realiza la primera actividad desde «Actividades», muestra el aviso, consulta el logro con su condición y fecha, comprueba que Noche no se puede usar, elige Océano y comprueba que volver a consultar no escribe. Después desmonta la interfaz, crea otro controlador sobre el almacenamiento nativo y comprueba puntos, logros, fechas y tema.

Resultado: pendiente de ejecutar en Android sin red (pruebas de integración, T10). Se usa el paquete aislado mx.edu.uaz.psps.integration; no se usan datos personales del estudiante.

| Captura PNG | Comprobación visible |
| --- | --- |
| CU06-AV01-sin-logros | Estado vacío A1 abierto desde «Mi progreso». |
| CU06-AV02-aviso-logro | Actividad realizada y aviso «¡Logro obtenido: Manos a la obra! Desbloqueaste el tema Océano.» |
| CU06-AV03-logro-obtenido | Logro con nombre, condición cumplida y fecha. |
| CU06-AV04-tema-en-uso | Océano «En uso» y Noche bloqueado. |
| CU06-AV05-logros-recuperados | Logros y tema tras recrear controlador e interfaz con almacenamiento nativo. |

## 4. Registros de esta carpeta

| Archivo | Evidencia |
| --- | --- |
| analisis-cu06.log | Análisis de Flutter. |
| pruebas-cu06.log | 13 pruebas específicas. |
| regresion-cu06.log | Suite completa, incluidas las 13 anteriores. |
| entorno-modo-avion.log | Conectividad del dispositivo antes y después. |
| integracion-modo-avion.log | Compilación y ejecución de TI06-01. |
| resultado-integracion.json | Entorno, código de salida y verificaciones de aislamiento y conectividad. |

## 5. Reproducción y límites

Desde Sprint 2/psps_academy, ejecutar flutter analyze y flutter test test/cu06_achievements_test.dart --reporter expanded --concurrency 1. Para la suite completa, flutter test --reporter expanded --concurrency 1. En un Android de pruebas sin red, usar tool/verify_sprint2_android.ps1 con -DeviceId, -EvidenceDirectory y -Target integration_test/cu06_logros_offline_test.dart.

La recuperación nativa se verifica recreando controlador e interfaz, sin reiniciar Android. Los fallos de lectura y escritura se simulan en MemoryStore. iOS no se verifica. La revisión por otro integrante, la integración y la captura de horas permanecen pendientes.
