# PSPS Academy — Aprende Ingeniería de Software

PSPS Academy es una aplicación educativa móvil, desarrollada con Flutter, para estudiar y practicar Ingeniería de Software **sin conexión a internet**. El estudiante recorre módulos, temas y subtemas, responde preguntas con retroalimentación inmediata, realiza actividades de ordenamiento, repasa sus errores, gana puntos y logros y desbloquea temas visuales. Todo el avance se guarda en el dispositivo.

> **Estado:** versión `0.3.0+7` — aplicación oficial del Sprint 3 dentro del repositorio del curso `TSP_PSPS` (carpeta `Sprint 3/psps_academy/`). Ver [Procedencia](#procedencia).

## Objetivo educativo

Ofrecer a estudiantes de Ingeniería de Software un recorrido breve y autónomo por fundamentos (estructuras y algoritmos, programación orientada a objetos, datos y relaciones, diseño centrado en las personas), con práctica inmediata y seguimiento visible del progreso, incluso sin red. Los contenidos actuales son **demostrativos**.

## Funcionalidades disponibles

| CU | Funcionalidad |
| --- | --- |
| CU-01 | Estudiar subtemas: contenido, ejemplo y preguntas con retroalimentación inmediata. |
| CU-02 | Realizar actividades opcionales de ordenamiento de pasos. |
| CU-03 | Consultar progreso (Sin iniciar / En progreso / Completado, con texto, ícono y color). |
| CU-04 | Completar contenidos: el estado se agrega de subtema a tema y a módulo. |
| CU-05 | Explorar libremente los módulos, temas y subtemas. |
| CU-06 | Consultar logros (10 logros) y elegir temas visuales desbloqueados. |
| CU-07 | Repasar respuestas originalmente incorrectas sin alterar avance ni recompensas. |
| CU-08 | Consultar actividades por módulo y tema (Pendiente / Realizada). |
| CU-09 | Buscar contenidos por palabra clave (títulos y contenido; sin acentos ni mayúsculas). |
| CU-10 | Consultar puntos (10 por cada actividad completada por primera vez). |
| CU-11 | Notas personales por subtema, guardadas solo en el dispositivo. |
| CU-12 | Recordatorio de estudio semanal con notificaciones locales (sin Internet). |

Catálogo actual: 4 módulos, 10 temas, 40 preguntas y 20 actividades (dos por tema). Los 30 identificadores del catálogo anterior se conservan; inventario en [docs/sprint3/CATALOGO_AMPLIADO.md](docs/sprint3/CATALOGO_AMPLIADO.md). Detalle de reglas en [docs/USE_CASES.md](docs/USE_CASES.md).

## Tecnologías

- Flutter (canal estable) y Dart `^3.13.2`; verificado con Flutter 3.47.9 / Dart 3.13.7.
- `shared_preferences` (`SharedPreferencesAsync`) para persistencia local; sin backend ni red.
- Material 3; pruebas con `flutter_test`, `integration_test` y `flutter_driver`; análisis con `flutter_lints`.
- Android: Gradle 9.3.1 (Kotlin DSL), AGP 9.1.0, Kotlin 2.4.0, Java 17.

## Requisitos de desarrollo

- Flutter estable compatible con Dart 3.13 (`flutter --version`).
- Android SDK con licencias aceptadas y JDK 17+ (el de Android Studio sirve).
- Git.
- Opcional: dispositivo Android con depuración USB o un emulador.

Guía completa de instalación de Flutter y del entorno: [docs/SETUP.md](docs/SETUP.md).

## Descargar y ejecutar

```bash
git clone https://github.com/XlayersCeboso99/PSPS-Academy.git
cd PSPS-Academy
flutter pub get
flutter devices                # identifica tu dispositivo
flutter run -d <identificador> # Android
```

APK de depuración (no se versiona):

```bash
flutter build apk --debug
# build/app/outputs/flutter-apk/app-debug.apk
```

En Windows, si Gradle falla por `PKIX`/`certificate_unknown`, usa `.\tool\build_android.ps1` (ver [docs/SETUP.md](docs/SETUP.md)).

En Windows, diagnóstico y ejecución en Android con un solo comando (no necesita `adb` en el `PATH`):

```powershell
powershell -ExecutionPolicy Bypass -File tool\doctor_android.ps1   # añade -Repair para reparar ADB con confirmación
powershell -ExecutionPolicy Bypass -File tool\run_android.ps1      # o -DeviceId <id>
```

Si ves `adb server version (40) doesn't match this client (41)` o `Android null (unsupported)`, otro programa (por ejemplo SuperDisplay) ejecuta un ADB antiguo: ver [docs/SETUP.md](docs/SETUP.md#adb-server-version-40-doesnt-match-this-client-41--android-null-unsupported).

## Pruebas

```bash
flutter analyze
flutter test                                                         # pruebas unitarias y de widgets
flutter test tool/verifications/defects_sprint01_verification_test.dart
```

Las pruebas de integración en dispositivo, sus claves de almacenamiento aisladas y lo que falta verificar se describen en [docs/TESTING.md](docs/TESTING.md).

## Organización de carpetas

```text
lib/
  main.dart            arranque: crea LearningController y PspsApp
  app/                 interfaz (library app.dart + part review_screens / sprint2_screens)
  core/
    models/            modelo del curso (módulos, temas, subtemas, preguntas, prácticas)
    content/           catálogo educativo y validaciones
    persistence/       almacenamiento local del progreso
    learning/          LearningController y gamificación (puntos, logros, temas)
  features/
    activities/        CU-08 consultar actividades
    search/            CU-09 búsqueda de contenidos
test/                  pruebas unitarias y de widgets (+ test/regression/)
integration_test/      pruebas en dispositivo
test_driver/           drivers que exportan capturas
tool/                  scripts Android y verificaciones heredadas
android/ ios/ web/     proyectos de plataforma
docs/                  documentación vigente, auditoría y documentos heredados
```

Detalle y reglas de dependencia: [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md).

## Soporte multiplataforma (estado real)

| Plataforma | Estado |
| --- | --- |
| Android | APK *release* `0.3.0+7` publicado en el Release [`v0.3.0-sprint03`](https://github.com/XlayersCeboso99/TSP_PSPS/releases/tag/v0.3.0-sprint03) con commit, SHA-256 y certificado registrados; CI en `.github/workflows/sprint3-android.yml` (raíz de TSP_PSPS). Probado físicamente por el equipo sobre el mismo código (Galaxy S24 Ultra, build 6); detalle en [ENTREGA_SPRINT3.md](../ENTREGA_SPRINT3.md). Guía: [docs/platforms/ANDROID.md](docs/platforms/ANDROID.md). |
| iOS | Mismo código y catálogo que Android. Compilación para simulador sin firma y prueba de integración en simulador en el CI de macOS (`.github/workflows/sprint3-ios.yml` en la raíz de TSP_PSPS). IPA de dispositivo **sin firma** publicado en el Release `v0.3.0-sprint03` (`.github/workflows/sprint3-ios-ipa.yml`); debe firmarse con un Apple ID para instalarse. Una compilación de simulador **no** equivale a una instalación en iPhone. Guía: [docs/platforms/IOS.md](docs/platforms/IOS.md). |
| HarmonyOS NEXT | Fuera del alcance de esta entrega. La preparación se conserva sin cambios en la rama `port/harmonyos-next` del repositorio PSPS-Academy; no está integrada aquí. |
| Web | Carpeta presente por la plantilla de Flutter; no es objetivo del proyecto. |

## Procedencia

Desarrollada en [`XlayersCeboso99/PSPS-Academy`](https://github.com/XlayersCeboso99/PSPS-Academy) a partir de `TSP_PSPS@119ab3e` (`Sprint 2/psps_academy`) y reintegrada en TSP_PSPS con `git subtree` desde `feature/sprint03-catalog-expansion@904d26b` + `fix/ios-preflight@ad2f907` (consolidados en `release/sprint03@e5a0861`), conservando su historial. Los PDF del curso y las evidencias de los sprints 1 y 2 permanecen en `Sprint 1/` y `Sprint 2/` de este repositorio. Detalles de la migración original: [docs/MIGRATION_REPORT.md](docs/MIGRATION_REPORT.md).

## Limitaciones conocidas

- Contenido educativo demostrativo; se edita en `lib/core/content/catalog.dart`.
- Sin servidor, cuentas ni sincronización entre dispositivos.
- La compilación *release* usa la firma *debug*; no apta para publicación en tienda.
- iOS: el CI compila y prueba en simulador; la instalación en iPhone y el IPA dependen de una Mac y de la cuenta Apple disponible (ver docs/platforms/IOS.md). HarmonyOS NEXT fuera de alcance.
- El catálogo admite módulos/temas vacíos que el SRS (RP-01) prohíbe; decisión pendiente.
- Lista completa: [docs/MIGRATION_REPORT.md](docs/MIGRATION_REPORT.md#pendientes).

## Contribuir

Flujo de ramas, commits y revisión: [CONTRIBUTING.md](CONTRIBUTING.md). Cambios: [CHANGELOG.md](CHANGELOG.md).

## Licencia y atribuciones

Proyecto académico del equipo PSPS (curso TSP). El repositorio de origen no declara una licencia; hasta que el equipo elija una, todos los derechos quedan reservados a sus autores. Los íconos de la plantilla de Flutter y las dependencias (`shared_preferences`, `cupertino_icons`, SDK de Flutter) se distribuyen bajo licencia BSD-3-Clause / MIT de sus autores.
