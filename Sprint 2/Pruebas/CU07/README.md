# CU-07 - Entrega de construcción y pruebas

**Fecha de ejecución:** 24/10/2026. **Versión:** 0.2.0-dev.2+3.

Esta carpeta reúne la evidencia de las dos actividades de la imagen compartida: **T07 / SI.04.02, Componentes (WP.11)** y **T08 / SI.04.03-SI.04.04, Casos de prueba (WP.14)**. Sus estimaciones en la imagen son 1.75 h y 1.00 h; no se confunden con horas reales trabajadas. Las estimaciones históricas del BackLog no se modifican.

## Entregables

- [WP.11 - Componentes de software](../../Construccion/CU07/PSPS_Componentes_CU07_WP11_Sprint02_TSP_Ago26.pdf), con [fuente editable](../../Construccion/CU07/PSPS_Componentes_CU07_WP11_Sprint02_TSP_Ago26.md).
- [WP.14 - Casos de prueba ejecutados](PSPS_CasosPrueba_CU07_WP14_Sprint02_TSP_Ago26.pdf), con [fuente editable](PSPS_CasosPrueba_CU07_WP14_Sprint02_TSP_Ago26.md).
- [Diseño aportado como aprobado](../../Diseno/CU07/PSPS_DisenoCU07_Sprint02_TSP_Ago26.pdf).

## Resultados comprobados

| Verificación | Resultado | Registro |
| --- | --- | --- |
| Análisis del código | Sin incidencias | analisis-cu07.log |
| Pruebas específicas CU-07 | 12 aprobadas: 7 de lógica y 5 de widgets | pruebas-cu07.log |
| Puntos, logros, fechas y tema | 1 prueba adicional aprobada | invariantes-cu07.log |
| Android sin red, en modo avión | Recorrido integral aprobado | integracion-modo-avion.log |
| Condición de conectividad | airplane_mode_on=1; sin red predeterminada, antes y después | entorno-modo-avion.log |
| Aislamiento de la instalación normal | Presente antes y después de la ejecución final | resultado-integracion.json |

Las capturas CU07-AV01 a CU07-AV05 muestran pendientes, error, acierto guardado, estado vacío y recuperación del estado nativo. Son datos de prueba; no corresponden al avance personal del estudiante.

El código probado está en `psps_academy/lib/ui/review_screens.dart` y `lib/domain/learning_controller.dart`. Los ejecutables de prueba están en `test/review_test.dart`, `test/sprint2_test.dart` e `integration_test/cu07_offline_test.dart`, relativos a esa carpeta Flutter.

## Reproducir

Desde `Sprint 2/psps_academy`:

```powershell
flutter analyze
flutter test test/review_test.dart --reporter expanded --concurrency 1
flutter test test/sprint2_test.dart --plain-name "review preserves rewards, dates and selected theme byte for byte"
.\tool\verify_sprint2_android.ps1 -DeviceId <id> -EvidenceDirectory <carpeta> -Target integration_test/cu07_offline_test.dart
```

Para la última orden, activa modo avión, comprueba que no haya red, mantén el teléfono desbloqueado y no cambies de app durante el recorrido. El script crea una copia separada, cambia ID, namespace y actividad, y conserva el ejecutor al finalizar para evitar la limpieza automática de Flutter. La instalación de pruebas se identifica como **PSPS Academy (pruebas)**.

## Límites y estado

Las tareas de construcción y pruebas cuentan con entregables técnicos. El PR de integración #3, la revisión por un compañero y el registro de horas reales permanecen pendientes. La recuperación se verificó recreando controlador e interfaz sobre el almacenamiento nativo, sin reiniciar el sistema operativo ni simular una falla física del disco. iOS no se verificó.

La incidencia INC-CU07-01 de aislamiento y su corrección constan en WP.14. No se declara cerrado todo el sprint ni se completan firmas o revisiones por otra persona.
