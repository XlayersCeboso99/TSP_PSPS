# Reporte de pruebas WP.15

PSPS Academy 0.1.0+1 · Verificación del Sprint 1 · 10 de octubre de 2026

Código evaluado: 1bcf2556e221ba4a58d10b3a92ec5d897e91e9c8

El incremento Android pasó las comprobaciones automatizadas de estudio, progreso, actividades y almacenamiento descritas en WP.14. Se recomienda continuar la revisión interna del Sprint 1. La aceptación completa permanece pendiente por diferencias con la auditoría posterior, logros, cobertura iOS y validación de la cliente.

## Resumen de ejecución

| Comprobación | Resultado |

|---|---|

| flutter analyze | Sin incidencias en la ejecución final |

| flutter test | 12 pruebas aprobadas: 7 de lógica y 5 de interfaz |

| Integración original | 1 prueba aprobada con almacenamiento nativo |

| Recorrido offline | 2 fases aprobadas: preparar y verificar tras detener proceso |

| Compilación Android | APK de depuración generado |

| Matriz documental | 19 aprobados, 4 parciales, 7 sin ejecutar; total 30 |

## Base evaluada

Se verificó el incremento Flutter el 10/10/2026 después del cierre del Sprint 1, sin retroceder la fecha de las evidencias. La implementación parte del SRS v0.3; la matriz v1.1, el SDS v0.3 y el Plan de integración v1.1 de la auditoría del 09/10 sirven para identificar cobertura y diferencias. No constituyen aprobación de la cliente.

Los 15 escenarios automatizados únicos finales aprobaron. Los 30 casos documentales de WP.14 contienen 19 aprobados en el alcance descrito, 4 parciales y 7 sin ejecutar. Una función automatizada puede comprobar varios casos.

## Método y evidencia

Se ejecutaron pruebas de lógica con almacenamiento simulado; pruebas de interfaz para navegación, respuestas, estados y pantalla estrecha; integración con almacenamiento nativo y recorrido completo del primer subtema y su actividad en el dispositivo físico 24049RN28L con Android 16.

La prueba offline utilizó modo avión activo con Wi-Fi y datos móviles apagados. Tras completar un subtema y una actividad se ejecutó am force-stop; pidof confirmó ausencia de proceso. La segunda fase conservó la instalación y recuperó exactamente 2/20 respuestas, 1 actividad y 10 puntos.

La clave exclusiva psps.audit.20261010 se eliminó al terminar verify. No se escribieron respuestas en psps.progress.v1. Se restauraron la app normal y los estados previos de conectividad: modo avión 0, Wi-Fi 1 y datos 1.

## Incidencias de ejecución

I-01: Flutter analyze falló con FormatException en una ruta con acentos. Se utilizó Sprint 1/psps_academy; el análisis final aprobó sin incidencias. Se conservan analyze.log y analyze_final.log.

I-02: Android bloqueó input tap por INJECT_EVENTS; se ejecutaron los recorridos con integration_test sin cambiar los ajustes de seguridad.

I-03: la fase verify inicial recuperó 0 respuestas porque flutter drive desinstala al terminar por defecto. Se repitieron ambas fases con --keep-app-running y la persistencia final aprobó. Se conserva offline_verify.log junto con offline_prepare_final.log y offline_verify_final.log. Esta incidencia del harness no se registra como defecto del producto.

## Hallazgos y pendientes

### H-01 Repetición de respuestas

Estado: Parcial

El código conserva la primera respuesta y deshabilita opciones tras comprobar. RP-02 del Plan de integración v1.1 pide actualizar retroalimentación al repetir. La idempotencia del conteo sí pasa. Resolver con el equipo la diferencia entre la implementación del SRS v0.3 y la revisión posterior.

### H-02 Validación de catálogo

Estado: Pendiente

El catálogo es estático y TU-06 no tiene escenario ni validación equivalente. Añadir validación de referencias y mensaje de contenido no disponible antes de aceptar RP-01.

### H-03 Gamificación completa

Estado: Pendiente

Se prueba la recompensa provisional de 10 puntos. No hay catálogo ni obtención de logros o desbloqueos. RF-06, TU-13, TI-05 y la parte de logros de RF-08 quedan pendientes de D-02.

### H-04 Cobertura multiplataforma

Estado: Pendiente

Android 16 fue comprobado. iOS no se compiló ni ejecutó; falta macOS/Xcode y definición de dispositivos en D-03. No se declara cumplimiento completo de RNF-01.

### H-05 Distribución y permisos

Estado: Parcial

Se inspeccionaron manifiestos. La compilación debug contiene INTERNET para herramientas; falta inventario de autoría y licencias y validación del medio final de entrega.

### H-06 Rendimiento y robustez física

Estado: Pendiente

No se midieron las 20 aperturas de TI-07. La falla de guardado es simulada; no se interrumpió físicamente una escritura ni se verificó la sustitución atómica de archivos prevista en el plan.

## Decisión de revisión

Continuar la revisión técnica interna con WP.14. Antes de declarar aceptación completa: resolver H-01 y H-02, cerrar decisiones de gamificación y dispositivos, ejecutar los casos pendientes y obtener validación de la cliente. No se cierran los 15 defectos históricos de MR-07 porque no se verificó su identidad ni equivalencia con esta ejecución.

Revisión del equipo: pendiente. Aprobación de la cliente: pendiente. No se consignan firmas ni fechas de aceptación.

## Archivos de evidencia

evidencias/flutter_test_final.log, analyze_final.log, integration.log, build.log, offline_prepare_final.log, offline_verify_final.log y dispositivo.json. Capturas E01 a E08 en WP.14 y evidencias/. Resultados estructurados por caso en WP14_resultados.json. Instrucciones en REPRODUCIR.md.