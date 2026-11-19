# WP.11 - Componentes de software CU-10

Responsable: Sebastián Guerra Hernández. Entrega técnica: 24/10/2026. Rama: feature/CU-10-puntos. Base main: 03193f112f30c0d632bf933bbc50fb333f219f42; aplicación Flutter 0.2.0-dev.2+3.

## 1. Alcance y actividad

CU-10 Consultar puntos acumulados, RF-09 / CA-09B: mostrar el total local, o 0 si no hay recompensas; entrar, salir y consultar no modifica puntos, progreso, actividades ni logros. G-01 se aplica según el acuerdo interno MR-09, sección 3.2, página 3: +10 por la primera finalización válida y guardada de una actividad elegible con ID único; repetición, intento incompleto, consulta y repaso aportan 0.

| Dato | Registro |
| --- | --- |
| Actividad de construcción | T07 / SI.04.02 / Componentes WP.11; ID 39 y 46 del PSR. Son dos jornadas de la misma construcción, no dos casos de uso. |
| Planeación | ID 39: 22/10/2026, 0.75 h; ID 46: 23/10/2026, 2.75 h. Total: 3.50 h estimadas. |
| Ejecución documentada | 24/10/2026. Horas reales pendientes de registrar por Sebastián. |
| Dependencias indicadas | ID 14, 21, 30 y 35. MR-09 acredita el acuerdo interno de G-01; la revisión independiente del diseño y la línea base no se declaran cerradas. |
| Referencia de estructura | Entregas de CU-07 de Francisco Valdez García, FireBoss12, y CU-05 aprobada por el usuario. |

## 2. Componentes reutilizados y cambios

La pantalla Puntos, la regla de 10 puntos y la persistencia ya forman parte del incremento publicado por Francisco. Esta entrega los reutiliza, añade ajustes de presentación y accesibilidad y completa la verificación específica de CU-10. Los archivos siguientes son relativos a Sprint 2/psps_academy.

| Componente | Responsabilidad y archivo real |
| --- | --- |
| FeatureLinks / PointsScreen | Acceso desde Módulos o Mi progreso; total, reglas, estado de carga y error. lib/ui/sprint2_screens.dart. |
| LearningController | Consulta points; confirma cambios solo tras guardar; evita nuevas recompensas para actividades ya realizadas. lib/domain/learning_controller.dart, reutilizado. |
| Gamification | pointsPerPractice = 10; identifica actividades completadas del catálogo. lib/domain/gamification.dart, reutilizado. |
| ProgressSnapshot / LocalProgressStore | Total, IDs recompensados y datos de progreso en almacenamiento local; lectura fallida se distingue de un saldo 0. lib/data/progress_store.dart, reutilizado. |
| Pruebas específicas | test/points_consultation_test.dart; integration_test/cu10_offline_test.dart; selector añadido a tool/verify_sprint2_android.ps1. |

- El texto de G-01 exige finalización guardada; se aclara que los puntos son recompensas de gamificación y no una calificación académica.
- El total dispone de etiqueta y valor para lectores de pantalla; un contenedor propio evita mezclarlo con el texto siguiente y el ajuste de escala evita desbordes en pantallas estrechas.
- Se conserva CU-10 como consulta del total, sin historial ni fechas de transacciones. No se agrega una regla nueva de validez de actividades a CU-02.
- Se agregan 16 pruebas específicas, un recorrido Android con almacenamiento nativo y documentos editables; se reutiliza el ejecutor aislado de CU-05/CU-07.

## 3. Verificación ejecutada

| Verificación | Resultado y evidencia |
| --- | --- |
| Flutter analyze | Sin incidencias; Pruebas/CU10/analisis-cu10.log. |
| Específicas CU-10 / G-01 | 16 aprobadas: 10 de lógica y 6 de widgets; pruebas-cu10.log. |
| Suite completa | 68 aprobadas, incluidas las 16 anteriores; regresion-cu10.log. |
| Integración Android | Un recorrido aprobado en emulador Android 17, modo avión y sin red, con seis capturas; resultado-integracion.json. |

## 4. Estado y pendientes

Construcción y verificación técnica listas para revisión del equipo. Pendientes: dictamen de otro integrante sobre diseño y código, decisión de integración y registro de horas reales. No se modifican el PSR, firmas ni aprobación de requisitos. La aprobación de G-01 es interna y está documentada en MR-09; no se convierte en aprobación de cliente de RF-09. La fecha técnica es real y no reemplaza las fechas planeadas de los ID 39 y 46.
