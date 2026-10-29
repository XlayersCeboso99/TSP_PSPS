# WP.11 - Componentes de software CU-05

Responsable del caso de uso: Sebastián Guerra Hernández. Entrega técnica: 24/10/2026. Rama: feature/CU-05-modulos. Base: main, commit 57b8b8356b2932b52b915612887a366369b069a3; aplicación Flutter 0.2.0-dev.2+3.

## 1. Alcance de la actividad

ID 38 del PSR, T07 / SI.04.02: construir CU-05 Explorar los módulos de la aplicación. RF-01 / CA-01: consultar todos los módulos y su materia, abrir su estructura de temas y subtemas y acceder al contenido libremente, conservando el avance y las recompensas.

| Dato | Registro |
| --- | --- |
| Fecha planeada y estimación | 22/10/2026; 2.00 h estimadas. No son horas reales. |
| Ejecución documentada | 24/10/2026. Horas reales pendientes de registrar por Sebastián. |
| Diseño de referencia | Diseno/CU05/PSPS_DisenoCU05_Sprint02_TSP_Ago26.pdf. Revisión independiente pendiente; este registro no acredita los ID 30 y 35. |
| Referencia de formato | Entrega de CU-07 de Francisco Valdez García, FireBoss12, en feature/CU-07-repaso. |

## 2. Componentes y código

Los archivos de esta tabla son relativos a Sprint 2/psps_academy. La navegación HomeScreen, ModuleScreen y TopicScreen ya estaba en la aplicación publicada por Francisco. Se reutiliza esa base y se completa la entrega específica de CU-05; no se atribuye toda la aplicación a este trabajo.

| Componente | Responsabilidad y archivo real |
| --- | --- |
| HomeScreen | Lista todos los módulos y su materia; cada tarjeta abre ModuleScreen sin condición de avance. lib/ui/app.dart. |
| ModuleScreen | Muestra la jerarquía del módulo, sus temas y subtemas y sus estados. lib/ui/app.dart. |
| TopicScreen | Presenta los subtemas; Estudiar subtema entrega el control a CU-01. Abrirlo no responde preguntas. lib/ui/app.dart. |
| StatusBadge | Comunica Sin iniciar, En progreso y Completado con texto, ícono y color. lib/ui/app.dart. |
| LearningController | Consulta estados derivados de respuestas existentes; sus lecturas no invocan el guardado. lib/domain/learning_controller.dart. |
| Catálogo y persistencia | catalog.dart contiene CT-01 a CT-10. ProgressStore conserva el estado; CU-05 no escribe en él. lib/data/. |

## 3. Cambios de esta entrega

- El resumen de módulos y temas se calcula a partir del catálogo, en lugar de fijar cuatro y diez en la interfaz.
- La lista admite más de cuatro módulos sin acceder fuera del arreglo de íconos. El quinto módulo de las pruebas es un fixture; no se agrega al contenido del producto.
- Un catálogo vacío muestra un mensaje explícito, sin inventar módulos ni avance.
- Se agregan claves estables a tarjetas, subtemas y acceso de estudio para verificar los recorridos reales.
- Se añaden pruebas específicas y un objetivo de integración. El ejecutor Android incorpora el aislamiento de aplicación, namespace y actividad corregido en CU-07, y permite seleccionar el objetivo de CU-05.
- El ejecutor conserva el almacén de certificados configurado por el JDK. Se retiró una opción heredada Windows-ROOT/NONE incompatible con este entorno; la incidencia de compilación se conserva como INC-CU05-01.

## 4. Verificación y estado

| Verificación ejecutada | Resultado y ubicación |
| --- | --- |
| Análisis | Sin incidencias. Pruebas/CU05/analisis-cu05.log. |
| Casos específicos | 12 aprobados: 2 de catálogo/lógica y 10 de widgets. Pruebas/CU05/pruebas-cu05.log. |
| Regresión completa | 52 aprobados, incluidos los de CU-05; no se suman de nuevo. Pruebas/CU05/regresion-cu05.log. |
| Android sin red | Un recorrido aprobado en emulador, con modo avión y seis capturas. Pruebas/CU05/resultado-integracion.json. |

Construcción y verificación técnica preparadas para revisión del equipo. Pendientes: revisión por una persona distinta del autor, decisión sobre integración de la rama y registro de horas reales. No se modifican firmas, aceptación de la cliente ni estados del PSR.
