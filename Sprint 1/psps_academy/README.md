# PSPS Academy — Aprende Ingeniería de Software

Demostración del sprint 1, versión **0.1.0+1**, construida en Flutter para estudiar contenidos y practicar sin conexión. El proyecto incluye plataformas Android e iOS y una vista previa web para revisar en computadora.

Incluye cuatro módulos, los diez temas del SRS, veinte preguntas con retroalimentación, diez actividades de ordenamiento, estados de progreso y almacenamiento local. Los contenidos, la agrupación y los diez puntos por actividad son provisionales. El servidor, los logros/desbloqueos y las pruebas iOS están pendientes.

## Ejecutar

Necesitas Flutter 3.47.2 con Dart 3.13.2 o una versión compatible con el proyecto.

```powershell
cd "Sprint 1/psps_academy"
flutter pub get
flutter devices
flutter run -d chrome
```

Para Android, conecta tu teléfono, activa depuración USB y acepta los avisos de autorización e instalación. Usa el identificador mostrado por `flutter devices`:

```powershell
flutter run -d <identificador>
```

Para abrir el proyecto en Visual Studio Code, abre esta carpeta (`Aplicación PSPS Academy`), selecciona el dispositivo y ejecuta la aplicación.

## Construir el APK

```powershell
flutter build apk --debug
```

El resultado está en `build/app/outputs/flutter-apk/app-debug.apk`. El APK no se versiona en el repositorio (pesa unos 170 MB); se genera con el comando anterior.

En esta computadora Java necesitó utilizar los certificados de confianza de Windows. Si una descarga falla por `PKIX` o `certificate_unknown`, utiliza el script local:

```powershell
.\tool\build_android.ps1
```

El script aplica la configuración únicamente durante su ejecución. No omite la validación de certificados ni modifica permanentemente Java.

## Verificar

```powershell
flutter analyze
flutter test
flutter test integration_test/offline_test.dart -d <identificador>
```

La integración usa una clave separada de prueba para no modificar el progreso del estudiante. Las pruebas unitarias y de interfaz emplean almacenamiento simulado; la integración comprueba el almacenamiento nativo real. El estado efectivo de las verificaciones se registra en la documentación del sprint.

## Documentación

- [Manual de usuario](../../Documentacion/PSPS_ManualDeUsuario_TSP_Ago26.pdf)
- [Guía de operación](../../Documentacion/PSPS_GuiaDeOperacion_TSP_Ago26.pdf)
- [Casos ejecutados WP.14](../Pruebas/PSPS_CasosDePruebaEjecutados_WP14.pdf)
- [Reporte WP.15](../Pruebas/PSPS_ReporteDePruebas_WP15.pdf)
- [Reproducir la verificación del 10 de octubre](../Pruebas/REPRODUCIR.md)
- [Guía de instalación y exposición](docs/GUIA_DEMO.md)
- [Alcance, pruebas y pendientes del sprint](docs/SPRINT_1.md)

Las lecciones se editan en `lib/data/catalog.dart`; las reglas de recorrido están en `lib/domain/learning_controller.dart`. Los IDs se mantienen estables para asociar el estado guardado con el contenido.

La versión iOS requiere compilación, firma y pruebas con macOS/Xcode; todavía no está verificada.
