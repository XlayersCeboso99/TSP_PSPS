# Evidencias del diseño del sprint 2

PSPS Academy · 0.2.0-dev.2+3 · 24/10/2026.

| Evidencia | Qué muestra |
| --- | --- |
| S2-01 | Inicio y accesos a las nuevas secciones. |
| S2-02 | Actividades agrupadas con estado de realización. |
| S2-03 | Total de puntos local. |
| S2-04 | Logros obtenidos y condiciones. |
| S2-05 | Selección y condiciones de temas de color. |
| S2-06 | Búsqueda por títulos y contenido. |
| S2-07 | Apertura del subtema desde un resultado. |
| S2-08 | Búsqueda sin resultados. |
| S2-09 | Preguntas pendientes de repaso. |
| S2-10 | Intento incorrecto del repaso. |
| S2-11 | Acierto guardado del repaso. |
| S2-12 | Repaso sin pendientes. |
| S2-13 | Inicio con el tema Noche. |
| S2-14 | Logros con el tema Noche. |

Las imágenes provienen de la app ejecutándose en Android físico modelo 24049RN28L. Se usó un estado de prueba para recorrer migración, actividades, búsqueda, logros, repaso y temas. No representan el avance personal del usuario ni una aprobación del cliente.

`pruebas-automaticas.log`: 40 pruebas aprobadas. `prueba-diseno-android.log`: recorrido integral aprobado en el teléfono. `compilacion-apk.log`: construcción de la app normal para entrega.

La persistencia se comprueba creando un controlador nuevo que recupera los datos del almacenamiento nativo. No se realizó una prueba de reinicio del sistema operativo, modo avión o iOS en esta entrega.
