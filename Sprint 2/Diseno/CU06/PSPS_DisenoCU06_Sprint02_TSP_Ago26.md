# Diseño de referencia CU-06 Consultar los logros obtenidos

Responsable del caso de uso: Pablo Valentín Varela Rivera. Entrega técnica: 25/10/2026. Rama: feature/CU-06-logros.

## 1. Base y estado de la revisión

Síntesis técnica del diseño vigente para la entrega de construcción. Fuentes: SDS v0.2, sección 9 (diseño de CU-06 y del componente C06, tarea S2-38); catálogo «G-02 Logros y G-03 Desbloqueos» (S2-37, opción b) y «Propuesta G-01 Puntos» (S2-24), acordados por el equipo en MR-09 (D-02); SRS v0.1, RF-06 / CA-06; y la aplicación integrada 0.2.0-dev.2+3. La estructura de entrega sigue la de CU-05 de Sebastián Guerra Hernández.

El diseño requiere revisión por una persona distinta de Pablo, autor y responsable de CU-06 (ID 30 del PSR). Este documento describe el comportamiento implementado; no acredita esa revisión ni la aceptación de la cliente.

## 2. Recorrido y límites funcionales

Inicio -> Mi progreso (o Módulos) -> Logros -> lista de logros obtenidos y temas de color -> elegir un tema desbloqueado.

Los logros se obtienen en otros casos de uso, solo después de guardar con éxito: una respuesta (CU-01), una actividad realizada (CU-02) o una pregunta acertada en el repaso (CU-07). Consultar la pantalla «Logros», buscar o abrir contenido nunca otorga logros ni escribe en el almacenamiento. Los temas de color no bloquean ningún contenido.

| Pantalla / componente | Información y comportamiento |
| --- | --- |
| AchievementsScreen | Conteo «N de 11 logros obtenidos»; cada logro obtenido con ícono, nombre, «Condición cumplida: …» y «Obtenido el dd/mm/aaaa» o «Fecha no disponible». |
| Estado vacío (A1) | «Aún no tienes logros. Realiza actividades y completa temas para obtenerlos.» |
| Próximos logros | Lista plegable de los logros que faltan, con su condición. |
| Temas de color | Bosque, Océano, Atardecer y Noche: «En uso», «Disponible» o «Bloqueado» con la condición que falta. Solo los disponibles muestran «Usar …». |
| Aviso | Al guardar una acción que otorga recompensas: «¡Logro obtenido: Manos a la obra! Desbloqueaste el tema Océano.» Se muestra una sola vez. |
| Error de carga | Mensaje con «Reintentar carga»; no muestra ceros ni sobrescribe el almacenamiento. |

## 3. Catálogo aplicado (MR-09)

| ID | Logro | Regla | Se evalúa al guardar |
| --- | --- | --- | --- |
| L-01 | Primer paso | preguntas respondidas ≥ 1 | Respuesta (CU-01) |
| L-02 | Subtema completo | subtemas completos ≥ 1 | Respuesta (CU-01) |
| L-03 | Manos a la obra | actividades realizadas ≥ 1 | Actividad (CU-02) |
| L-04 | Práctica constante | actividades realizadas ≥ 5 | Actividad (CU-02) |
| L-05 | Todas las prácticas | actividades realizadas = total | Actividad (CU-02) |
| L-06 a L-09 | Un logro por módulo (m1 a m4) | módulo completo | Respuesta (CU-01) |
| L-10 | Aprendo del error | preguntas acertadas en el repaso ≥ 3 | Repaso (CU-07) |
| L-11 | Recorrido completo | módulos completos = total | Respuesta (CU-01) |

Temas (G-03, opción b): U-00 Bosque desde el inicio; U-01 Océano con L-03; U-02 Atardecer con cualquiera de L-06 a L-09; U-03 Noche con L-11. Puntos (G-01): 10 por la primera finalización guardada de cada actividad; los logros no dan puntos.

## 4. Correspondencia con la arquitectura

| Elemento | Participación |
| --- | --- |
| C01 Presentación | AchievementsScreen y FeatureLinks (lib/ui/sprint2_screens.dart); aviso en reportSave (lib/ui/app.dart) y en el repaso (lib/ui/review_screens.dart). |
| C06 Gamificación | Catálogo, reglas y texto del aviso en lib/domain/gamification.dart (Dart puro). |
| C04 / C05 | Respuestas y actividades aportan los hechos del avance (ProgressFacts). |
| LearningController | Calcula los logros al guardar, conserva fechas y expone earnedAchievements, unlockedThemes, selectedTheme, selectTheme, newAchievements y newThemes. |
| C07 Persistencia | Formato 3 en psps.progress.v1; lee formatos 1 y 2 sin escribir. |

## 5. Diferencias con el SDS v0.2 que debe registrar la revisión

| Tema | SDS v0.2 | Implementación | Propuesta |
| --- | --- | --- | --- |
| Estado local (9.4) | Formato v2 con achievedAt, reviewed y theme. | Formato 3 de la app integrada: achievements (fecha o nulo), reviewAnswers, selectedTheme, points y rewardedPractices. Mismo comportamiento y compatibilidad con v1 y v2. | Actualizar 9.4 al formato 3. |
| Interfaz (9.5) | earnedAchievementIds, takeRewardNotice, markReviewed. | earnedAchievements, newAchievements/newThemes, reviewAnswer. | Actualizar 9.5 con los nombres reales. |
| Clases (9.2) | GamificationCatalog, ColorThemeOption, RewardNotice. | Gamification, VisualTheme y Gamification.rewardMessage; Achievement con regla, umbral y módulo; ProgressFacts. | Actualizar 9.2. |
| U-03 Noche (9.7) | Proponía tonos azul noche. | Modo oscuro, como dice el catálogo; ya probado en la app integrada. | Cerrar la decisión de 9.7 a favor del catálogo. |
| Acceso (9.6) | Tarjeta con conteo en «Mi progreso». | Botón «Logros» en «Mi progreso» y en «Módulos»; el conteo se muestra dentro de la pantalla. | Aceptar o pedir el conteo en el botón. |

## 6. Revisión técnica y siguiente paso

Los criterios RF-06 / CA-06, CA-06b y CA-07 se verifican con CP06-01 a CP06-13 y TI06-01, documentados en WP.14. Pendientes: dictamen independiente del diseño y del código, decisión de integración del equipo y registro de horas reales. Si la revisión solicita cambios, actualizar código, pruebas y este diseño en la misma rama.
