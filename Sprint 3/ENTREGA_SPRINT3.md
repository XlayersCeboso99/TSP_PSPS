# Entrega del Sprint 3 — PSPS Academy 0.3.0+7

Fecha de cierre: 18/11/2026 · Release: [`v0.3.0-sprint03`](https://github.com/XlayersCeboso99/TSP_PSPS/releases/tag/v0.3.0-sprint03)

Este documento es el manifiesto de la entrega: qué se entrega, de qué commit sale cada archivo, cómo se verificó y qué limitaciones quedan. Convención: **Verificado** = comprobado con comando o CI; **Declarado por el equipo** = prueba realizada por el equipo sin registro en el repositorio.

## 1. Aplicación oficial

| Elemento | Valor |
|---|---|
| Ubicación | [`Sprint 3/psps_academy/`](psps_academy/README.md) |
| Versión | `0.3.0+7` (Android `versionCode` 7, iOS `CFBundleVersion` 7) |
| Identificador | `mx.edu.uaz.psps` (Android e iOS, sin cambios desde el Sprint 2) |
| Casos de uso | CU-01 a CU-12 |
| Catálogo | 4 módulos, 10 temas, 10 subtemas, 40 preguntas, 20 actividades opcionales |
| Datos | Sin conexión; `shared_preferences` con las claves `psps.progress.v1`, `psps.notes.v1`, `psps.reminder.v1` (mismas que el Sprint 2) |
| Herramientas | Flutter 3.47.9 / Dart 3.13.7; Android compileSdk/targetSdk 36, minSdk 24; iOS 15.0+ |

**Procedencia.** El código se desarrolló en [PSPS-Academy](https://github.com/XlayersCeboso99/PSPS-Academy) a partir de `TSP_PSPS@119ab3e` y se reintegró con `git subtree` (historial conservado):

- `feature/sprint03-catalog-expansion@904d26b` — catálogo ampliado, CU-01…CU-12, setup Android.
- `fix/ios-preflight@ad2f907` — delegado de notificaciones iOS, `ios/.gitignore`, CI iOS.
- Consolidados sin conflictos en `release/sprint03@e5a0861`.

Integración en TSP_PSPS: PR [#25](https://github.com/XlayersCeboso99/TSP_PSPS/pull/25) (`60abdd4`) y PR [#27](https://github.com/XlayersCeboso99/TSP_PSPS/pull/27) (`feb609d`) en `develop`; `develop → main` por PR #26 y el PR posterior de sincronización.

**Equivalencia con lo probado por el equipo (verificado por hash de árbol Git):** `lib/`, `android/` y `pubspec.lock` de `Sprint 3/psps_academy` son idénticos a los de `PSPS-Academy@904d26b` (`lib/` = `79030e3…`). Respecto a ese commit solo cambian el número de versión, los ajustes iOS, pruebas nuevas, documentación y CI.

## 2. Artefactos

| Archivo | Commit | Firma | SHA-256 |
|---|---|---|---|
| `PSPS_Academy_0.3.0+7_4938b95_android-release.apk` (53 642 944 B) | `4938b95` (copia limpia) | Clave *debug* del equipo, v2. Certificado SHA-256 `c48a4c7d3caa49f133b6b6a32ae2faa8c3c7adfd6c089257a7b0fe51d3c510e2` | `0009cb9fce23d7ab9d55de061648427f8af302d89a70a2e6ebe42b3cbb7afad3` |
| `PSPS_Academy_0.3.0+7_3377db3_ios-unsigned.ipa` (7 472 599 B) | `3377db3` (CI macOS, Xcode 26.6) | **Sin firma**; arm64 | `852addbe11380422c1d107aa010f698b0d7e11497bdda15931156598755a9e9b` |

`3377db3` solo añade el workflow del IPA sobre `4938b95`; el contenido de `Sprint 3/psps_academy/` es idéntico en ambos. `SHA256SUMS.txt`, `build-info_android.txt` y `build-info_ios.txt` del Release registran la salida de `aapt2`, `apksigner`, `PlistBuddy`, `lipo` y `codesign`.

Los APK que publica el CI (`sprint3-android.yml`) se firman con la clave *debug* del runner (otro certificado) y **no** deben instalarse sobre un teléfono con datos: sirven como evidencia de compilación.

## 3. Verificación

| Comprobación | Resultado | Dónde |
|---|---|---|
| `flutter pub get --enforce-lockfile` | Correcto | Local y CI |
| `flutter analyze` | Sin incidencias | Local y CI |
| `flutter test` | **224/224** | Local y CI |
| `tool/verifications` (defectos Sprint 1 + procedencia del formato Sprint 2) | 10/10 | Local y CI |
| Auditoría CU-01…CU-12 frente a Sprint 2 | Sin regresiones | Revisión de código y pruebas de regresión |
| IDs históricos (módulos, temas, subtemas, preguntas, actividades, logros, temas visuales) | 68/68 conservados | `tool/verifications/tsp_sprint2_fixture_origin_test.dart` |
| Compatibilidad de datos guardados por Sprint 2 | Progreso, puntos, logros, tema, notas y recordatorio se leen y reescriben sin pérdida | `test/regression/tsp_sprint2_compat_test.dart` |
| CI Flutter / Android / iOS simulador sobre `4938b95` | Aprobados: [44438228587](https://github.com/XlayersCeboso99/TSP_PSPS/actions/runs/44438228587), [44438228579](https://github.com/XlayersCeboso99/TSP_PSPS/actions/runs/44438228579), [44438228642](https://github.com/XlayersCeboso99/TSP_PSPS/actions/runs/44438228642) | GitHub Actions |
| IPA sin firma sobre `3377db3` | Aprobado: [44440483828](https://github.com/XlayersCeboso99/TSP_PSPS/actions/runs/44440483828) | GitHub Actions |

**Pruebas físicas.**
- Android — *declarado por el equipo*: Galaxy S24 Ultra, Android 17, build `0.2.0 (6)` compilado desde `904d26b` (mismo `lib/`, `android/` y lockfile que esta entrega): persistencia de progreso y notas, conservación de puntos y actividades, actualización 5 → 6, funcionamiento sin conexión y notificaciones locales. El binario `0.3.0+7` **no se instaló** en dispositivo durante el cierre.
- iOS — *declarado por el equipo*: iPhone 14 Pro Max, iOS 26.6.1, ejecución *Release* desde Xcode en MacBook Air con Flutter 3.47.9. El IPA sin firma de esta entrega no se instaló en dispositivo. En CI: compilación de simulador y `integration_test/offline_test.dart` en simulador aprobados.

## 4. Instalación

- **Android:** `adb install -r PSPS_Academy_0.3.0+7_4938b95_android-release.apk`. Para conservar datos de una instalación anterior, su certificado debe coincidir con `c48a4c7d…`; verificarlo antes y **no desinstalar** ([guía](psps_academy/docs/platforms/ANDROID.md) §5). No usar `tool/instalar_android.ps1` (usa `flutter install`) sobre un teléfono con datos.
- **iOS:** el IPA no está firmado; debe firmarse con un Apple ID antes de instalarlo (Sideloadly o AltStore desde Windows; Xcode en Mac), conservando el bundle id `mx.edu.uaz.psps`. Con Apple ID gratuito la firma caduca a los 7 días. Un IPA distribuible (Ad Hoc/TestFlight) requiere Apple Developer Program de pago ([guía](psps_academy/docs/platforms/IOS.md)).
- **Compilar desde el código:** ver el [README raíz](../README.md#compilar-y-probar-sprint-3).

## 5. Estado por plataforma

| Plataforma | Estado |
|---|---|
| Android | **Entregado.** APK *release* ligado a `4938b95` con SHA-256 y certificado registrados. Funcionalidad probada físicamente por el equipo sobre el mismo código (build 6). |
| iOS | **Entregado como IPA sin firma.** Compila para dispositivo y simulador; pruebas en simulador aprobadas. Requiere firma del usuario para instalarse. |
| HarmonyOS NEXT | **Fuera del alcance de esta entrega.** No hay HAP. La preparación técnica (adaptador Dart de recordatorios, overlay ArkTS sin compilar) se conserva sin cambios en la rama `port/harmonyos-next` de PSPS-Academy. Compilarlo requiere Flutter-OH, DevEco Studio y un dispositivo o emulador HarmonyOS NEXT. Los dispositivos Huawei con EMUI/HarmonyOS ≤ 4.2 instalan APK, pero esa compatibilidad no se ha probado. |

## 6. Limitaciones conocidas

- APK firmado con clave *debug* (no apto para tienda); IPA sin firma.
- Sin servidor ni sincronización entre dispositivos; contenido educativo demostrativo.
- Notificaciones de CU-12 en modo inexacto: Android puede retrasarlas unos minutos.
- `Sprint 2/psps_academy/` se conserva como histórico sin cambios: su `pubspec.lock` está desincronizado y `app_settings 6.1.1` impide compilar su APK (corregido en Sprint 3).
- `main` conserva la carpeta histórica `psps_academy/` (CU-08 anterior, PR #9); no forma parte de la aplicación vigente.
