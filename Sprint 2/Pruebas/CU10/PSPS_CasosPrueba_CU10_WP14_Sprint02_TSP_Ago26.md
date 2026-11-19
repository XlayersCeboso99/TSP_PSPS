# WP.14 - Casos de prueba ejecutados CU-10

Responsable: Sebastián Guerra Hernández. Entrega técnica: 24/10/2026. Rama: feature/CU-10-puntos. Base main: 03193f112f30c0d632bf933bbc50fb333f219f42; aplicación Flutter 0.2.0-dev.2+3.

## 1. Resultado y alcance

Se ejecutaron 16 pruebas específicas: 10 de lógica y 6 de widgets. La suite completa terminó con 68 aprobadas, incluidas esas 16; Flutter analyze no reportó incidencias. Además se aprobó TI10-01 en un emulador Android sin red. Esta evidencia de ejecución es nueva; no cambia a ejecutados los casos del Excel de origen ni equivale a un dictamen independiente.

## 2. Casos específicos

Ejecutable: psps_academy/test/points_consultation_test.dart. MemoryStore simula almacenamiento y fallos; DelayedStore controla una escritura pendiente. La numeración CP10 corresponde a esta entrega. TU-S2-030 a TU-S2-034 identifican los casos de referencia del Excel recibido; TU-S2-033, sin historial, se atiende en el contrato y la vista de total.

| ID | Nivel | Resultado comprobado y traza | Estado |
| --- | --- | --- | --- |
| CP10-01 | Lógica | CA-09B / TU-S2-030: ausencia de recompensas produce 0 y no crea un registro. | Aprobada |
| CP10-02 | Catálogo | G-01 P-11: actividades elegibles con identificadores únicos y no vacíos. | Aprobada |
| CP10-03 | Lógica | CA-09B / TU-S2-032: tres lecturas devuelven 30; snapshot y escrituras no cambian. | Aprobada |
| CP10-04 | Lógica | G-01 P-03/P-04: una actividad incompleta no genera puntos ni avance académico. | Aprobada |
| CP10-05 | Lógica | G-01 P-01/P-02 / TU-S2-031: dos actividades distintas suman 20; repetir un ID no suma. | Aprobada |
| CP10-06 | Fallo simulado | G-01 P-07: escritura fallida no confirma premio; reintentar guarda +10 una sola vez. | Aprobada |
| CP10-07 | Concurrencia | G-01 P-02/P-07: escritura pendiente no expone recompensa; rechaza envío duplicado simultáneo. | Aprobada |
| CP10-08 | Lógica | G-01 P-09: respuestas, módulos completados y repaso no otorgan puntos G-01. | Aprobada |
| CP10-09 | Compatibilidad | Persistencia existente: v1/v2 recuperan puntos en memoria, sin escribir ni inventar fechas. | Aprobada |
| CP10-10 | Fallo simulado | Integridad: total guardado inconsistente se rechaza sin sobrescribirlo. | Aprobada |
| CP10-11 | Widget | CA-09B y G-01 P-10: 0 visible, regla de guardado y distinción de calificación académica. | Aprobada |
| CP10-12 | Widget | CA-09B: abrir/cerrar desde Módulos y Mi progreso conserva 20 y todo el estado. | Aprobada |
| CP10-13 | Widget | Carga pendiente: mensaje de recuperación, sin presentar un falso saldo 0. | Aprobada |
| CP10-14 | Widget | TU-S2-034: lectura fallida muestra error, preserva el registro y reintento recupera 20. | Aprobada |
| CP10-15 | Widget | G-01 P-07: el total visible cambia solo después de un guardado exitoso. | Aprobada |
| CP10-16 | Widget | Accesibilidad: total con nombre y valor semánticos; 320 x 640, texto 1.6, sin desborde. | Aprobada |

## 3. Integración Android TI10-01

Ejecutable: integration_test/cu10_offline_test.dart. Entorno: emulador Android 17, sdk_gphone64_x86_64, AVD de solo lectura; modo avión = 1 y ausencia de red predeterminada comprobados antes y después de la ejecución. No se utilizó un teléfono físico.

Se abre Puntos desde la interfaz con estado nativo vacío; se obtienen 0, 10 y 20 puntos al consultar. Las dos actividades se preparan mediante el controlador real y LocalProgressStore; no se simula almacenamiento, pero no se prueba aquí la interacción de ordenar elementos de CU-02. Repetir la primera actividad conserva 10; consultar tres veces conserva 20 y el registro nativo. Progreso académico y logros no cambian por consultar.

Se recrean controlador e interfaz y se recuperan los mismos 20 puntos. Se introduce después un estado incompatible en la clave aislada de prueba: la pantalla informa el error sin mostrar 0 ni sobrescribirlo. Se restaura la copia válida, se reintenta la carga y se comprueban 20 puntos otra vez.

| Captura PNG | Evidencia visible |
| --- | --- |
| CU10-AV01-cero | Estado inicial sin recompensas: 0 pts. |
| CU10-AV02-diez | Primera actividad guardada: 10 pts. |
| CU10-AV03-repeticion-sin-premio | Repetición: se conservan 10 pts. |
| CU10-AV04-veinte | Segunda actividad distinta guardada: 20 pts. |
| CU10-AV05-total-recuperado | Controlador e interfaz recreados: mismos 20 pts. |
| CU10-AV06-error-sin-reinicio | Estado incompatible de prueba: error sin sustituir el total por 0. |

El ejecutor usa el paquete mx.edu.uaz.psps.integration y la clave psps.integration.cu10.offline. La app normal permanece sin cambios según el registro antes/después. Se verifica recuperación recreando la app y el controlador, sin reiniciar Android ni forzar el cierre del proceso.

## 4. Registros de ejecución y reproducción

| Archivo en Pruebas/CU10 | Evidencia |
| --- | --- |
| analisis-cu10.log | Análisis sin incidencias. |
| pruebas-cu10.log / regresion-cu10.log | Cierre satisfactorio de 16 y 68 pruebas, respectivamente. |
| dependencias-cu10.log / resultado-ejecucion.json | Resolución de dependencias, fecha y códigos de salida. |
| integracion-modo-avion.log | Compilación y ejecución real de TI10-01. |
| entorno-modo-avion.log / resultado-integracion.json | Estado de conectividad antes/después, dispositivo y aislamiento del ejecutor. |
| capturas.txt / CU10-AV01 a CU10-AV06 | Inventario y seis capturas generadas por la prueba. |

Desde Sprint 2/psps_academy, ejecutar flutter analyze; flutter test test/points_consultation_test.dart --reporter expanded --concurrency 1; y flutter test --reporter expanded --concurrency 1. Para Android, usar tool/verify_sprint2_android.ps1 -DeviceId <android-de-pruebas> -EvidenceDirectory <carpeta> -Target integration_test/cu10_offline_test.dart. Confirmar modo avión y ausencia de red antes/después.

Límites: errores de escritura y concurrencia se prueban en memoria; el error de lectura Android usa un dato incompatible de prueba. No se verifica iOS ni cierre forzado de proceso. Las fuentes históricas y el diseño todavía requieren revisión independiente; no se fabrican firmas ni horas reales.
