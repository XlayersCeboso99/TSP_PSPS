# Diseño de referencia CU-10 - Consultar puntos

Responsable: Sebastián Guerra Hernández. Entrega técnica: 24/10/2026. Rama: feature/CU-10-puntos.

## 1. Base y estado de revisión

Esta síntesis describe la implementación de CU-10 preparada en 24/10/2026; conserva el diseño recibido y documenta la correspondencia con el código. No reemplaza el dictamen de Marco sobre el diseño de Sebastián ni cierra los ID 30 y 35. La revisión interna del catálogo G-01 en MR-09 se distingue de la revisión de diseño y de la aprobación de RF-09.

| Fuente del ZIP recibido | Contenido utilizado |
| --- | --- |
| PSPS_CasosDeUso_Sprint02_TSP_Ago26.pdf, página 5 | CU-10 / RF-09 / CA-09B; total local o 0, consulta sin efectos y error distinguible. |
| PSPS_BorradorDiseno_CU10_Sprint02_TSP_Ago26.pdf, páginas 2 a 4 | Vista Puntos, lectura local, navegación de regreso y revisión independiente pendiente. |
| PSPS_Propuesta_G01_Puntos_Sprint02_TSP_Ago26.pdf, páginas 2 a 3 | Reglas P-01 a P-11, usadas con el acuerdo posterior de MR-09. |
| PSPS_RegistroDeReunion_MR09_TSP_Ago26.pdf, páginas 3 a 4 | Acuerdo interno G-01: +10 único por actividad válida guardada; consultas y repaso sin premio; logros no dan puntos. |
| PSPS_SDS_v0.2_Sprint02_TSP_Ago26.pdf, páginas 2 a 5 | C01/C06/C07; consultarPuntos, error sin reset y TW-03. |
| PSPS_RegistroRevisionDiseno_Sprint02_TSP_Ago26.pdf, páginas 2 a 3 | CU-10 requiere revisión independiente y eliminar historial del alcance. |
| PSPS_CasosDePrueba_Sprint02_TSP_Ago26.xlsx | Hoja WP14 Unitarias, filas 37 a 41: TU-S2-030 a TU-S2-034, referencia de cobertura. |

Los documentos de origen conservan textos anteriores de propuesta o aprobación pendiente; para G-01 se aplica el acuerdo de MR-09. No se infiere que el SRS haya sido aprobado ni que exista una revisión de diseño firmada.

## 2. Flujo y contrato

Módulos o Mi progreso → Puntos → recuperar estado disponible → mostrar total → volver. Esta ruta es la implementada en FeatureLinks; se presenta para revisión del equipo, sin atribuirle aprobación previa.

| Situación | Comportamiento |
| --- | --- |
| Estado válido sin recompensas | Mostrar 0 pts. No crear un registro por consultar. |
| Estado válido con recompensas | Mostrar el total de LearningController.points, validado al cargar. No conceder ni gastar puntos. |
| Carga en curso | Mostrar Recuperando tus datos; no presentar un cero como si fuera el saldo recuperado. |
| Lectura fallida o dato incompatible | Mostrar error y Reintentar carga; preservar lo guardado y ocultar el total. |
| Volver o consultar repetidamente | Conservar total, preguntas, actividades, logros y tema visual sin escritura. |

## 3. Componentes y G-01

C01: PointsScreen y FeatureLinks. C06: Gamification y consulta points del LearningController. C07: ProgressSnapshot y LocalProgressStore. El total se persiste con las actividades recompensadas; la pantalla lee el controlador ya cargado, no ejecuta un guardado al abrirse.

El guardado de actividades pertenece al flujo existente de CU-02: el controlador prepara la recompensa y solo la publica tras guardar. La identidad de la actividad impide premios duplicados. La entrega no cambia el criterio de actividad válida ni añade condiciones de acierto. Para formatos históricos v1/v2 se conserva la recuperación en memoria existente, sin escribir por lectura ni inventar fechas.

CU-10 muestra únicamente el total, el aviso de almacenamiento local y las reglas explicativas de gamificación. El total tiene nombre y valor para lectores de pantalla y se ajusta al ancho disponible. No se diseña historial, compra, consumo de puntos ni calificación académica.

## 4. Verificación y siguiente paso

CP10-01 a CP10-16 y TI10-01 se documentan con resultados en WP.14. La implementación base se reutiliza del incremento de Francisco; esta entrega aporta ajustes y verificación específica. Pendientes: revisión de diseño/código por otra persona, integración y registro de horas reales de los ID 39 y 46.
