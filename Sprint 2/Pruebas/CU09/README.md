# CU-09 - Entrega de construcción y pruebas

Responsable: Pablo Valentín Varela Rivera. Fecha técnica: 25/10/2026. Rama: `feature/CU-09-busqueda`.

## Entregables

- [WP.11 Componentes de software](../../Construccion/CU09/PSPS_Componentes_CU09_WP11_Sprint02_TSP_Ago26.pdf), con [fuente editable](../../Construccion/CU09/PSPS_Componentes_CU09_WP11_Sprint02_TSP_Ago26.md).
- [Diseño de referencia CU-09](../../Diseno/CU09/PSPS_DisenoCU09_Sprint02_TSP_Ago26.pdf), con [fuente editable](../../Diseno/CU09/PSPS_DisenoCU09_Sprint02_TSP_Ago26.md). Revisión independiente pendiente.
- [WP.14 Casos y resultados](PSPS_CasosPrueba_CU09_WP14_Sprint02_TSP_Ago26.pdf), con [fuente editable](PSPS_CasosPrueba_CU09_WP14_Sprint02_TSP_Ago26.md).

## Resultado comprobado

| Verificación | Resultado |
| --- | --- |
| Análisis Flutter | RESULTADO_ANALISIS |
| CU-09 | RESULTADO_CU09 de 15 |
| Suite completa | RESULTADO_REGRESION |
| Android | RESULTADO_TI09 |

La lupa, la pantalla de búsqueda y ContentSearch proceden de la aplicación integrada publicada por Francisco (FireBoss12). Esta entrega completa CU-09 según su especificación y el diseño S2-36: frases con espacios o saltos de línea, regla única de 3 caracteres, singular en el conteo, claves de prueba, 15 pruebas específicas y la prueba en Android sin red. No se altera el contenido curricular ni el formato guardado.

## Reproducir

Desde `Sprint 2/psps_academy`:

```powershell
flutter pub get
flutter analyze
flutter test test/cu09_search_test.dart --reporter expanded --concurrency 1
flutter test --reporter expanded --concurrency 1
.\tool\verify_sprint2_android.ps1 -DeviceId <android-de-pruebas> -EvidenceDirectory <carpeta> -Target integration_test/cu09_busqueda_offline_test.dart
```

La última orden requiere un Android de pruebas desbloqueado y sin red. Registrar `airplane_mode_on=1` y `Active default network: none` antes y después; el script no activa el modo avión por sí mismo.

## Estado administrativo

Actividad de construcción: IDs 48 y 55 / T07 / SI.04.02, planeada para el 23 y 26/10/2026, 5.00 h **estimadas**. La ejecución de esta entrega es del 25/10/2026. No se inventan horas reales ni se modifican el PSR, firmas o aceptación de la cliente.

Pendientes: revisión de código (Francisco, IDs 60 y 68), integración de la rama y registro de horas reales. iOS no se verificó.
