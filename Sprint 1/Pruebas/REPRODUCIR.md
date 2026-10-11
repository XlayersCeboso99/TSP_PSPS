# Reproducir la verificación de PSPS

Fecha de ejecución registrada: 10 de octubre de 2026. App 0.1.0+1, Flutter 3.47.2 y Dart 3.13.2. Dispositivo físico 24049RN28L con Android 16.

El código evaluado es el commit `1bcf2556e221ba4a58d10b3a92ec5d897e91e9c8`. Los commits posteriores de entrega incorporan documentación y evidencia.

## Pruebas de unidad e interfaz

Desde la raíz del repositorio:

```powershell
cd 'Sprint 1/psps_academy'
flutter pub get
flutter analyze
flutter test --reporter expanded --concurrency=1
flutter test integration_test/offline_test.dart -d <ID_ANDROID> --reporter expanded
```

Resultado registrado: 12 pruebas de unidad/interfaz y 1 integración original aprobadas. La integración original usa almacenamiento nativo y recreación de controlador, sin afirmar cierre de proceso.

## Recorrido offline con capturas y cierre completo

Conectar y autorizar el teléfono por USB. Tener instalado Android SDK y localizar `platform-tools/adb`. Guardar los estados originales de modo avión, Wi-Fi y datos móviles antes de modificarlos; restaurarlos al terminar. Para los ejemplos siguientes `adb` debe estar en PATH.

```powershell
adb shell settings get global airplane_mode_on
adb shell settings get global wifi_on
adb shell settings get global mobile_data
adb shell cmd connectivity airplane-mode enable
adb shell svc wifi disable
adb shell svc data disable

$env:PSPS_EVIDENCE_DIR = Join-Path (Get-Location) 'evidence'
flutter drive --keep-app-running --driver=test_driver/evidence_driver.dart --target=integration_test/evidence_test.dart -d <ID_ANDROID>

adb shell pidof mx.edu.uaz.psps
adb shell am force-stop mx.edu.uaz.psps
adb shell pidof mx.edu.uaz.psps

flutter drive --keep-app-running --driver=test_driver/evidence_driver.dart --target=integration_test/evidence_test.dart --dart-define=PSPS_PHASE=verify -d <ID_ANDROID>
```

`--keep-app-running` es necesario en ambas fases: Flutter drive desinstala por defecto al terminar, lo cual borra los datos y hace inválida una comprobación de cierre/reapertura. Se conservó el intento fallido por esa causa en `evidencias/offline_verify.log` y se aprobaron ambas fases finales con la opción correcta.

La primera fase crea datos en `psps.audit.20261010`; la segunda verifica 2 respuestas, 1 actividad y 10 puntos y elimina esa clave de prueba. No escribe en `psps.progress.v1`. Se producen las ocho imágenes E01 a E08. La prueba presupone ambas fases en orden; no ejecutarlas simultáneamente en el mismo teléfono.

## Restaurar teléfono y app normal

En la ejecución registrada los estados previos eran modo avión 0, Wi-Fi 1 y datos 1. Se restauraron con:

```powershell
adb shell cmd connectivity airplane-mode disable
adb shell svc wifi enable
adb shell svc data enable
flutter build apk --debug
adb install -r build/app/outputs/flutter-apk/app-debug.apk
adb shell am start -n mx.edu.uaz.psps/.MainActivity
```

Usar los estados previos reales de cada teléfono. Instalar con `adb install -r` conserva datos; no utilizar desinstalación o borrado de datos como sustituto del cierre de proceso.

Si Java reporta errores de confianza de certificados en esta máquina, `tool/build_android.ps1` usa el almacén confiable de Windows dentro de su proceso, sin desactivar TLS. Para las integraciones registradas se empleó temporalmente:

```powershell
$env:GRADLE_OPTS = '-Djavax.net.ssl.trustStoreType=Windows-ROOT -Djavax.net.ssl.trustStore=NONE'
```

Conservar y restaurar el valor anterior de GRADLE_OPTS al ejecutar manualmente. No es necesario en entornos donde la confianza Java ya funciona.

## Contenido de la entrega

- WP.14 en PDF y Markdown: treinta registros de casos con pasos, expectativa, resultado y evidencia; ocho capturas de Android.
- WP.15 en PDF y Markdown: resumen, método, incidencias de ejecución, hallazgos y pendientes.
- `WP14_resultados.json`: resultados por ID y commit del código.
- `evidencias/`: registros de terminal, capturas e inspecciones.
- `fuentes/`: matriz, SDS y plan de integración de la auditoría proporcionada, conservados sin cambios.
- `SHA256.json`: huellas de los archivos entregados.

Diecinueve casos documentales están aprobados en el alcance descrito, cuatro son parciales y siete no se ejecutaron. No equivalen a diecinueve funciones automatizadas ni a aceptación completa. iOS, logros, rendimiento y validaciones de la cliente mantienen pendientes explícitos en WP.15.
