# CU-10 - Construcción y pruebas

Responsable: Sebastián Guerra Hernández. Entrega técnica: 24/10/2026. Rama: `feature/CU-10-puntos`.

## Entregables

- [WP.11 Componentes](../../Construccion/CU10/PSPS_Componentes_CU10_WP11_Sprint02_TSP_Ago26.pdf) y [fuente editable](../../Construccion/CU10/PSPS_Componentes_CU10_WP11_Sprint02_TSP_Ago26.md).
- [Diseño de referencia](../../Diseno/CU10/PSPS_DisenoCU10_Sprint02_TSP_Ago26.pdf) y [fuente editable](../../Diseno/CU10/PSPS_DisenoCU10_Sprint02_TSP_Ago26.md). Revisión independiente pendiente.
- [WP.14 Casos y resultados](PSPS_CasosPrueba_CU10_WP14_Sprint02_TSP_Ago26.pdf) y [fuente editable](PSPS_CasosPrueba_CU10_WP14_Sprint02_TSP_Ago26.md).

## Resultado comprobado

| Verificación | Resultado |
| --- | --- |
| Flutter analyze | Sin incidencias |
| Específicas | 16 aprobadas: 10 de lógica y 6 de widgets |
| Suite completa | 68 aprobadas, incluidas las 16 anteriores |
| Android | TI10-01 aprobado en emulador, modo avión y sin red; seis capturas |

G-01 se aplica conforme a MR-09, sección 3.2, página 3: +10 por primera actividad válida guardada, por ID único; repetición, intento incompleto y consulta aportan 0. CU-10 solo muestra el total. Se reutilizan pantalla, controlador y persistencia del incremento previo de Francisco; esta entrega ajusta explicación/accesibilidad y completa las pruebas específicas.

## Reproducir

Desde `Sprint 2/psps_academy`:

```powershell
flutter pub get
flutter analyze
flutter test test/points_consultation_test.dart --reporter expanded --concurrency 1
flutter test --reporter expanded --concurrency 1
.\tool\verify_sprint2_android.ps1 -DeviceId <android-de-pruebas> -EvidenceDirectory <carpeta> -Target integration_test/cu10_offline_test.dart
```

La última orden exige un Android de pruebas sin red. Confirmar `airplane_mode_on=1` y `Active default network: none` antes y después; el ejecutor no activa modo avión. Usa un paquete aislado y una clave de prueba; no modifica datos de la app normal.

La prueba Android prepara las actividades mediante el controlador real y almacenamiento nativo; no prueba aquí la interfaz de ordenación de CU-02. Recuperación: recrea controlador e interfaz; no reinicia Android ni fuerza el cierre del proceso. Errores de escritura y concurrencia se verifican con almacenamiento simulado. iOS sin verificar.

## Registro administrativo

ID 39: 22/10/2026, 0.75 h estimadas; ID 46: 23/10/2026, 2.75 h estimadas. Total 3.50 h estimadas para la misma construcción T07 / SI.04.02. Fecha real de esta entrega: 24/10/2026; horas reales pendientes. No se modifican estados del PSR ni firmas. MR-09 acredita acuerdo interno de G-01; no se declaran cerradas la aprobación del SRS ni las revisiones independientes de diseño/código.
