# Diseño de referencia CU-09 Buscar contenidos por palabra clave

Responsable del caso de uso: Pablo Valentín Varela Rivera. Entrega técnica: 25/10/2026. Rama: feature/CU-09-busqueda.

## 1. Base y estado de la revisión

Síntesis técnica del diseño vigente para la entrega de construcción. Fuentes: especificación de CU-09 (RF-11, CA-11) en PSPS_CasosDeUso_Sprint02_TSP_Ago26.pdf; borrador de mockup y diseño de CU-09 (S2-36, 19/10/2026), mockups M-09A a M-09D y reglas 2.3; y la aplicación integrada 0.2.0-dev.2+3. La estructura de entrega sigue la de CU-05 de Sebastián Guerra Hernández.

El diseño requiere revisión por una persona distinta de Pablo, autor y responsable de CU-09 (ID 30 del PSR). La regla de acentos (O-01) es una decisión de diseño para esa revisión: este documento no la presenta como aprobada.

## 2. Recorrido y límites funcionales

Inicio -> lupa «Buscar contenidos» -> escribir una palabra o frase -> resultados -> tocar un resultado -> subtema (CU-01).

La búsqueda es local, funciona sin conexión y no escribe en el almacenamiento. Encontrar o abrir un resultado no cuenta como avance ni otorga puntos o logros.

| Pantalla / estado | Información y comportamiento |
| --- | --- |
| M-09A Inicio | Lupa en la barra superior. La pantalla de Inicio solo aparece cuando el catálogo cargó. |
| M-09B Texto corto (A2) | Con menos de 3 caracteres no se busca: «Escribe al menos 3 letras» y un recuadro que explica qué se busca y que funciona sin conexión. |
| M-09C Resultados | «N resultados para «…»» (singular con uno); primero «EN TÍTULOS» y después «EN EL CONTENIDO». Cada resultado: subtema, ruta Módulo › Tema, fragmento con la coincidencia resaltada, estado y «Abrir subtema». |
| M-09D Sin resultados (A1) | «No se encontraron temas con «…»» y «Explorar módulos», que regresa a Inicio (CU-05). El campo sigue disponible para cambiar la búsqueda. |
| Cancelar (A3) | Regresar con la flecha de la barra; no cambia nada. |
| Catálogo no disponible (E1) | «No pudimos recuperar el catálogo local.» con «Reintentar». |

## 3. Reglas de búsqueda

| Regla | Comportamiento implementado |
| --- | --- |
| Texto | Se quitan espacios de los extremos y los espacios repetidos dentro de una frase. |
| Mínimo | 3 caracteres (A2). |
| Normalización | Minúsculas y sin acentos (á é í ó ú ü); la ñ se conserva. Un salto de línea cuenta como espacio, así una frase del ejemplo coincide aunque cambie de renglón. |
| Campos que se buscan | Nombre y materia del módulo, tema, subtema, contenido y ejemplo. |
| Campos que no se buscan | Preguntas, opciones, explicaciones y actividades. |
| Resultados | Uno por subtema. Si coincide en título y contenido, aparece solo en títulos. Cada grupo conserva el orden del catálogo. |
| Fragmento | Unos 90 caracteres alrededor de la primera coincidencia, en una sola línea, con «…» si se recorta. |
| Momento | Mientras se escribe; el catálogo es pequeño y está en memoria. |

## 4. Correspondencia con la arquitectura

| Elemento | Participación |
| --- | --- |
| C01 Presentación | Lupa en HomeScreen (lib/ui/app.dart) y SearchScreen (lib/ui/sprint2_screens.dart); abre LessonScreen. |
| C02 Catálogo | ContentSearch, SearchResult y MatchField en lib/domain/content_search.dart (Dart puro). |
| C04 Progreso | Solo lectura: lessonStatus para la insignia de cada resultado. |
| C06 y C07 | No participan: la búsqueda no escribe estado ni concede recompensas. |

## 5. Diferencias con el borrador S2-36

| Tema | Borrador | Implementación | Propuesta |
| --- | --- | --- | --- |
| Archivo de la pantalla | lib/ui/search_screen.dart | SearchScreen está en lib/ui/sprint2_screens.dart, junto a las demás pantallas del Sprint 2 de la app integrada. | Aceptar la ubicación. |
| Pruebas | test/content_search_test.dart | test/cu09_search_test.dart (CP09-01 a CP09-15), además de las pruebas CU09 de sprint2_test.dart. | Aceptar. |
| Frases | No mencionaba saltos de línea ni espacios repetidos. | Se toleran ambos (sección 3). | Registrar en la revisión. |
| Acentos (O-01) | Propuesta para cerrar O-01 y actualizar CA-11. | Implementado como se propuso. | Confirmar en la revisión y reflejarlo en CA-11. |

## 6. Revisión técnica y siguiente paso

RF-11 / CA-11 se verifican con CP09-01 a CP09-15 y TI09-01, documentados en WP.14. Pendientes: dictamen independiente del diseño y del código (revisión de código de Francisco, IDs 60 y 68), decisión de integración y registro de horas reales.
