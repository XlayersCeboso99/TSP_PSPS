# Corrección del defecto D-S1-01: El catálogo no se valida antes de usarse

Responsable: Pablo Valentín Varela Rivera. Entrega técnica: 26/10/2026. Pruebas ejecutadas el 26/10/2026. Rama: fix/D-S1-01-validar-catalogo. Base: main, commit 53355a9913e36a06115ffd10997a519b8660701f; aplicación Flutter 0.2.0-dev.2+3.

## 1. Defecto

| Dato | Registro |
| --- | --- |
| ID | D-S1-01 |
| Requisito | RP-01 (SRS v0.1 §2); RF-01; TU-06 |
| Evidencia | WP.15 del Sprint 01, hallazgo H-02 «Validación de catálogo» (pendiente); TU-06 sin ejecutar. |
| Actividad | IDs 33 y 40 del PSR, T07 / SI.04.02 (planeada 21 y 22/10/2026, 3.00 h estimadas para los cinco defectos). Horas reales pendientes de registrar por Pablo. |
| Verifica | Sebastián Guerra Hernández, ID 61 del PSR (27/10/2026). |

Un catálogo con identificadores repetidos, subtemas sin preguntas o respuestas fuera de rango se usaría sin aviso y produciría avance incorrecto.

## 2. Causa

No existía una rutina de validación del contenido; LearningController solo validaba el estado guardado.

## 3. Corrección

- Nuevo validateCatalog() en lib/domain/catalog_validation.dart: identificadores vacíos o repetidos, subtemas sin preguntas, preguntas con menos de dos opciones o con la respuesta correcta fuera de rango y actividades configuradas con menos de dos elementos.
- LearningController.load valida antes de leer el avance. Si hay errores muestra «Contenido no disponible…» con «Reintentar», no usa el catálogo y no lee ni escribe el almacenamiento.
- Decisión para la revisión: las estructuras vacías (catálogo sin módulos, módulo sin temas, tema sin subtemas o sin actividad) no se rechazan porque CU-05 y CU-08 ya las muestran con un estado vacío explícito (CP05-11, CP05-12 y la prueba CU08). RP-01 pide al menos un tema por módulo y un subtema por tema; el equipo debe confirmar este criterio.

Archivos, relativos a Sprint 2/psps_academy:

- lib/domain/catalog_validation.dart (nuevo)
- lib/domain/learning_controller.dart (load)
- test/fix_ds101_validar_catalogo_test.dart (nuevo)

## 4. Pruebas

Ejecutable: psps_academy/test/fix_ds101_validar_catalogo_test.dart.

| ID | Nivel | Resultado esperado | Estado |
| --- | --- | --- | --- |
| DS101-01 | Lógica | El catálogo del producto es válido. | Aprobada |
| DS101-02 | Lógica | Se reportan repetidos, subtema sin preguntas, respuesta fuera de rango, menos de dos opciones, identificador vacío y actividad de un elemento. | Aprobada |
| DS101-03 | Lógica | Con un catálogo inválido: no está listo, mensaje «Contenido no disponible», avance guardado intacto y cero escrituras. | Aprobada |
| DS101-04 | Lógica | Las estructuras vacías siguen cargando (CU-05, CU-08). | Aprobada |
| DS101-05 | Widget | La app muestra el mensaje y «Reintentar»; no aparece Inicio ni se escribe. | Aprobada |

| Verificación | Resultado y ubicación |
| --- | --- |
| Análisis | Sin incidencias. Sprint 2/Defectos/D-S1-01/analisis.log. |
| Pruebas del defecto | 5 aprobadas de 5. Sprint 2/Defectos/D-S1-01/pruebas.log. |
| Regresión completa | 57 aprobadas. Sprint 2/Defectos/D-S1-01/regresion.log. |

## 5. Verificación (ID 61, Sebastián)

Con el catálogo real la app inicia normal; con un catálogo con identificadores repetidos muestra «Contenido no disponible» (prueba DS101-05).

Pendientes: verificación por Sebastián, revisión del pull request por una persona distinta del autor, integración y registro de horas reales. No se modifican firmas, aceptación de la cliente ni estados del PSR.
