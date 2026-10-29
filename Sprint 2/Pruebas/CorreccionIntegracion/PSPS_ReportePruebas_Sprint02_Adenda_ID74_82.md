# Reporte de pruebas del Sprint 02 · Adenda: correcciones de integración en develop

Responsable: Pablo Valentín Varela Rivera. Entrega técnica: 29/10/2026. Rama: fix/integracion-develop hacia develop. Versión: 0.2.0+5.

## 1. Alcance

IDs 74 y 82 del PSR, T10 / SI.05.05: corregir los defectos de la integración y repetir las pruebas afectadas. Complementa el Reporte de pruebas del Sprint 02, WP.15 v1.1 (29/10/2026, Sebastián Guerra Hernández), que verificó las correcciones en la candidata codex/sprint02-integracion-cierre. Esta adenda lleva esas correcciones a develop y repite las pruebas sobre el código resultante.

## 2. Integración realizada

Se integró codex/sprint02-integracion-cierre (cb71d13) sobre develop (1cf96c9). Conflictos resueltos con la versión de la candidata, que es la integración conciliada y probada en WP.15 v1.1:

- Sprint 2/README.md
- Sprint 2/psps_academy/test/fix_ds101_validar_catalogo_test.dart
- Sprint 2/psps_academy/tool/verify_sprint2_android.ps1

## 3. Defectos de integración corregidos

| ID | Defecto | Corrección | Pruebas repetidas |
| --- | --- | --- | --- |
| REV08-01 | CU-08 sin ruta ni adaptador de producción dentro del proyecto integrado. | ActivitiesScreen abre la página de CU-08; LearningActivityStore usa el LearningController y su ProgressStore. | cu08_shared_store_test.dart |
| REV08-02 | La lista de CU-08 seguía en Pendiente al regresar de una actividad realizada. | La lista vuelve a consultar al regresar y recibe las actualizaciones del motor compartido. | review_cu08_refresh_test.dart |
| D-S2-CU09-01 | Fila «Abrir subtema» desbordada 44 px a 320 x 640 con texto 1.4. | El texto de la fila se ajusta al ancho disponible. | CP09-15 en cu09_search_test.dart |
| INT-01 | develop (PR #18) incluía L-10 «Aprendo del error» y el aviso de logro en el repaso, contrario a MR-09 §3.3 (diez logros) y a RF-10/CA-10 (repaso sin recompensas). | Se adopta el catálogo de la candidata: diez logros, repaso sin recompensas; pruebas de CU-06 adaptadas. | cu06_achievements_test.dart y sprint2_test.dart |

TI-S2-16 y TI-S2-19 fallaron en el APK 0.2.0 código 4 (ID 72) porque ese APK no tenía las correcciones de D-S1-03 y H-01; no son defectos nuevos. Sus correcciones están en develop y se repiten sus pruebas de widgets. INT-01 se registra para que Calidad decida si entra en la densidad de defectos del PSR §9; WP.15 v1.1 reporta 3.

Catálogo conforme a MR-09 en develop: Sí: el catálogo tiene diez logros (L-01 a L-09 y L-11) y el repaso no concede recompensas.

## 4. Pruebas repetidas (29/10/2026)

| Defecto / procedimiento | Archivo | Resultado |
| --- | --- | --- |
| REV08-01 | test/cu08_shared_store_test.dart | Aprobada: 3 pruebas |
| REV08-02 | test/review_cu08_refresh_test.dart | Aprobada: 1 pruebas |
| D-S2-CU09-01 | test/cu09_search_test.dart | Aprobada: 15 pruebas |
| INT-01 (catalogo MR-09) | test/cu06_achievements_test.dart | Aprobada: 13 pruebas |
| TI-S2-19 / H-01 | test/fix_h01_respuesta_repetida_test.dart | Aprobada: 4 pruebas |
| TI-S2-16 / D-S1-03 | test/fix_ds103_iconos_progreso_test.dart | Aprobada: 3 pruebas |

| Conjunto | Resultado | Registro |
| --- | --- | --- |
| Análisis estático | Sin incidencias | Sprint 2/Pruebas/CorreccionIntegracion/analisis.log |
| Suite completa test/ | 140 aprobadas, 0 fallidas | regresion.log |
| Verificación heredada tool/verifications | 5 aprobadas, 0 fallidas | heredados.log |

## 5. Pendientes

- Revisión del pull request hacia develop por una persona distinta del autor.
- Generar el APK desde develop después del merge (IDs 64 y 73) y repetir en Android TI-S2-16 y TI-S2-19 con ese APK (IDs 72 y 76). Hasta entonces, el resultado histórico del APK código 4 se conserva.
- Incorporar esta adenda al WP.15 como versión 1.2 (Calidad, IDs 81 y 87).