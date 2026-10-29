# Diseño de referencia CU-05 Explorar módulos

Responsable del caso de uso: Sebastián Guerra Hernández. Entrega técnica: 24/10/2026. Rama: feature/CU-05-modulos.

## 1. Base y estado de la revisión

Síntesis técnica del diseño existente para preparar la entrega de construcción. Fuente: Borrador de diseño CU-10 y revisión de CU-05, 19/10/2026, secciones 3 a 5; SRS v0.1 del Sprint 01, RF-01 / CA-01; SDS v0.2 del Sprint 02; y código publicado en main, base 57b8b83. La estructura de entrega sigue CU-07 de Francisco Valdez García.

El diseño requiere revisión por una persona distinta de Sebastián, autor/responsable de CU-05. Este documento identifica el comportamiento implementado y verificado; no acredita la firma ni la aprobación pendiente de Marco, ni cierra los ID 30 y 35 del PSR.

## 2. Recorrido y límites funcionales

Inicio (Módulos) -> seleccionar módulo -> estructura de temas y subtemas -> seleccionar un subtema -> índice del tema -> Estudiar subtema -> CU-01.

El usuario puede volver al inicio y elegir otro módulo sin terminar el anterior. Todos los módulos, temas y subtemas son accesibles desde el principio. Consultar la estructura, abrir contenido o volver no responde preguntas ni concede puntos o logros.

| Pantalla / componente | Información y comportamiento |
| --- | --- |
| HomeScreen | Lista de módulos; nombre y materia/área; resumen calculado del catálogo. Cada tarjeta permite acceder sin bloqueos. |
| ModuleScreen | Nombre y descripción del módulo; temas y subtemas asociados; estado visible en cada nivel. |
| TopicScreen | Subtemas del tema y acceso a su contenido. El estudio y las preguntas pertenecen a CU-01. |
| StatusBadge | Sin iniciar, En progreso y Completado con texto, ícono y color. Los estados se leen del controlador. |
| Carga o ausencia de datos | Error de recuperación con reintento y preservación del almacenamiento; catálogo vacío con mensaje explícito. |

## 3. Correspondencia con la arquitectura

| Elemento | Participación |
| --- | --- |
| C01 Presentación | HomeScreen, ModuleScreen y TopicScreen; navegación con Navigator. |
| C02 Catálogo | Módulos, temas y subtemas en lib/data/catalog.dart; CT-01 a CT-10. |
| C04 Progreso | Lectura de moduleStatus, topicStatus y lessonStatus; no altera el estado. |
| C07 Persistencia | Recuperación inicial mediante ProgressStore; la exploración no invoca save. |
| C06 Gamificación | Sus puntos y logros se conservan durante la exploración; no se conceden recompensas por consultar. |

## 4. Revisión técnica y siguiente paso

Los criterios RF-01 / CA-01 se verifican mediante CP05-01 a CP05-12 y TI05-01, documentados en WP.14. El quinto módulo y el catálogo vacío son datos de prueba; el catálogo del producto conserva cuatro módulos y diez temas demostrativos, sujetos a la validación curricular correspondiente.

Pendientes: dictamen independiente del diseño y del código, decisión de integración del equipo y registro de horas reales. Si la revisión solicita cambios, actualizar código, pruebas y este diseño en la misma rama.
