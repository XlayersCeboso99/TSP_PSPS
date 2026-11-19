# Corrección del defecto D-S1-02: Elementos de la actividad siempre en orden inverso

Responsable: Pablo Valentín Varela Rivera. Entrega técnica: 26/10/2026. Pruebas ejecutadas el 26/10/2026. Rama: fix/D-S1-02-orden-actividad. Base: main, commit 53355a9913e36a06115ffd10997a519b8660701f; aplicación Flutter 0.2.0-dev.2+3.

## 1. Defecto

| Dato | Registro |
| --- | --- |
| ID | D-S1-02 |
| Requisito | CA-03; CU-02 |
| Evidencia | Revisión del código del Sprint 01 (registro de corrección de defectos del 22/10). |
| Actividad | IDs 33 y 40 del PSR, T07 / SI.04.02 (planeada 21 y 22/10/2026, 3.00 h estimadas para los cinco defectos). Horas reales pendientes de registrar por Pablo. |
| Verifica | Sebastián Guerra Hernández, ID 61 del PSR (27/10/2026). |

Los elementos disponibles de cada actividad aparecían siempre en orden inverso, así que se resolvía tocándolos de abajo hacia arriba sin pensar.

## 2. Causa

PracticeScreen recorría los pasos con List.generate(...).reversed.

## 3. Corrección

- Nuevo Practice.presentationOrder en lib/domain/course.dart: mezcla estable a partir del identificador de la actividad (la misma cada vez que se abre) que nunca coincide con el orden correcto y, con 3 o más elementos, tampoco con el inverso.
- PracticeScreen presenta los elementos con ese orden. El guardado, la validación y los puntos no cambian.

Archivos, relativos a Sprint 2/psps_academy:

- lib/domain/course.dart (Practice)
- lib/ui/app.dart (PracticeScreen)
- test/fix_ds102_orden_actividad_test.dart (nuevo)

## 4. Pruebas

Ejecutable: psps_academy/test/fix_ds102_orden_actividad_test.dart.

| ID | Nivel | Resultado esperado | Estado |
| --- | --- | --- | --- |
| DS102-01 | Lógica | Cada actividad del catálogo: permutación completa, distinta del orden correcto y del inverso, y estable. | Aprobada |
| DS102-02 | Lógica | 0, 1 y 2 elementos; 800 identificadores de prueba con 3 a 7 elementos. | Aprobada |
| DS102-03 | Widget | La pantalla muestra los elementos en el orden de presentación. | Aprobada |
| DS102-04 | Widget | Elegir el orden correcto sigue completando la actividad. | Aprobada |

| Verificación | Resultado y ubicación |
| --- | --- |
| Análisis | Sin incidencias. Sprint 2/Defectos/D-S1-02/analisis.log. |
| Pruebas del defecto | 4 aprobadas de 4. Sprint 2/Defectos/D-S1-02/pruebas.log. |
| Regresión completa | 56 aprobadas. Sprint 2/Defectos/D-S1-02/regresion.log. |

## 5. Verificación (ID 61, Sebastián)

Abrir varias actividades: los elementos no aparecen en el orden correcto ni en el inverso; al reabrir una actividad el orden es el mismo.

Pendientes: verificación por Sebastián, revisión del pull request por una persona distinta del autor, integración y registro de horas reales. No se modifican firmas, aceptación de la cliente ni estados del PSR.
