# CU-05 - Entrega de construcción y pruebas

Responsable: Sebastián Guerra Hernández. Fecha técnica: 24/10/2026. Rama: `feature/CU-05-modulos`.

## Entregables

- [WP.11 Componentes de software](../../Construccion/CU05/PSPS_Componentes_CU05_WP11_Sprint02_TSP_Ago26.pdf), con [fuente editable](../../Construccion/CU05/PSPS_Componentes_CU05_WP11_Sprint02_TSP_Ago26.md).
- [Diseño de referencia CU-05](../../Diseno/CU05/PSPS_DisenoCU05_Sprint02_TSP_Ago26.pdf), con [fuente editable](../../Diseno/CU05/PSPS_DisenoCU05_Sprint02_TSP_Ago26.md). Revisión independiente pendiente.
- [WP.14 Casos y resultados](PSPS_CasosPrueba_CU05_WP14_Sprint02_TSP_Ago26.pdf), con [fuente editable](PSPS_CasosPrueba_CU05_WP14_Sprint02_TSP_Ago26.md).

## Resultado comprobado

| Verificación | Resultado |
| --- | --- |
| Análisis Flutter | Sin incidencias |
| CU-05 | 12 aprobadas: 2 de lógica/catálogo y 10 de widgets |
| Suite completa | 52 aprobadas, incluidas las 12 anteriores |
| Android | 1 recorrido aprobado en emulador, modo avión y sin red; 6 capturas reales |

La navegación y las pantallas existentes proceden de la aplicación publicada por Francisco (FireBoss12), base `57b8b83`. Esta entrega completa la verificación específica y corrige conteos, catálogo vacío e íconos de la lista. No se atribuye todo el incremento a CU-05 ni se altera el contenido curricular.

## Reproducir

Desde `Sprint 2/psps_academy`:

```powershell
flutter pub get
flutter analyze
flutter test test/module_exploration_test.dart --reporter expanded --concurrency 1
flutter test --reporter expanded --concurrency 1
.\tool\verify_sprint2_android.ps1 -DeviceId <android-de-pruebas> -EvidenceDirectory <carpeta> -Target integration_test/cu05_offline_test.dart
```

La última orden requiere un Android de pruebas desbloqueado y sin red. Registrar `airplane_mode_on=1` y `Active default network: none` antes y después; el script no activa el modo avión por sí mismo. El ejecutor aísla ID, namespace y actividad y conserva la app normal. Las capturas muestran datos de prueba.

## Estado administrativo

Actividad de construcción: ID 38 / T07 / SI.04.02, planeada para 22/10/2026, 2.00 h **estimadas**. La ejecución de esta entrega es del 24/10/2026. No se inventan horas reales ni se modifican el PSR, firmas o aceptación de la cliente.

Pendientes: revisión por otra persona, integración de la rama y registro de horas reales. Los ID 30 y 35 de revisión de diseño no se declaran cerrados. La persistencia se comprobó recreando controlador e interfaz sobre almacenamiento nativo; no se reinició Android ni se forzó cierre de proceso. iOS no se verificó.
