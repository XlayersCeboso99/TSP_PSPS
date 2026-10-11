# Casos de prueba ejecutados WP.14

PSPS Academy 0.1.0+1 · Sprint 1 · Versión documental 1.0
9 de octubre del 2026
Código evaluado 1bcf2556e221ba4a58d10b3a92ec5d897e91e9c8

Se registran los casos de prueba del incremento Flutter y su relación con la matriz de auditoría v1.1 del 09/10/2026. La ejecución se realizó el 10/10/2026, como verificación posterior al Sprint 1; no se trasladan estos resultados a fechas anteriores ni se atribuye aceptación de la cliente.

Resumen: {'Aprobado': 19, 'Parcial': 4, 'Sin ejecutar': 7}



## TU-01 Abrir o consultar un subtema no cambia su estado.

**Estado** Aprobado

**Requisitos** RF-02

**Criterio** CA-02

**Precondiciones y datos** MemoryStore vacío; abrir contenido y avanzar sin responder.

**Procedimiento** Consultar estados y navegar contenido; comprobar conteo y escrituras.

**Esperado** Abrir o consultar un subtema no cambia su estado.

**Obtenido** 0 respuestas y 0 escrituras; consultar no cambia el estado.

**Evidencia** flutter_test_final.log; test/progress_test.dart; E03



## TU-02 Respuesta correcta: indica correcta, muestra retroalimentación y registra la pregunta.

**Estado** Aprobado

**Requisitos** RF-02

**Criterio** CA-02

**Precondiciones y datos** Primera pregunta del catálogo; elegir correctIndex.

**Procedimiento** Abrir subtema, ir a preguntas, seleccionar opción correcta y Comprobar.

**Esperado** Respuesta correcta: indica correcta, muestra retroalimentación y registra la pregunta.

**Obtenido** Respuesta correcta, explicación visible y conteo 1.

**Evidencia** flutter_test_final.log; test/audit_evidence_test.dart; E05



## TU-03 Respuesta incorrecta: indica incorrecta, muestra retroalimentación y también registra la pregunta.

**Estado** Aprobado

**Requisitos** RF-02

**Criterio** CA-02

**Precondiciones y datos** Pregunta sin respuesta; opción diferente de correctIndex.

**Procedimiento** Comprobar respuesta incorrecta y verificar retroalimentación y avance.

**Esperado** Respuesta incorrecta: indica incorrecta, muestra retroalimentación y también registra la pregunta.

**Obtenido** Sigue aprendiendo; explicación y opción correcta; conteo aumenta a 1.

**Evidencia** flutter_test_final.log; test/app_test.dart; E04



## TU-04 Responder de nuevo una pregunta no aumenta el conteo.

**Estado** Parcial

**Requisitos** RF-02

**Criterio** RP-02

**Precondiciones y datos** Pregunta ya respondida incorrectamente.

**Procedimiento** Llamar answer de nuevo con opción correcta; comparar registro y conteo.

**Esperado** Responder de nuevo una pregunta no aumenta el conteo.

**Obtenido** El conteo sigue en 1 y se conserva la respuesta original. No se actualiza la retroalimentación al repetir como pide RP-02 del plan v1.1.

**Evidencia** flutter_test_final.log; test/progress_test.dart; lib/domain/learning_controller.dart; H-01



## TU-05 El catálogo contiene CT-01 a CT-10.

**Estado** Aprobado

**Requisitos** RF-01

**Criterio** CA-01

**Precondiciones y datos** Catálogo provisional de la versión 0.1.0+1.

**Procedimiento** Comparar conjunto de temas con CT-01 a CT-10; validar IDs y rangos de opciones.

**Esperado** El catálogo contiene CT-01 a CT-10.

**Obtenido** 10 temas requeridos; IDs únicos; respuestas correctas dentro del rango.

**Evidencia** flutter_test_final.log; test/progress_test.dart



## TU-06 Un catálogo inválido se rechaza con mensaje de contenido no disponible.

**Estado** Sin ejecutar

**Requisitos** RF-01

**Criterio** RP-01

**Precondiciones y datos** Se requiere catálogo inválido como entrada.

**Procedimiento** Caso pendiente: inyectar referencias inválidas y verificar mensaje de contenido no disponible.

**Esperado** Un catálogo inválido se rechaza con mensaje de contenido no disponible.

**Obtenido** No existe validación de catálogo ni escenario automatizado equivalente; la validación de estado guardado no sustituye este caso.

**Evidencia** lib/data/catalog.dart; lib/domain/learning_controller.dart; H-02



## TU-07 Subtema en gris, naranja y verde según preguntas respondidas.

**Estado** Aprobado

**Requisitos** RF-04

**Criterio** CA-04

**Precondiciones y datos** Subtema con dos preguntas pendientes.

**Procedimiento** Consultar estado inicial; responder una pregunta y después la segunda.

**Esperado** Subtema en gris, naranja y verde según preguntas respondidas.

**Obtenido** Sin iniciar, En progreso y Completado según 0, 1 y 2 respuestas.

**Evidencia** flutter_test_final.log; test/progress_test.dart; E03 a E05



## TU-08 Cada estado muestra texto e ícono además del color.

**Estado** Aprobado

**Requisitos** RF-04, RNF-05

**Criterio** CA-04 ampliado

**Precondiciones y datos** Tres StatusBadge en una interfaz de prueba.

**Procedimiento** Verificar texto, ícono y color distinto para cada estado.

**Esperado** Cada estado muestra texto e ícono además del color.

**Obtenido** Tres etiquetas e íconos; tres colores distintos.

**Evidencia** flutter_test_final.log; test/audit_evidence_test.dart



## TU-09 El tema se completa al completarse su último subtema.

**Estado** Aprobado

**Requisitos** RF-05

**Criterio** CA-05

**Precondiciones y datos** Primer tema con un subtema provisional de dos preguntas.

**Procedimiento** Responder la última pregunta y consultar estado de subtema y tema.

**Esperado** El tema se completa al completarse su último subtema.

**Obtenido** Ambos quedan Completado. No se prueba un tema con varios subtemas.

**Evidencia** flutter_test_final.log; test/progress_test.dart; E05



## TU-10 El módulo se completa aunque queden actividades pendientes.

**Estado** Aprobado

**Requisitos** RF-05

**Criterio** CA-05

**Precondiciones y datos** Primer módulo; actividades sin realizar.

**Procedimiento** Responder todas sus preguntas incorrectamente y consultar estado.

**Esperado** El módulo se completa aunque queden actividades pendientes.

**Obtenido** Módulo Completado con 0 actividades y 0 puntos.

**Evidencia** flutter_test_final.log; test/progress_test.dart



## TU-11 Una actividad con elementos pendientes no se registra como realizada.

**Estado** Aprobado

**Requisitos** RF-03

**Criterio** CA-03

**Precondiciones y datos** Actividad de tres pasos sin completar.

**Procedimiento** Guardar [0] y después [2,1,0].

**Esperado** Una actividad con elementos pendientes no se registra como realizada.

**Obtenido** Ninguna secuencia marca la actividad realizada; recompensa 0.

**Evidencia** flutter_test_final.log; test/progress_test.dart



## TU-12 La actividad completa se registra y su recompensa se asigna una sola vez.

**Estado** Aprobado

**Requisitos** RF-03, RNF-07

**Criterio** CA-03, RP-03

**Precondiciones y datos** Actividad de tres pasos y regla provisional de 10 puntos.

**Procedimiento** Guardar [0,1,2]; repetir; intentar vaciar; reabrir pantalla.

**Esperado** La actividad completa se registra y su recompensa se asigna una sola vez.

**Obtenido** Realizada automáticamente; puntos permanecen en 10; no cambia el avance educativo.

**Evidencia** flutter_test_final.log; test/progress_test.dart y app_test.dart; E06



## TU-13 Cada logro obtenido muestra nombre y condición.

**Estado** Sin ejecutar

**Requisitos** RF-06

**Criterio** CA-06

**Precondiciones y datos** Catálogo de logros sujeto a D-02.

**Procedimiento** Caso pendiente: obtener un logro y comprobar nombre y condición.

**Esperado** Cada logro obtenido muestra nombre y condición.

**Obtenido** Logros no implementados; requiere aprobación del catálogo.

**Evidencia** docs/SPRINT_1.md; H-03



## TU-14 Guardar y recuperar conserva avance, actividades, puntos y logros.

**Estado** Parcial

**Requisitos** RF-08, RNF-02, RNF-07

**Criterio** CA-08

**Precondiciones y datos** MemoryStore con respuesta, actividad completa y borrador parcial.

**Procedimiento** Crear otro controlador con el mismo almacenamiento y recuperar valores.

**Esperado** Guardar y recuperar conserva avance, actividades, puntos y logros.

**Obtenido** Se recuperan respuesta, actividad, borrador y 10 puntos derivados. Logros no implementados; el criterio completo sigue pendiente.

**Evidencia** flutter_test_final.log; test/progress_test.dart; H-03



## TU-15 Una falla de escritura conserva el último estado válido y muestra error.

**Estado** Aprobado

**Requisitos** RF-08, RNF-08

**Criterio** RP-05

**Precondiciones y datos** MemoryStore con failSave=true y pregunta pendiente.

**Procedimiento** Intentar responder; comprobar error; habilitar guardado y reintentar.

**Esperado** Una falla de escritura conserva el último estado válido y muestra error.

**Obtenido** Fallo no publica avance; muestra error. Reintento guarda y aumenta conteo a 1. Es una falla simulada, no corte físico de escritura.

**Evidencia** flutter_test_final.log; test/progress_test.dart



## TI-01 Inicio → módulo → tema → subtema sin modificar el avance.

**Estado** Aprobado

**Requisitos** RF-01

**Criterio** CA-01

**Precondiciones y datos** Android físico con clave de prueba vacía y redes desactivadas.

**Procedimiento** Abrir inicio, módulo, tema y subtema; avanzar contenido sin responder.

**Esperado** Inicio → módulo → tema → subtema sin modificar el avance.

**Obtenido** Navegación disponible; conteo continúa en 0.

**Evidencia** offline_prepare_final.log; integration_test/evidence_test.dart; E01 a E03



## TI-02 Responder todas las preguntas de un subtema: pasa a verde y se conserva al reabrir.

**Estado** Aprobado

**Requisitos** RF-02, RF-04

**Criterio** CA-02, CA-04

**Precondiciones y datos** Subtema de dos preguntas en Android offline.

**Procedimiento** Responder incorrecta y correcta; comprobar finalización; detener proceso y verificar en segunda ejecución.

**Esperado** Responder todas las preguntas de un subtema: pasa a verde y se conserva al reabrir.

**Obtenido** Subtema Completado y 2 respuestas recuperadas tras reinicio.

**Evidencia** offline_prepare_final.log; offline_verify_final.log; E04, E05, E07



## TI-03 Completar el último subtema completa tema y módulo.

**Estado** Aprobado

**Requisitos** RF-05

**Criterio** CA-05

**Precondiciones y datos** Almacenamiento nativo con clave exclusiva de integración.

**Procedimiento** Responder todas las preguntas del primer módulo; recrear controlador e interfaz.

**Esperado** Completar el último subtema completa tema y módulo.

**Obtenido** Módulo Completado recuperado; conteo igual a preguntas del módulo. La preparación usa llamadas al controlador.

**Evidencia** integration.log; integration_test/offline_test.dart



## TI-04 Realizar una actividad, reabrir y repetirla sin duplicar recompensas.

**Estado** Aprobado

**Requisitos** RF-03, RNF-07

**Criterio** CA-03, RP-03

**Precondiciones y datos** Actividad del primer tema; 10 puntos provisionales.

**Procedimiento** Ordenar sus tres pasos; detener proceso; reabrir y consultar actividad.

**Esperado** Realizar una actividad, reabrir y repetirla sin duplicar recompensas.

**Obtenido** Actividad realizada y 10 puntos recuperados, sin duplicación. La repetición directa se comprueba adicionalmente en TU-12.

**Evidencia** offline_prepare_final.log; offline_verify_final.log; E06, E08



## TI-05 Obtener un logro y consultarlo (requiere D-02).

**Estado** Sin ejecutar

**Requisitos** RF-06

**Criterio** CA-06

**Precondiciones y datos** Logros pendientes de implementación y D-02.

**Procedimiento** Caso pendiente: obtener logro y consultar sección.

**Esperado** Obtener un logro y consultarlo (requiere D-02).

**Obtenido** No ejecutable sobre el incremento actual.

**Evidencia** docs/SPRINT_1.md; H-03



## TI-06 Con modo avión: recorrer, completar un subtema y una actividad, cerrar y reabrir.

**Estado** Aprobado

**Requisitos** RF-08, RNF-02

**Criterio** CA-08

**Precondiciones y datos** Android 16; modo avión 1; Wi-Fi y datos móviles desactivados.

**Procedimiento** Recorrer contenido, completar subtema y actividad; force-stop; pidof sin proceso; ejecutar fase verify sin desinstalar.

**Esperado** Con modo avión: recorrer, completar un subtema y una actividad, cerrar y reabrir.

**Obtenido** Recupera 2/20 respuestas, 1 actividad y 10 puntos; contenido y actividad siguen accesibles. La clave exclusiva se limpia al finalizar.

**Evidencia** offline_prepare_final.log; offline_verify_final.log; dispositivo.json; E01 a E08



## TI-07 20 aperturas consecutivas de contenido por plataforma dentro del umbral.

**Estado** Sin ejecutar

**Requisitos** RNF-06

**Criterio** D-05

**Precondiciones y datos** Umbral y dispositivos de aceptación pendientes en D-03/D-05.

**Procedimiento** Caso pendiente: medir 20 aperturas consecutivas por plataforma.

**Esperado** 20 aperturas consecutivas de contenido por plataforma dentro del umbral.

**Obtenido** No se midieron tiempos ni se validó el umbral propuesto de 2 segundos.

**Evidencia** Matriz de auditoría v1.1; D-03 y D-05



## TI-08 Flujos CU-01 a CU-06 en los dispositivos de D-03.

**Estado** Parcial

**Requisitos** RNF-01, RNF-05, RNF-10

**Criterio** CA aplicables

**Precondiciones y datos** Android 16 modelo 24049RN28L y dos tamaños simulados de interfaz.

**Procedimiento** Ejecutar recorridos Android y prueba 320x640 con texto 1.4; comprobar excepciones.

**Esperado** Flujos CU-01 a CU-06 en los dispositivos de D-03.

**Obtenido** Android y prueba de pantalla estrecha aprobados. iOS, CU-06 y matriz final de D-03 sin verificar.

**Evidencia** flutter_test_final.log; integration.log; offline_prepare_final.log; H-03 y H-04



## INS-01 Repositorio y configuración de compilación.

**Estado** Aprobado

**Requisitos** RNF-03

**Criterio** —

**Precondiciones y datos** Código Flutter y configuración Android disponibles.

**Procedimiento** Inspeccionar pubspec.lock y Gradle; ejecutar análisis y compilación debug.

**Esperado** Repositorio y configuración de compilación.

**Obtenido** Flutter/Dart fijados por entorno; análisis sin incidencias y APK generado.

**Evidencia** analyze_final.log; build.log; pubspec.lock; android/app/build.gradle.kts



## INS-02 Pantallas y reglas sin compras, evaluación formal ni videojuego.

**Estado** Aprobado

**Requisitos** RNF-04

**Criterio** —

**Precondiciones y datos** Revisión estática de interfaz, dominio y dependencias del incremento.

**Procedimiento** Buscar flujos de compras, calificación académica formal y videojuego independiente.

**Esperado** Pantallas y reglas sin compras, evaluación formal ni videojuego.

**Obtenido** Se observa estudio, preguntas educativas, avance y actividades de ordenamiento; no se identifican los flujos excluidos.

**Evidencia** inspecciones.md; lib/ui/app.dart; lib/domain/learning_controller.dart; pubspec.yaml



## INS-03 Separación de contenido, lógica, persistencia e interfaz.

**Estado** Aprobado

**Requisitos** RNF-09

**Criterio** —

**Precondiciones y datos** Árbol lib de la app.

**Procedimiento** Revisar separación de contenido, dominio, almacenamiento e interfaz.

**Esperado** Separación de contenido, lógica, persistencia e interfaz.

**Obtenido** catalog.dart, course.dart, learning_controller.dart, progress_store.dart y ui/app.dart separados.

**Evidencia** inspecciones.md; lib/



## INS-04 Permisos de la app e inventario de autoría y licencias.

**Estado** Parcial

**Requisitos** RNF-08, RNF-11

**Criterio** —

**Precondiciones y datos** Manifiestos Android y dependencias del incremento.

**Procedimiento** Inspeccionar permisos main/debug/profile e inventario de recursos.

**Esperado** Permisos de la app e inventario de autoría y licencias.

**Obtenido** Main no declara permisos; debug/profile usan INTERNET para herramientas. No se completó inventario de autoría y licencias ni validación de distribución.

**Evidencia** inspecciones.md; android/app/src/; H-05



## VC-01 Validación del SRS v0.4 con la cliente (sesión del 14/10).

**Estado** Sin ejecutar

**Requisitos** Todos los RF

**Criterio** D-06

**Precondiciones y datos** Validación del SRS con la cliente pendiente.

**Procedimiento** Caso reservado a la sesión de validación; registrar decisión cuando ocurra.

**Esperado** Validación del SRS v0.4 con la cliente (sesión del 14/10).

**Obtenido** No se atribuyen firmas ni aprobación de requisitos.

**Evidencia** Matriz de auditoría v1.1; D-06



## VC-02 Sprint Review con la cliente: validación del incremento.

**Estado** Sin ejecutar

**Requisitos** RF-01 a RF-06, RNF-04, RNF-05

**Criterio** —

**Precondiciones y datos** Sprint Review con la cliente pendiente.

**Procedimiento** Presentar incremento y registrar aceptación o cambios.

**Esperado** Sprint Review con la cliente: validación del incremento.

**Obtenido** La ejecución automatizada no constituye aceptación de la cliente.

**Evidencia** Matriz de auditoría v1.1



## VC-03 La Guía de operación coincide con la aplicación real.

**Estado** Sin ejecutar

**Requisitos** ENT-02

**Criterio** —

**Precondiciones y datos** Guía de operación final fuera de esta entrega.

**Procedimiento** Comparar guía final contra app y validar instrucciones.

**Esperado** La Guía de operación coincide con la aplicación real.

**Obtenido** La guía demo existente no se declara validada como ENT-02.

**Evidencia** docs/GUIA_DEMO.md

