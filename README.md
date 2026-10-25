# PSPS Academy — Aplicación móvil de Ingeniería de Software

Proyecto del equipo **PSPS** para la materia Team Software Process (Universidad Autónoma de Zacatecas, Ingeniería de Software), desarrollado conforme a ISO/IEC 29110-5-1-1:2025, Perfil de Entrada.

**Equipo:** Francisco Valdez García (gestor del proyecto y Scrum Master), Sebastián Guerra Hernández (calidad), Pablo Valentín Varela Rivera (función técnica) y Marco Antonio de Jesús Oliva Santos (colaboración y repositorio).
**Cliente:** M. L. SIGG.

PSPS Academy es una aplicación Flutter/Dart para Android e iOS que permite estudiar contenidos de Ingeniería de Software organizados en módulos, temas y subtemas, responder preguntas con retroalimentación, realizar actividades interactivas y consultar el avance. Funciona sin conexión y guarda el progreso en el dispositivo.

## Estado actual

- Versión de desarrollo actual: **0.2.0-dev.2+3**, en [Sprint 2](Sprint%202/README.md). El incremento anterior se conserva en Sprint 1.
- Android verificado en un dispositivo físico con Android 16. iOS sin compilar ni probar (falta macOS/Xcode).
- El incremento del Sprint 2 incorpora logros, temas visuales, repaso, búsqueda, actividades y puntos según el diseño del equipo. No hay servidor ni sincronización.
- La aprobación del SRS y la aceptación de la cliente están pendientes.

## Estructura del repositorio

```
Sprint 1/
├── psps_academy/   Código fuente Flutter, pruebas y scripts
│   ├── lib/                  Aplicación (data, domain, ui)
│   ├── test/                 Pruebas unitarias y de interfaz
│   ├── integration_test/     Pruebas de integración en dispositivo
│   ├── test_driver/          Driver para capturas de evidencia
│   ├── tool/                 Scripts de compilación e instalación en Windows
│   └── docs/                 Alcance del sprint y guía de demostración
├── Pruebas/
│   ├── REPRODUCIR.md         Cómo repetir la verificación
│   └── evidencias/           Capturas, logs e inspecciones de la verificación
└── UML_fuentes/    Fuentes PlantUML de los diagramas UML v1.1
```

## Ejecutar y probar

Consulta [Sprint 2/psps_academy/README.md](Sprint%202/psps_academy/README.md) para ejecutar la app y generar el APK, y [Sprint 2/Pruebas/REPRODUCIR.md](Sprint%202/Pruebas/REPRODUCIR.md) para repetir las pruebas actuales. La documentación histórica del Sprint 1 permanece en su carpeta.

## Gestión del trabajo

El Product Backlog, los Sprint Backlogs y los defectos se gestionan en **GitHub Issues** con la etiqueta `backlog`, los hitos `Sprint 01`, `Sprint 02` y `Sprint 03`, y las etiquetas de estado `pendiente`, `en-progreso`, `en-revision` y `terminado` (Project Plan §6).

Ramas: `main` (versiones liberadas), `develop` (integración) y `feature/<issue>-<descripción>` (Plan de integración v1.1).

El APK no se versiona en el repositorio; se genera con `flutter build apk --debug`.
