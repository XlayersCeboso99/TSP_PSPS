# WP.14 - Casos de prueba ejecutados CU-09

Responsable del caso de uso: Pablo Valentín Varela Rivera. Entrega técnica: 25/10/2026. Rama: feature/CU-09-busqueda. Base: main, commit 95187d14224d065d520c4e6dff9498c295836fe4; aplicación Flutter 0.2.0-dev.2+3.

## 1. Resultado y alcance

Se verifica RF-11 / CU-09 / CA-11 con 15 pruebas específicas y una prueba de integración en Android. Resultado: 15 aprobadas de 15 específicas; suite completa 67 aprobadas; análisis Sin incidencias. Fecha de ejecución: 28/10/2026. No se atribuyen horas reales ni aprobación de un par.

## 2. Casos específicos y procedimiento

Ejecutable: psps_academy/test/cu09_search_test.dart. MemoryStore permite contar escrituras. Entre paréntesis, el caso propuesto en el diseño S2-36.

| ID | Nivel | Resultado esperado | Estado |
| --- | --- | --- | --- |
| CP09-01 (TU-09-01) | Lógica | «clase»: CT-08 por título primero y CT-07 por contenido después. | Aprobada |
| CP09-02 (TU-09-02) | Lógica | «CLASE», «Clase», «  clase  » y «cLaSe» dan lo mismo que «clase». | Aprobada |
| CP09-03 (TU-09-03) | Lógica | «interaccion», «interacción» e «INTERACCIÓN» encuentran CT-10; la ñ se conserva. | Aprobada |
| CP09-04 (TU-09-04) | Lógica | Con 0 a 2 caracteres no se busca (A2); con 3 sí. | Aprobada |
| CP09-05 (TU-09-05) | Lógica | «compiladores»: 0 resultados. | Aprobada |
| CP09-06 (TU-09-06) | Lógica / fixture | Textos que solo están en preguntas, opciones, explicaciones o actividades: 0 resultados. | Aprobada |
| CP09-07 | Lógica | Un resultado por subtema; si coincide en título y contenido, solo aparece en títulos. | Aprobada |
| CP09-08 | Lógica | Frases con espacios repetidos o que cambian de renglón coinciden; el fragmento es de una línea. | Aprobada |
| CP09-09 | Lógica | El rango resaltado es la coincidencia y el fragmento es corto. | Aprobada |
| CP09-10 (TW-09-01) | Widget | «clase»: conteo, grupos, ruta Módulo › Tema e insignia; abrir CT-08 no cambia respuestas ni escribe. | Aprobada |
| CP09-11 (TW-09-02) | Widget | A1 con «compiladores»; cambiar la búsqueda muestra resultados; «Explorar módulos» regresa a Inicio. | Aprobada |
| CP09-12 | Widget | Cancelar con la flecha regresa a Inicio sin cambios (A3). | Aprobada |
| CP09-13 | Widget / fixture | Con un resultado se lee «1 resultado» y la insignia refleja el avance; no escribe. | Aprobada |
| CP09-14 | Widget / fixture | Catálogo vacío: mensaje y «Reintentar» (E1), sin escrituras. | Aprobada |
| CP09-15 | Widget | Resultados en 320 x 640 con texto 1.4, sin errores de disposición. | Aprobada |

Las cuatro pruebas CU09 de sprint2_test.dart, de la app integrada, siguen en la suite completa.

## 3. Integración Android TI09-01 (TI-09-01)

Ejecutable: psps_academy/integration_test/cu09_busqueda_offline_test.dart. Entorno: pendiente (se ejecuta con las pruebas de integración). Comprobar modo avión = 1 y ausencia de red predeterminada antes y después de la ejecución.

Se prepara un estado nativo de prueba con una respuesta y una actividad realizada en la clave aislada psps.integration.cu09.offline. El recorrido toca la lupa, escribe «cl» (A2), «clase» (resultados), abre CT-08, regresa, escribe «compiladores» (A1) y vuelve a Inicio con «Explorar módulos». Se compara el texto guardado antes y después: sin cambios. Después se crea otro controlador sobre el almacenamiento nativo y se comprueban respuestas, puntos y logros.

Resultado: pendiente de ejecutar en Android sin red (pruebas de integración, T10). Se usa el paquete aislado mx.edu.uaz.psps.integration; no se usan datos personales del estudiante.

| Captura PNG | Comprobación visible |
| --- | --- |
| CU09-AV01-inicio-lupa | Inicio con la lupa (M-09A). |
| CU09-AV02-texto-corto | «Escribe al menos 3 letras» (M-09B, A2). |
| CU09-AV03-resultados | 2 resultados para «clase», títulos primero (M-09C). |
| CU09-AV04-contenido-abierto | Subtema de CT-08 abierto sin cambiar el avance. |
| CU09-AV05-sin-resultados | Sin resultados y «Explorar módulos» (M-09D, A1). |

## 4. Registros de esta carpeta

| Archivo | Evidencia |
| --- | --- |
| analisis-cu09.log | Análisis de Flutter. |
| pruebas-cu09.log | 15 pruebas específicas. |
| regresion-cu09.log | Suite completa, incluidas las 15 anteriores. |
| entorno-modo-avion.log | Conectividad del dispositivo antes y después. |
| integracion-modo-avion.log | Compilación y ejecución de TI09-01. |
| resultado-integracion.json | Entorno, código de salida y verificaciones de aislamiento y conectividad. |

## 5. Reproducción y límites

Desde Sprint 2/psps_academy, ejecutar flutter analyze y flutter test test/cu09_search_test.dart --reporter expanded --concurrency 1. Para la suite completa, flutter test --reporter expanded --concurrency 1. En un Android de pruebas sin red, usar tool/verify_sprint2_android.ps1 con -DeviceId, -EvidenceDirectory y -Target integration_test/cu09_busqueda_offline_test.dart.

iOS no se verifica. La revisión de código por otro integrante, la integración y la captura de horas permanecen pendientes.

## 6. Defectos encontrados y corregidos

| ID | Defecto | Causa | Corrección | Prueba |
| --- | --- | --- | --- | --- |
| D-S2-CU09-01 | En pantallas angostas con texto ampliado, la fila «Abrir subtema» de cada resultado se desbordaba 44 píxeles a la derecha. | El texto de la fila no se podía ajustar al ancho disponible. | Se hizo flexible el texto en lib/ui/sprint2_screens.dart. | CP09-15: falló el 28/10/2026 y se aprobó después de corregir. |
