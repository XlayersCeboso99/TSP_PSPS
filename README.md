# PSPS Academy — Aplicación móvil de Ingeniería de Software

Proyecto del equipo **PSPS** para la materia Team Software Process (Universidad Autónoma de Zacatecas, Ingeniería de Software), desarrollado conforme a ISO/IEC 29110-5-1-1:2025, Perfil de Entrada.

**Equipo:** Francisco Valdez García (gestor del proyecto y Scrum Master), Sebastián Guerra Hernández (calidad), Pablo Valentín Varela Rivera (función técnica) y Marco Antonio de Jesús Oliva Santos (colaboración y repositorio).
**Cliente:** M. L. SIGG.

PSPS Academy es una aplicación Flutter/Dart para Android e iOS que permite estudiar contenidos de Ingeniería de Software organizados en módulos, temas y subtemas, responder preguntas con retroalimentación, realizar actividades interactivas y consultar el avance. Funciona sin conexión y guarda el progreso en el dispositivo.

## Estado actual

- **Aplicación oficial vigente: [`Sprint 3/psps_academy/`](Sprint%203/psps_academy/README.md), versión `0.3.0+7`.** Incluye CU-01 a CU-12 (CU-11 notas personales, CU-12 recordatorios locales) y el catálogo ampliado: 4 módulos, 10 temas, 10 subtemas, 40 preguntas y 20 actividades opcionales. Funciona sin conexión y guarda el progreso, puntos, logros, notas y recordatorio en el dispositivo.
- Procedencia: integrada desde [`XlayersCeboso99/PSPS-Academy`](https://github.com/XlayersCeboso99/PSPS-Academy) (`feature/sprint03-catalog-expansion@904d26b` + `fix/ios-preflight@ad2f907`) con `git subtree`, conservando su historial. Los identificadores y claves de almacenamiento del Sprint 2 se conservan (los datos guardados por versiones anteriores siguen siendo válidos).
- **Descargas:** Release [`v0.3.0-sprint03`](https://github.com/XlayersCeboso99/TSP_PSPS/releases/tag/v0.3.0-sprint03) con el APK de Android y el IPA de iOS **sin firma** (debe firmarse con un Apple ID para instalarse), más `SHA256SUMS.txt`.
- Manifiesto de la entrega (commits, SHA-256, pruebas, estado por plataforma y limitaciones): [`Sprint 3/ENTREGA_SPRINT3.md`](Sprint%203/ENTREGA_SPRINT3.md). Guías por plataforma: [`Sprint 3/psps_academy/docs/platforms/`](Sprint%203/psps_academy/docs/platforms).
- Versiones anteriores (históricas, no se modifican): Sprint 2 `0.2.0` en [`Sprint 2/psps_academy/`](Sprint%202/psps_academy/README.md) y Sprint 1 en `Sprint 1/psps_academy/`.
- HarmonyOS NEXT queda fuera del alcance de esta entrega; su preparación se conserva en la rama `port/harmonyos-next` de PSPS-Academy.

## Estructura del repositorio

```
Sprint 1/                     Incremento y documentación del Sprint 1 (histórico)
Sprint 2/                     Incremento 0.2.0, documentación, pruebas y evidencias del Sprint 2 (histórico)
Sprint 3/
├── 03 Requisitos y Diseño/   Trazabilidad y documentos del Sprint 3 (ID 32)
├── ENTREGA_SPRINT3.md        Manifiesto de la entrega 0.3.0+7
└── psps_academy/             APLICACIÓN OFICIAL ACTUAL (Flutter, Android e iOS)
    ├── lib/                  app/, core/ (catálogo, almacenamiento), features/ (CU-01…CU-12)
    ├── test/                 Pruebas unitarias, de widgets, Sprint 3 y regresión/migración
    ├── integration_test/     Pruebas de integración en dispositivo/simulador
    ├── android/  ios/        Proyectos nativos (applicationId / bundle id mx.edu.uaz.psps)
    ├── tool/                 Scripts de diagnóstico, compilación e instalación
    └── docs/                 Arquitectura, casos de uso, pruebas y guías por plataforma
.github/workflows/            CI: sprint3-flutter-ci, sprint3-android, sprint3-ios, sprint3-ios-ipa (Sprint 3) y cu12-validation (Sprint 2)
docs/                         Documentación general del proyecto
```

## Compilar y probar (Sprint 3)

Requisitos: Flutter 3.47.9 (Dart 3.13.7). Desde `Sprint 3/psps_academy`:

```bash
flutter pub get --enforce-lockfile   # dependencias exactas del pubspec.lock
flutter analyze
flutter test                         # suite completa
flutter build apk --release          # Android: build/app/outputs/flutter-apk/app-release.apk
flutter build ios --simulator --debug  # iOS (solo en macOS con Xcode)
```

Guías detalladas: [Android](Sprint%203/psps_academy/docs/platforms/ANDROID.md) (incluye cómo verificar firma, versión y SHA-256 e instalar **como actualización** sin perder datos) e [iOS](Sprint%203/psps_academy/docs/platforms/IOS.md) (simulador, iPhone con Xcode e IPA). Los workflows de `.github/workflows/sprint3-*.yml` repiten estas comprobaciones en cada cambio y publican el APK, la compilación de simulador y el IPA sin firma como artefactos con su SHA-256.

Para las versiones anteriores consulta [Sprint 2/psps_academy/README.md](Sprint%202/psps_academy/README.md) y [Sprint 2/Pruebas/REPRODUCIR.md](Sprint%202/Pruebas/REPRODUCIR.md).

## Gestión del trabajo

El Product Backlog, los Sprint Backlogs y los defectos se gestionan en **GitHub Issues** con la etiqueta `backlog`, los hitos `Sprint 01`, `Sprint 02` y `Sprint 03`, y las etiquetas de estado `pendiente`, `en-progreso`, `en-revision` y `terminado` (Project Plan §6).

Ramas: `main` (versiones liberadas), `develop` (integración) y `feature/<issue>-<descripción>` (Plan de integración v1.1).

Los binarios (APK/IPA) no se versionan en Git: se publican como artefactos de GitHub Actions y en los GitHub Releases, acompañados de su SHA-256.
