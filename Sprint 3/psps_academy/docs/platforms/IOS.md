# iOS — TSP_PSPS / Sprint 3

Aplicación oficial del Sprint 3: `Sprint 3/psps_academy/`.
Versión de la app: **`0.3.0+7`** (`CFBundleShortVersionString` `0.3.0`,
`CFBundleVersion` `7`).
Bundle identifier: `mx.edu.uaz.psps` (sin cambios). Despliegue mínimo: iOS 15.0.
Gestor de dependencias: **Swift Package Manager** (no hay `Podfile`).

El host de desarrollo de Android es Windows y no tiene macOS ni Xcode, así que
en esta sesión **no se compiló iOS**. La revisión es estática y la validación
nativa ocurre en el workflow de macOS.

## 1. Workflows de GitHub Actions

GitHub solo ejecuta los workflows de `.github/workflows/` en la **raíz** del
repositorio. Los de `Sprint 3/psps_academy/.github/workflows/` quedan como
referencia histórica y no se ejecutan.

| Workflow (raíz) | Qué hace |
| --- | --- |
| `.github/workflows/sprint3-flutter-ci.yml` | `pub get --enforce-lockfile`, `analyze`, `test` en Ubuntu. |
| `.github/workflows/sprint3-ios.yml` | En `macos-latest`: `pub get --enforce-lockfile`, `analyze`, `test`, `flutter build ios --simulator --debug` y `integration_test/offline_test.dart` en un simulador iPhone. Publica `sprint3-ios-build-logs` (registros, `Runner-simulator.app.zip`) y `sprint3-ios-simulator-logs` (registros, capturas, diagnósticos). |

Disparadores de `sprint3-ios.yml`: `push` a `develop`, `main`,
`integracion/**`, `release/**`, etiquetas `v*`; `pull_request` a
`develop`/`main`; `workflow_dispatch`; con filtros `paths` sobre
`Sprint 3/psps_academy/**` y el propio workflow. `defaults.run.working-directory`
es `Sprint 3/psps_academy`. Flutter fijado en 3.47.9.

> El artefacto es un **`.app` de simulador sin firma**, no un IPA. No se puede
> instalar en un iPhone físico. El workflow conserva las mitigaciones del
> original: compilación sin firma, *smoke test* de arranque con captura a los
> 60 s, límite de 20 min para la prueba de integración y recolección de
> diagnósticos/crash reports con `if: always()`.

## 2. Revisión técnica de `ios/` (estática)

Comparado con `Sprint 2/psps_academy/ios` (solo lectura) y con la plantilla de
Flutter 3.47.9:

| Archivo | Resultado |
| --- | --- |
| `Runner/AppDelegate.swift` | Plantilla + `UNUserNotificationCenter` y `setPluginRegistrantCallback` para CU-12. `FlutterImplicitEngineDelegate` registra los plugins en `didInitializeImplicitFlutterEngine`. Correcto para el ciclo de vida UIScene. |
| `Runner/SceneDelegate.swift` | `FlutterSceneDelegate` de la plantilla. |
| `Runner/Info.plist` | Plantilla; `CFBundleDisplayName` = `PSPS`. Las notificaciones locales no requieren claves ni `UIBackgroundModes`. |
| `Runner.xcodeproj/project.pbxproj` | `PRODUCT_BUNDLE_IDENTIFIER = mx.edu.uaz.psps`, `IPHONEOS_DEPLOYMENT_TARGET = 15.0`, referencia local `FlutterGeneratedPluginSwiftPackage` y `XCLocalSwiftPackageReference` a `Flutter/ephemeral/Packages/FlutterGeneratedPluginSwiftPackage`. Sin `DEVELOPMENT_TEAM`. |
| `Flutter/Debug.xcconfig` y `Release.xcconfig` | Solo incluyen `Generated.xcconfig`; sin CocoaPods. |
| `Flutter/AppFrameworkInfo.plist` | Plantilla (`io.flutter.flutter.app`, mínimo de la plantilla). |
| `ios/Podfile` | **No existe** (correcto: SwiftPM). |
| `ios/.gitignore` | Presente en Sprint 3; cubre `xcuserdata`, `DerivedData`, `Flutter/ephemeral/`, `Flutter/Flutter.podspec`, `App.framework` y `GeneratedPluginRegistrant.*`. Sprint 2 no lo tenía. |
| `Runner/GeneratedPluginRegistrant.m` | Generado (ignorado por Git); registra `AppSettingsPlugin`, `FlutterLocalNotificationsPlugin`, `FlutterTimezonePlugin`, `IntegrationTestPlugin` y `SharedPreferencesPlugin`. |

Riesgos de registro de plugins y notificaciones:

- El registro de plugins ocurre en `didInitializeImplicitFlutterEngine`; si una
  versión futura de Flutter cambia ese punto de entrada, `GeneratedPluginRegistrant`
  tendría que moverse. Con 3.47.9 es el patrón documentado para UIScene.
- `setPluginRegistrantCallback` es necesario para que las acciones de
  `flutter_local_notifications` en segundo plano encuentren los plugins. La
  prueba de integración del CI sí ejercita el arranque, pero **no** las
  notificaciones programadas: requieren permiso y esperar la hora.
- No hay `Push Notifications` ni clave `aps-environment`: CU-12 usa solo
  notificaciones locales, así que no se necesita esa capacidad.
- `app_settings` 7.0.0 exige iOS 12 y `shared_preferences_foundation` iOS 13;
  ambos son compatibles con el mínimo 15.0.
- En iOS 15+ el permiso se pide solo al activar el recordatorio; el aviso en
  primer plano depende del delegado de `AppDelegate`. No se detectaron claves
  de privacidad (`NSUserNotificationsUsageDescription`) necesarias: iOS no la
  exige para notificaciones locales.

## 3. Verificación en Windows (solo Dart)

Windows 11, Flutter 3.47.9 / Dart 3.13.7, rama `agente/opencode-sprint03`:

| Comando | Resultado |
| --- | --- |
| `flutter pub get --enforce-lockfile` | Correcto (`app_settings 7.0.0`, lock sin cambios) |
| `flutter analyze` / `flutter test` | Se ejecutan en el CI y en el cierre; no requieren Xcode |
| `flutter build ios --simulator` | **No ejecutado**: no hay macOS/Xcode en este host |

No se puede validar localmente el registro nativo de plugins ni la compilación
Swift; eso lo cubre `sprint3-ios.yml` en el runner macOS.

## 4. Requisitos en la Mac

- macOS con Xcode estable reciente y sus *Command Line Tools*
  (`xcode-select -p`); abrir Xcode una vez para aceptar la licencia e instalar
  un *runtime* de iOS Simulator.
- Flutter **3.47.9** estable (`flutter --version`).
- **No** se necesita CocoaPods. Si `flutter config --list` muestra
  `enable-swift-package-manager: false`, reactivarlo con
  `flutter config --enable-swift-package-manager`; desactivarlo haría que
  Flutter genere un `Podfile` y pida CocoaPods.
- Para iPhone físico: un Apple ID (cuenta gratuita sirve para pruebas locales) y
  un cable. Para generar/distribuir un IPA ad-hoc hace falta una cuenta de
  desarrollador de pago (ver §6.3).

## 5. Pasos en la Mac

```bash
git clone https://github.com/XlayersCeboso99/TSP_PSPS.git
cd "TSP_PSPS/Sprint 3/psps_academy"

flutter --version                      # 3.47.9
flutter doctor -v                      # sección Xcode sin errores
flutter pub get --enforce-lockfile
flutter analyze
flutter test

# 1. Compilación sin firma para simulador (igual que el CI)
flutter build ios --simulator --debug

# 2. Simulador: primero ejecutar la app (también calienta el simulador recién creado)
open -a Simulator                      # o: xcrun simctl boot "iPhone 17 Pro"
flutter devices                        # copia el id del simulador
flutter run -d <id-del-simulador>      # q para salir
flutter test integration_test/offline_test.dart -d <id-del-simulador>

# 3. Compilación para dispositivo sin firma (comprueba el SDK iphoneos)
flutter build ios --debug --no-codesign
```

Si `flutter test` se queda sin salida después de `Xcode build done` durante más
de 5 minutos (ocurrió una vez en el CI con un simulador recién creado),
interrúmpelo con Ctrl+C, abre la app una vez con `flutter run` y repite la
prueba.

Para abrir en Xcode: `open ios/Runner.xcworkspace`. Tras la primera compilación,
`git status` no debe mostrar archivos nuevos en `ios/`. Si aparece un
`ios/Podfile`, SwiftPM está desactivado: no confirmarlo en Git.

## 6. Ejecutar en iPhone y generar IPA

### 6.1 iPhone con cuenta gratuita (pruebas locales)

1. Conectar el iPhone por cable y abrir `ios/Runner.xcworkspace`.
2. Destino **Runner** → *Signing & Capabilities* → *Automatically manage
   signing* y elegir el *Team* personal (Apple ID gratuito).
3. Conservar `mx.edu.uaz.psps`. Si otra cuenta ya lo registró, usar un
   identificador temporal **solo en local** y no confirmarlo en Git: cambiarlo
   rompe la continuidad de los datos instalados.
4. No confirmar en Git el `DEVELOPMENT_TEAM` personal.
5. En el iPhone: *Ajustes → Privacidad y seguridad → Modo de desarrollador* y
   confiar en el certificado de desarrollador la primera vez.
6. Ejecutar con Xcode o `flutter run --release -d <id-del-iphone>`.
7. No se necesita la capacidad *Push Notifications*: CU-12 solo usa
   notificaciones locales.

Con una cuenta gratuita la app caduca a los 7 días y hay que reinstalarla; para
un uso continuado durante la evaluación se recomienda una cuenta de pago.

### 6.2 Instalación sin cambiar la firma

La firma no se toca en el repositorio: no hay `DEVELOPMENT_TEAM` confirmado y
el bundle id permanece en `mx.edu.uaz.psps`. Xcode gestiona el perfil en local.

### 6.3 Generar un IPA

```bash
flutter build ipa --release
```

- Requiere un *Team* y un certificado de distribución válidos.
- Para **ad-hoc** (instalar en iPhones registrados) se necesita una cuenta de
  desarrollador de pago y un *provisioning profile* ad-hoc.
- La salida queda en `build/ios/ipa/*.ipa` y los archivos de exportación en
  `build/ios/archive/`.
- Un IPA no se genera en el CI de este repositorio: el workflow solo produce un
  `.app` de simulador sin firma.

## 7. Pendientes que requieren Xcode, simulador o iPhone

- [ ] Compilación para dispositivo (`iphoneos`) y firma con un *Team* real.
- [ ] Crear, editar y eliminar una nota; cerrar y reabrir la app: la nota persiste. Probar el límite de 1 000 caracteres.
- [ ] Activar el recordatorio: aparece la solicitud de permiso del sistema.
- [ ] Denegar el permiso: aparece el aviso y «Abrir ajustes del teléfono» abre los ajustes de notificaciones de PSPS.
- [ ] Conceder el permiso y programar un día/hora próximos: la notificación aparece, también con la app en primer plano.
- [ ] Tocar la notificación con la app en segundo plano y con la app cerrada: se abre en Inicio.
- [ ] Cambiar días y hora: sin duplicados ni días retirados. Desactivar: no vuelve a aparecer.
- [ ] Progreso, puntos, logros y temas visuales no cambian por usar notas o recordatorios.
- [ ] Recorrido visual de CU-01 a CU-10 en iPhone y iPad (orientaciones vertical y horizontal).

Las notificaciones programadas no se pueden probar de forma fiable en el CI:
requieren aceptar el permiso del sistema y esperar la hora.

## 8. Limitaciones conocidas

- `app_settings` 8.x elimina el soporte de CocoaPods; se fijó la 7.0.0, que
  soporta ambos gestores.
- `app_settings` y `flutter_timezone` aplican el plugin de Kotlin en Android
  (aviso de Flutter sobre *Built-in Kotlin*); no afecta a iOS.
- No hay pruebas de integración específicas de CU-11/CU-12 en dispositivo: se
  cubren con pruebas de widgets y con la lista manual de la sección 7.
- La evidencia de CI de macOS recogida en el proyecto original (Xcode 26.6,
  iOS 26.4, ejecuciones del 11/11/2026) corresponde a
  `PSPS-Academy/.github/workflows/ios-build.yml`; el workflow equivalente en
  TSP_PSPS es `.github/workflows/sprint3-ios.yml` y debe validarse en el primer
  *push* de esta rama.
