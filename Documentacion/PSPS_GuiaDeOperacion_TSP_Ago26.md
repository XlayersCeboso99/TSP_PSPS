# Guía de operación de PSPS Academy

Esta guía explica cómo preparar, instalar, comprobar y mantener el incremento Android de PSPS Academy. Incluye una ruta de instalación para el estudiante y otra para el equipo que genera el APK desde el repositorio.

Versión de la guía 1.0 · 10 de octubre de 2026
Aplicación 0.1.0+1 · Incremento del Sprint 1
Android verificado: modelo 24049RN28L con Android 16
Revisión del equipo y aceptación de la cliente: pendientes

## Condiciones de operación

| Recurso | Condición |
|---|---|
| Teléfono | Android. El dispositivo verificado utiliza Android 16; no se afirma compatibilidad con todas las versiones. |
| Instalación | APK de depuración generado por el equipo; espacio disponible para el archivo y la instalación. |
| Conectividad | Internet para descargar herramientas, código o dependencias; no se necesita red para usar los contenidos ya instalados. |
| Cuenta del estudiante | No se requiere registro ni inicio de sesión. |
| Datos | Avance y actividades almacenados localmente; puntos derivados de las actividades realizadas. |
| Plataforma iOS | Proyecto incluido, pero compilación, instalación y operación sin verificar. |

## Instalación desde un archivo APK

1. Solicita al equipo el APK correspondiente a PSPS Academy 0.1.0+1. El archivo no está incluido en el repositorio; se genera como se indica en la siguiente página.
2. Copia el APK al teléfono y ábrelo. Si Android lo solicita, permite instalar desde la aplicación que abre el archivo y confirma la instalación. Los nombres de los ajustes dependen del fabricante.
3. Abre PSPS Academy desde la lista de aplicaciones. Comprueba que aparecen Módulos y Mi progreso. Si la app ya estaba instalada, el avance puede conservarse; una instalación nueva comienza sin avance.

El APK es una versión de demostración firmada para desarrollo; no es una publicación de tienda. Si Android rechaza el archivo o señala incompatibilidad, registra el mensaje y pide al equipo un APK compatible.

## Generar e instalar el APK desde el repositorio

Para el equipo técnico: usa Git, Flutter 3.47.2, Dart 3.13.2 y el entorno Android configurado. La compilación necesita acceso a las dependencias. Ejecuta los siguientes comandos en una terminal.

```powershell
git clone https://github.com/XlayersCeboso99/TSP_PSPS.git
cd TSP_PSPS
cd "Sprint 1/psps_academy"
flutter doctor -v
flutter pub get
flutter analyze
flutter test
flutter build apk --debug
```

El archivo generado está en build/app/outputs/flutter-apk/app-debug.apk, dentro de la carpeta de la app. Conserva el resultado del análisis, las pruebas y la compilación junto con la versión y el commit que se distribuirá.

## Instalar por cable USB

1. Activa depuración USB en el teléfono y conecta el cable. Acepta la autorización del equipo y, si el fabricante lo solicita, la instalación vía USB.
2. Ejecuta flutter devices para identificar el teléfono. Localiza adb en platform-tools del Android SDK o inclúyelo en PATH.
3. Instala el APK con adb install -r y abre la app. El parámetro -r solicita reemplazar la instalación conservando los datos.

```powershell
flutter devices
adb -s <ID_ANDROID> install -r build/app/outputs/flutter-apk/app-debug.apk
adb -s <ID_ANDROID> shell am start -n mx.edu.uaz.psps/.MainActivity
```

Sustituye <ID_ANDROID> por el identificador real. Ejecuta cada comando en una sola línea desde la carpeta de la app.

## Problemas de compilación con certificados

Si Java reporta PKIX o certificate_unknown en Windows, el repositorio incluye tool/build_android.ps1, que utiliza temporalmente el almacén de certificados confiables de Windows y restaura GRADLE_OPTS. No desactiva la validación TLS.

```powershell
.\tool\build_android.ps1
```

## Comprobar la operación después de instalar

1. Abre Módulos y entra a Estructuras y algoritmos, Arreglos bidimensionales y Datos en filas y columnas. Comprueba que el contenido y el ejemplo son accesibles.
2. Pulsa Ir a preguntas, selecciona una opción y Comprobar. Verifica que aparece la explicación y se registra una respuesta; una opción incorrecta también cuenta.
3. Responde las dos preguntas del subtema. Verifica Completado. Regresa al tema y realiza la actividad ordenando sus tres pasos.
4. En Mi progreso, anota respuestas, actividades y puntos. Cierra por completo la app y vuelve a abrirla; compara esos valores.
5. Activa temporalmente modo avión y apaga Wi-Fi y datos móviles. Comprueba el acceso a contenidos; registra cualquier error. Restaura los estados de conectividad que había antes de la comprobación.

El recorrido de comprobación modifica el progreso normal del teléfono. Si necesitas una ejecución repetible con datos separados, utiliza las pruebas de integración descritas en Sprint 1/Pruebas/REPRODUCIR.md. No borres el avance del estudiante para preparar una demostración.

## Reglas que deben observarse

| Función | Comportamiento de esta versión |
|---|---|
| Avance | Se deriva de preguntas respondidas; consultar contenidos no lo modifica. |
| Respuestas repetidas | Se conserva la respuesta original; consultarla no duplica el conteo. |
| Actividad | Se completa automáticamente con tres pasos en el orden esperado. |
| Puntos | Diez por actividad completada, una sola vez; regla provisional. |
| Finalización | Las actividades pendientes no impiden completar un tema o módulo. |
| Guardado | Automático y local; sin respaldo o sincronización entre dispositivos. |

## Registro de operación

Registra fecha, versión 0.1.0+1, commit instalado, modelo y versión Android, medio de instalación, conectividad, pasos ejecutados, valores antes y después, resultado y evidencia. Estos registros técnicos no sustituyen la aceptación de la cliente.

## Actualizar y conservar los datos

1. Antes de una actualización, registra el progreso visible, actividades y puntos. Confirma con el equipo que el nuevo APK conserva el identificador mx.edu.uaz.psps, una firma compatible y el formato de datos.
2. Instala la actualización sobre la app existente. Por USB utiliza adb install -r; evita desinstalar o borrar datos como paso rutinario.
3. Abre la app y compara los valores registrados. Si Android rechaza la actualización por firma o versión, conserva la instalación y reporta el mensaje al equipo.

El incremento actual no ofrece exportación, respaldo ni restauración del progreso. Una captura permite documentar los valores, pero no recuperarlos. La migración de datos entre versiones o teléfonos requiere una solución del equipo y no se garantiza en esta entrega.

## Atender incidencias

| Incidencia | Acción operativa |
|---|---|
| Dispositivo no detectado | Revisa cable, depuración USB y autorización; vuelve a ejecutar flutter devices. |
| Instalación rechazada | Acepta la instalación en el teléfono si aparece el aviso. Si continúa, conserva el mensaje y contacta al equipo. |
| Falla al guardar | Reintenta la acción; el cambio fallido no debe considerarse guardado. |
| Falla al recuperar avance | Pulsa Reintentar. Conserva los datos existentes y registra el error antes de cualquier intervención. |
| Incompatibilidad o actualización rechazada | Verifica APK, firma y dispositivo con el equipo; no desinstales automáticamente. |

## Soporte y límites de la entrega

Registra las incidencias en https://github.com/XlayersCeboso99/TSP_PSPS/issues con pasos de reproducción, versión, dispositivo y evidencia. Consulta el Manual de usuario para el recorrido de las pantallas.

WP.14 y WP.15 contienen la verificación Android del 10/10/2026 y los pendientes. Logros e insignias, desbloqueos, iOS, pruebas formales de rendimiento y aceptación de cliente no se declaran completados. Esta guía corresponde al incremento actual y debe revisarse cuando cambien las funciones o el medio de distribución.
