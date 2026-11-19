# Android — TSP_PSPS / Sprint 3

Aplicación oficial del Sprint 3: `Sprint 3/psps_academy/`.
Versión de la app: **`0.3.0+7`** (`versionName` `0.3.0`, `versionCode` `7`), mayor
que el `versionCode` 6 instalado en el Galaxy S24 Ultra.
Identificador: `mx.edu.uaz.psps` (sin cambios).
SDK: los que define Flutter 3.47.9 — `compileSdk 36`, `minSdk 24`,
`targetSdk 36`.

## 1. Workflows de GitHub Actions

GitHub solo ejecuta los workflows de `.github/workflows/` en la **raíz** del
repositorio. Los de `Sprint 3/psps_academy/.github/workflows/` quedan como
referencia histórica y no se ejecutan.

| Workflow (raíz) | Qué hace |
| --- | --- |
| `.github/workflows/sprint3-flutter-ci.yml` | `flutter pub get --enforce-lockfile`, `flutter analyze`, `flutter test` y las verificaciones heredadas del Sprint 1. |
| `.github/workflows/sprint3-android.yml` | Las mismas comprobaciones y `flutter build apk --release`; publica el APK, `SHA256SUMS.txt` y `build-info.txt` (SHA del commit, versión de `pubspec.yaml`, `aapt2 dump badging`, `apksigner verify --print-certs`) como artefacto `sprint3-android-apk-<sha-corto>`. |

Ambos se ejecutan con `defaults.run.working-directory: "Sprint 3/psps_academy"`
y filtros `paths` sobre `Sprint 3/psps_academy/**` y el propio workflow. Se
disparan en `push` a `develop`, `main`, `integracion/**`, `release/**`, en
`pull_request` a `develop`/`main`, en etiquetas `v*` y con `workflow_dispatch`.
Flutter queda fijado en 3.47.9.

> **Aviso sobre el APK de CI:** la configuración `release` firma con la clave
> **debug** de Gradle. En GitHub Actions el runner genera su propia clave debug,
> distinta de la de esta máquina. Ese APK sirve para inspección y como
> artefacto, pero **NO** para `adb install -r` sobre un teléfono que ya tenga
> PSPS firmada con otra clave: Android rechaza la actualización.

## 2. Configuración nativa

| Archivo | Cambio | Motivo |
| --- | --- | --- |
| `android/app/src/main/AndroidManifest.xml` | `POST_NOTIFICATIONS` | Android 13+ exige permiso en tiempo de ejecución para mostrar notificaciones. La app lo solicita solo al activar el recordatorio. |
| | `RECEIVE_BOOT_COMPLETED` | Restaurar los avisos programados tras reiniciar el teléfono. |
| | `ScheduledNotificationReceiver` (no exportado) | Recibe la alarma y publica la notificación. |
| | `ScheduledNotificationBootReceiver` (no exportado) con `BOOT_COMPLETED`, `MY_PACKAGE_REPLACED`, `QUICKBOOT_POWERON` | Reprograma tras reinicio o actualización de la app. |
| `android/app/build.gradle.kts` | `isCoreLibraryDesugaringEnabled = true` y `desugar_jdk_libs 2.1.4` | Requisito de `flutter_local_notifications` para APIs de fecha en versiones antiguas de Android. |

No se usa `SCHEDULE_EXACT_ALARM` ni `USE_EXACT_ALARM`: el aviso se programa con
`AndroidScheduleMode.inexactAllowWhileIdle`, por lo que Android puede retrasarlo
unos minutos para ahorrar batería. La pantalla de CU-12 lo indica al usuario.

Canal de notificación: `psps_recordatorio` («Recordatorio de estudio»),
importancia predeterminada. IDs de notificación `1201` (lunes) a `1207`
(domingo); reprogramar un día reemplaza su aviso.

La firma **no** se tocó: `android/app/build.gradle.kts` mantiene
`signingConfig = signingConfigs.getByName("debug")` y el `applicationId`
sigue siendo `mx.edu.uaz.psps`. No se generaron keystores.

## 3. Compilar el APK

Desde la raíz del repositorio:

```powershell
cd "Sprint 3/psps_academy"
flutter pub get --enforce-lockfile
flutter analyze
flutter test
flutter build apk --release
```

Resultado: `Sprint 3/psps_academy/build/app/outputs/flutter-apk/app-release.apk`.

Las compilaciones Gradle pueden tardar varios minutos. Los scripts de
`tool/` (`build_android.ps1`, `run_android.ps1`, `instalar_android.ps1`)
calculan la raíz del proyecto como el directorio padre de `tool/`, así que
siguen funcionando desde la nueva ubicación sin cambios:

```powershell
.\tool\build_android.ps1     # compila un APK debug
.\tool\doctor_android.ps1    # diagnostico de Flutter/Java/SDK/ADB
```

## 4. Verificar versión, firma y SHA-256

Con las build-tools del SDK (en este equipo: `36.0.0`):

```powershell
$apk = "build\app\outputs\flutter-apk\app-release.apk"
$aapt2 = "$env:LOCALAPPDATA\Android\Sdk\build-tools\36.0.0\aapt2.exe"
$apksigner = "$env:LOCALAPPDATA\Android\Sdk\build-tools\36.0.0\apksigner.bat"

& $aapt2 dump badging $apk | Select-String '^package:|sdkVersion'
& $apksigner verify --print-certs -v $apk
certutil -hashfile $apk SHA256
```

En Linux/macOS:

```bash
aapt2 dump badging "$apk" | grep -E '^package:|sdkVersion'
apksigner verify --print-certs -v "$apk"
sha256sum "$apk"
```

Comprobar: `versionCode='7'`, `versionName='0.3.0'`, `compileSdkVersion='36'`,
`minSdkVersion:'24'`, `targetSdkVersion:'36'` y que
`apksigner` verifica con el esquema v2.

## 5. Actualizar el teléfono SIN desinstalar

Actualizar conserva el avance, las notas y los recordatorios del estudiante.
**Nunca** se debe desinstalar ni borrar datos (`adb uninstall`, `pm clear`,
`flutter install` o `flutter run` cuando la firma no coincide).

### 5.1 Verificar la firma instalada ANTES de actualizar

```powershell
adb shell dumpsys package mx.edu.uaz.psps | Select-String 'versionCode|versionName|signatures'
```

o, para comparar el certificado de forma explícita:

```powershell
adb shell pm path mx.edu.uaz.psps
# copiar la ruta devuelta (p. ej. /data/app/.../base.apk)
adb pull /data/app/.../base.apk installed-base.apk
& $apksigner verify --print-certs installed-base.apk
```

El `SHA-256 digest` del certificado de `installed-base.apk` debe ser **idéntico**
al del APK nuevo. Si difiere, Android rechazará la actualización
(`INSTALL_FAILED_UPDATE_INCOMPATIBLE`): no desinstalar; consultar al responsable
del proyecto antes de tocar el teléfono.

### 5.2 Instalar como actualización

```powershell
adb install -r build\app\outputs\flutter-apk\app-release.apk
```

`-r` reinstala conservando los datos. Después comprobar en el teléfono que
siguen el avance, los puntos, los logros, las notas y el recordatorio.

> Las pruebas de `integration_test/` escriben en el almacenamiento de la app:
> ejecutarlas solo en un dispositivo o perfil de pruebas.

## 6. Resultados registrados

| Verificación | Resultado | Fecha |
| --- | --- | --- |
| `flutter pub get --enforce-lockfile` | Correcto con `app_settings 7.0.0`; lock sin cambios | 18/11/2026 |
| `flutter build apk --release` | Compila en 241 s; APK de 53 642 944 bytes (51.2 MB) | 18/11/2026 |
| `aapt2 dump badging` | `mx.edu.uaz.psps`, `versionCode 7`, `versionName 0.3.0`, compileSdk 36, minSdk 24, targetSdk 36 | 18/11/2026 |
| `apksigner verify --print-certs` | Verifica con esquema v2; certificado `CN=Android Debug` | 18/11/2026 |
| SHA-256 del APK | `6608b4f70eaf43c1933fa78eafebb4619cc2353222d08d40a79dabc8285f22e0` | 18/11/2026 |
| SHA-256 del certificado | `c48a4c7d3caa49f133b6b6a32ae2faa8c3c7adfd6c089257a7b0fe51d3c510e2` | 18/11/2026 |
| `flutter test` | Ver detalle en el informe del cierre del Sprint 3 | 18/11/2026 |
| Pruebas en dispositivo | **No ejecutadas** (ver §7) | — |

## 7. Pruebas que requieren teléfono (pendientes)

No se ejecutaron: el dispositivo de pruebas no estaba disponible para `adb`
durante la sesión. Ninguna de estas comprobaciones debe darse por aprobada
hasta registrarla con evidencia.

**Actualización y datos**

- [ ] Instalar con `adb install -r` sobre una instalación del Sprint 2 con avance, puntos, logros y tema: todo se conserva.
- [ ] Con el catálogo ampliado, los logros obtenidos antes (incluido L-05) se conservan con su fecha y los puntos no cambian hasta completar actividades nuevas.
- [ ] Reiniciar el teléfono: avance, notas y recordatorio persisten.

**CU-11**

- [ ] Agregar, editar y eliminar una nota sin conexión; reabrir la app y comprobar la lista «Mis notas».
- [ ] Salir con cambios sin guardar muestra la confirmación.

**CU-12**

- [ ] Android 13+: al activar, aparece la solicitud de permiso del sistema; al negarla, se muestra el aviso y «Abrir ajustes del teléfono» abre los ajustes de notificaciones de PSPS.
- [ ] Programar para dentro de 2–3 minutos: la notificación aparece (puede retrasarse por ahorro de batería).
- [ ] Tocar la notificación abre la app en Inicio, tanto con la app abierta como cerrada.
- [ ] Cambiar días y hora: no quedan avisos duplicados ni días retirados (`adb shell dumpsys alarm | findstr psps` como apoyo).
- [ ] Reiniciar el teléfono: el aviso sigue programado.
- [ ] Desactivar: no vuelve a aparecer.
- [ ] Usar notas y recordatorios no altera progreso, puntos ni logros.

**Integración automatizada** (en dispositivo de pruebas):

```powershell
flutter test integration_test/offline_test.dart -d <id>
```

y el resto de objetivos según [../TESTING.md](../TESTING.md).
