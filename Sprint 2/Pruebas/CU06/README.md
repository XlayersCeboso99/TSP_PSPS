# CU-06 - Entrega de construcción y pruebas

Responsable: Pablo Valentín Varela Rivera. Fecha técnica: 25/10/2026. Rama: `feature/CU-06-logros`.

## Entregables

- [WP.11 Componentes de software](../../Construccion/CU06/PSPS_Componentes_CU06_WP11_Sprint02_TSP_Ago26.pdf), con [fuente editable](../../Construccion/CU06/PSPS_Componentes_CU06_WP11_Sprint02_TSP_Ago26.md).
- [Diseño de referencia CU-06](../../Diseno/CU06/PSPS_DisenoCU06_Sprint02_TSP_Ago26.pdf), con [fuente editable](../../Diseno/CU06/PSPS_DisenoCU06_Sprint02_TSP_Ago26.md). Revisión independiente pendiente.
- [WP.14 Casos y resultados](PSPS_CasosPrueba_CU06_WP14_Sprint02_TSP_Ago26.pdf), con [fuente editable](PSPS_CasosPrueba_CU06_WP14_Sprint02_TSP_Ago26.md).

## Resultado comprobado

| Verificación | Resultado |
| --- | --- |
| Análisis Flutter | Sin incidencias |
| CU-06 | 13 aprobadas de 13 |
| Suite completa | 65 aprobadas |
| Android | pendiente de ejecutar en Android sin red (pruebas de integración, T10) |

La pantalla «Logros», los temas y el formato 3 proceden de la aplicación integrada publicada por Francisco (FireBoss12). Esta entrega completa CU-06 con el catálogo acordado en MR-09: agrega L-10, usa las condiciones y el aviso del catálogo, describe las reglas con datos y agrega sus pruebas. No se altera el contenido curricular.

## Reproducir

Desde `Sprint 2/psps_academy`:

```powershell
flutter pub get
flutter analyze
flutter test test/cu06_achievements_test.dart --reporter expanded --concurrency 1
flutter test --reporter expanded --concurrency 1
.\tool\verify_sprint2_android.ps1 -DeviceId <android-de-pruebas> -EvidenceDirectory <carpeta> -Target integration_test/cu06_logros_offline_test.dart
```

La última orden requiere un Android de pruebas desbloqueado y sin red. Registrar `airplane_mode_on=1` y `Active default network: none` antes y después; el script no activa el modo avión por sí mismo. Las capturas muestran datos de prueba.

## Estado administrativo

Actividad de construcción: IDs 41 y 47 / T07 / SI.04.02, planeada para el 22 y 23/10/2026, 2.00 h **estimadas**. La ejecución de esta entrega es del 25/10/2026. No se inventan horas reales ni se modifican el PSR, firmas o aceptación de la cliente.

Pendientes: revisión por otra persona, integración de la rama y registro de horas reales. El ID 30 de revisión de diseño no se declara cerrado. iOS no se verificó.
