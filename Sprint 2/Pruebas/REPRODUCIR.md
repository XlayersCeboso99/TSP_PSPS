# Reproducir la verificación del Sprint 02

Abre una terminal en `Sprint 2/psps_academy`:

```powershell
flutter pub get
flutter analyze
flutter test
```

Para Android, conecta un dispositivo autorizado y utiliza el script de copia aislada:

```powershell
flutter devices
.\tool\verify_sprint2_android.ps1 -DeviceId <identificador> -EvidenceDirectory <carpeta-de-evidencias>
```

El script prepara un proyecto temporal con ID `mx.edu.uaz.psps.integration`. No ejecutes las pruebas de dispositivo sobre la instalación normal: Flutter puede desinstalar su ejecutor al terminar. Las capturas usan datos de prueba y no representan el progreso personal del estudiante.

Para construir la aplicación normal:

```powershell
.\tool\build_android.ps1
```

El resultado es `build/app/outputs/flutter-apk/app-debug.apk`. En Windows, el script usa el almacén de certificados de confianza de Windows durante la compilación. Si OneDrive bloquea archivos generados, compila desde una copia fuera de la carpeta sincronizada.

Resultados registrados el 24/10/2026: 40 pruebas automáticas aprobadas, análisis sin incidencias, prueba integral Android aprobada y 14 capturas. Posteriormente se aprobó CU-07 en modo avión sin red activa; consulta CU07/README.md. iOS no se verificó.
