# Calidad Sprint 02: tareas 54, 61 y 62

Sebastián Guerra Hernández. Ejecución real: **25/10/2026**. Rama: `codex/sprint02-pruebas-calidad`.

| Tarea | Planeación | Resultado de esta entrega |
| --- | --- | --- |
| 54 / T08 / SI.04.03-SI.04.04 | 26/10; 2.00 h estimadas | 43 pruebas específicas aprobadas: 26 unitarias y 17 de widgets. Se corrige el catálogo ambiguo de CU-05. |
| 61 / T08 / SI.04.04 | 27/10; 1.50 h estimadas | Verificación parcial: dos comprobaciones aprueban y tres fallan. Faltan IDs y criterios de dos originales; los cuatro D-S1 son provisionales. |
| 62 / T10 / SI.05.02 | 27/10; 1.25 h estimadas | 22 casos de integración preparados en WP.14; entorno Android disponible. Integración no ejecutada en esta revisión. |

Las fechas planeadas se conservan. Las horas reales y los estados del PSR quedan a cargo de Sebastián. La ejecución no sustituye revisión independiente ni aprobación de requisitos.

## Versión ensayada y antecedentes

La candidata reúne `main` 4478f4f y CU-10 c28a51a en el antecedente df315f5, con el parche de catálogo y los tests de esta entrega. `fuentes-y-resultados.json` registra commits revisados, hashes SHA-256 de archivos Dart y resultados por ID. Las ramas CU-06/CU-07/CU-08/CU-09 se revisaron como antecedentes separados; sus cambios no se consideran integrados ni probados por los resultados de esta candidata.

- CU-06 6ccb343 agrega L-10 y recompensa desde el repaso; contradice los diez logros de MR-09. Requiere conciliación antes de integrar.
- CU-08 348d837 publica un paquete en `psps_academy/` de raíz. Su README reconoce pendientes el adaptador a C07 y la navegación de `Sprint 2/psps_academy`.
- CU-09 95187d1 conserva `RESULTADO_*` en su README. Se requieren registros reales y revisión de la rama antes de integrar.
- `fix` 28e1374 contiene informes; no se localizaron en esa rama los cambios Dart ni `defects_sprint01_test.dart` citados en el informe H-01.

## Tarea 54: pruebas y corrección

`test/wp14_cu05_cu10_test.dart` ejecuta TU-S2-001 a TU-S2-005, TU-S2-030 a TU-S2-034 y TG-S2-006/TG-S2-007 del WP.14. Se conservan los 28 tests CP05/CP10 publicados y se añaden tres de integridad de catálogo.

TU-S2-005 falló antes del arreglo: el mismo tema/subtema podía aparecer bajo dos módulos con identidades repetidas. `lib/data/catalog_validation.dart` valida IDs por tipo y opciones/índice de preguntas antes de cargar progreso. Un catálogo inválido muestra error y conserva lo guardado. Se mantienen el catálogo vacío y los temas sin actividades opcionales admitidos por la aplicación.

La fixture de la especificación original usaba referencias a padres; el modelo de producción contiene hijos embebidos. Su equivalente ejecutado usa IDs compartidos bajo dos padres. Este ajuste se explica en WP.14 y no se presenta como una prueba de claves foráneas inexistentes.

Resultados: `tarea54-resultados.jsonl` contiene **43** pruebas aprobadas; `regresion.log` contiene **83**, incluidas las anteriores. WP.14 acredita 17 especificaciones base mediante estas pruebas; algunas comparten evidencia y no se suman como ejecuciones adicionales.

## Tarea 61: verificación heredada

| Referencia | Resultado comprobado |
| --- | --- |
| H-01 | Falla: no existe el botón documentado Responder de nuevo. |
| D-S1-01 provisional | Aprueba identidad/preguntas en el alcance ensayado; falta completar criterios y cotejar ID original. |
| D-S1-02 provisional | Falla: la presentación sigue el orden inverso. |
| D-S1-03 provisional | Falla: un tema parcial usa círculo en Mi progreso. |
| D-S1-04 provisional | Aprueba el acceso al quinto módulo sin RangeError; correspondencia original pendiente. |
| Dos originales por verificar | Sin ID/criterio disponible; no se sustituyen con hallazgos nuevos. |

La comprobación se ejecuta expresamente desde `tool/verifications/defects_sprint01_verification_test.dart` y produce salida 1 con tres fallos. Es una verificación separada de la suite normal de 83 tests; ambos resultados se conservan. El registro para Drive queda parcial y no cierra los defectos originales de MR-07.

Pablo tiene las correcciones en los ID 33 y 40 del PSR, actividad S2-39 del plan. Sebastián verifica en ID 61 / S2-31. Se necesitan los IDs originales y commits de corrección de Pablo para completar el cotejo.

## Tarea 62: preparación de integración

El Excel WP.14 incluye la hoja Integracion S2: 22 casos con datos, pasos, resultado esperado, ejecutable o recorrido manual y condición previa. Cubre CU-05 a CU-10, G-01/G-02/G-03, persistencia, errores, compatibilidad y regresión CU-01 a CU-04. La hoja Entorno y antecedentes identifica los commits y las restricciones de cada candidato.

Se resolvieron dependencias y se comprobó Flutter 3.47.7, Dart 3.13.5, toolchain Android SDK 36.0.0, plataforma android-37.0 y JDK 25.0.3. El análisis quedó sin incidencias. La advertencia de Visual Studio corresponde a Windows desktop, fuera de la prueba Android prevista.

Antes de ejecutar SI.05: revisar SRS/SDS y MR-09, conciliar CU-06, conectar CU-08, revisar CU-09 y elegir un único commit integrado. Identificar Android de pruebas, registrar modo avión y ausencia de red antes/después, aislar paquete y claves y conservar la app normal. La ejecución posterior debe producir sus propios resultados; los registros Android del 24/10 son antecedentes históricos.

## Reproducir

Desde `Sprint 2/psps_academy`, con Flutter en PATH:

```powershell
flutter pub get
flutter analyze
flutter test test/module_exploration_test.dart test/points_consultation_test.dart test/wp14_cu05_cu10_test.dart test/catalog_integrity_test.dart --reporter json --concurrency 1
flutter test --reporter expanded --concurrency 1
flutter test tool/verifications/defects_sprint01_verification_test.dart --reporter json --concurrency 1
flutter doctor -v
```

La tercera orden de pruebas debe mantener visibles los tres fallos heredados hasta que se corrijan; un código de salida 1 no se registra como aprobación.

Para la ejecución Android posterior, el ejecutor disponible es `tool/verify_sprint2_android.ps1`, objetivo `integration_test/sprint2_design_test.dart`, o los objetivos específicos de CU-05/CU-10. CU-07 debe incorporarse desde su rama; los objetivos nuevos de CU-06/CU-09 requieren sus cambios y revisión coherentes.

## Archivos para Drive

El usuario sube `PSPS_CasosDePrueba_Sprint02_TSP_Ago26.xlsx` a `Sprint 2/05 Pruebas y Calidad/Casos de prueba/` y `PSPS_RegistroDefectos_Sprint02_TSP_Ago26.xlsx` a `Sprint 2/05 Pruebas y Calidad/Registro de defectos/`. Los Excel se entregan por separado y no se escriben en Drive desde esta tarea.
