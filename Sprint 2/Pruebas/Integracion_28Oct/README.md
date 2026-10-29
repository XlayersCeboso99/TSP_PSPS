# Integración candidata del Sprint 02

Fecha local: 28/10/2026. Responsable de preparación: Francisco Valdez García, cuenta FireBoss12. Candidata: 0.2.0+5.

Se reúnen los cambios ya fusionados en main (53355a9), las correcciones de CU-09 de Pablo (15508d2 y 0a4c4e8), la rama de calidad de Sebastián (ade1b44), CU-06 de Pablo (6fef628) y CU-08 de Marco (348d837). Los autores y commits originales se conservan. La rama se propone para develop; no declara aprobada su propia revisión.

## Cambios de integración

- CU-08 está dentro de Sprint 2/psps_academy, conectado desde ActivitiesScreen y la navegación real a CU-02. LearningActivityStore utiliza el LearningController y su ProgressStore; no crea un segundo almacenamiento ni duplica premios.
- La lista vuelve a leer al regresar de la actividad y al recibir una finalización del motor. Se conserva el estado vacío y la consulta sin escrituras.
- CU-06 conserva el catálogo de diez logros (L-01 a L-09 y L-11) acordado en MR-09. El repaso no concede recompensas. Se adaptan sus pruebas a ese acuerdo, preservando las mejoras de presentación de Pablo.
- Se conserva la corrección de 44 píxeles de CU-09 y se reúnen sus registros publicados.
- Se concilian las validaciones de catálogo y los objetivos de integración. La prueba heredada H-01 bombea un frame después de seleccionar la opción para que el botón habilitado procese el siguiente toque; mantiene las comprobaciones originales de respuesta y avance.
- pubspec.yaml contiene 0.2.0+5. El APK se construye sin sobrescribir la versión mediante opciones de consola.

## Resultados reales

| Control | Resultado |
| --- | --- |
| Suite test/ | 140 aprobadas, cero fallos |
| Verificación heredada separada | 5 aprobadas, cero fallos |
| Flutter analyze | Sin incidencias |
| Integración Android | Recorrido integral aprobado en 24049RN28L, Android 16, en modo avión sin red predeterminada |
| Capturas Android | 15, incluido regreso de CU-08 con actividad Realizada |
| Instalación normal | Permaneció instalada; las pruebas usaron mx.edu.uaz.psps.integration y una clave independiente |
| Conectividad al terminar | Modo avión y Wi-Fi restaurados a sus valores anteriores |
| APK normal | 0.2.0, versionCode 5, firma de desarrollo verificada |

Los cinco casos heredados son los que contiene la verificación de calidad. No identifican por sí solos todos los defectos originales pendientes de MR-07. La persistencia nativa se verificó recreando el controlador y la interfaz, sin reiniciar el sistema operativo. La integración es un recorrido automatizado en dispositivo, no una aceptación de la cliente.

APK entregado aparte: PSPS_Sprint02_0.2.0_Android.apk. SHA-256: 23a5be0fc937b3ecf55921d7f5745170edf20d38f5b0c9b76fc3de76dc3127ab. No se incorpora el binario de unos 155 MB al historial Git. Se reproduce desde Sprint 2/psps_academy con flutter pub get y flutter build apk --debug. Esta es una compilación interna firmada para desarrollo.

## Documentos y revisión

La guía versión 0.3 incorpora las capturas actuales y el control de versiones, en 06 Documentacion/Guia de operacion. El registro de revisión inicial de CU-08/CU-09 se conserva en 05 Pruebas y Calidad/Revision por pares. Sus hallazgos se atienden técnicamente aquí; otro integrante debe revisar las correcciones antes de aprobar su cierre.

Los registros originales de CU-06 conservan evidencia histórica de la rama que probaba once logros. Sus resultados no certifican el catálogo vigente. La evidencia de esta carpeta, con el catálogo conciliado, es la que corresponde a la candidata actual.

## Relación con el PSR

- ID 60/68: revisión documentada; correcciones técnicas realizadas en esta candidata. Aprobación independiente pendiente.
- ID 64/73: candidata integrada preparada para develop y APK 0.2.0 generado. Merge y revisión pendientes.
- ID 69: el código de CU-07 de la entrega consolidada se conserva y vuelve a probarse dentro de la candidata; no se afirma cerrado todo PR alternativo.
- ID 70: guía elaborada, actualizada y publicada en la rama para revisión.
- ID 61: se repiten cinco verificaciones heredadas. El registro oficial y la correspondencia de IDs originales requieren revisión de Sebastián.
- ID 72: recorrido Android automatizado sin conexión ejecutado con evidencias. No sustituye cubrir cada caso manual comprometido ni cerrar WP.15.
- No se inventan horas humanas, firmas, decisiones de cliente ni estados del PSR. Review, retrospectiva y etiqueta v0.2.0-sprint02 siguen conforme al plan del 29 y 30/10.

## Entrega de Marco recibida por chat

Los archivos id43,49 y 56.zip e id 57.zip recibidos el 28/10 tienen 22 bytes y cero entradas. No aportaron código o evidencia utilizable. Se conservó e integró la versión de Marco publicada en el PR 9; no se inventó contenido de esos ZIP.
