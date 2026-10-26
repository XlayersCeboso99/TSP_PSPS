# Corrección del defecto D-S1-03: «En progreso» con el mismo ícono que «Sin iniciar» en «Mi progreso»

Responsable: Pablo Valentín Varela Rivera. Entrega técnica: 26/10/2026. Rama: fix/D-S1-03-iconos-progreso. Base: COMMIT_BASE; aplicación Flutter 0.2.0-dev.2+3.

## 1. Defecto

| Dato | Registro |
| --- | --- |
| ID | D-S1-03 |
| Requisito | RNF-05; CA-04 ampliado (SRS v0.1 §2) |
| Evidencia | Revisión del código del Sprint 01 (registro de corrección de defectos del 22/10). |
| Actividad | IDs 33 y 40 del PSR, T07 / SI.04.02 (planeada 21 y 22/10/2026, 3.00 h estimadas para los cinco defectos). Horas reales pendientes de registrar por Pablo. |
| Verifica | Sebastián Guerra Hernández, ID 61 del PSR (27/10/2026). |

En la lista de temas de «Mi progreso», un tema en progreso mostraba el mismo círculo vacío que uno sin iniciar; solo cambiaba el color.

## 2. Causa

La lista solo distinguía completado / no completado al elegir el ícono.

## 3. Corrección

- Nueva función statusIcon() en lib/ui/app.dart: círculo (sin iniciar), reloj (en progreso) y palomita (completado).
- StatusBadge y la lista de «Mi progreso» usan la misma función, así ambos muestran el mismo ícono por estado.

Archivos, relativos a Sprint 2/psps_academy:

- lib/ui/app.dart (statusIcon, StatusBadge y «Mi progreso»)
- test/fix_ds103_iconos_progreso_test.dart (nuevo)

## 4. Pruebas

Ejecutable: psps_academy/test/fix_ds103_iconos_progreso_test.dart.

| ID | Nivel | Resultado esperado | Estado |
| --- | --- | --- | --- |
| DS103-01 | Lógica | Cada estado tiene un ícono distinto. | ESTADO |
| DS103-02 | Widget | Las insignias usan el mismo ícono que las listas. | ESTADO |
| DS103-03 | Widget | En «Mi progreso»: círculo, reloj y palomita, con su texto, para los tres estados. | ESTADO |

| Verificación | Resultado y ubicación |
| --- | --- |
| Análisis | RESULTADO_ANALISIS. Sprint 2/Defectos/D-S1-03/analisis.log. |
| Pruebas del defecto | RESULTADO_DEFECTO de 3. Sprint 2/Defectos/D-S1-03/pruebas.log. |
| Regresión completa | RESULTADO_REGRESION. Sprint 2/Defectos/D-S1-03/regresion.log. |

## 5. Verificación (ID 61, Sebastián)

En «Mi progreso», un tema con una pregunta respondida muestra el ícono de reloj y el texto «En progreso».

Pendientes: verificación por Sebastián, revisión del pull request por una persona distinta del autor, integración y registro de horas reales. No se modifican firmas, aceptación de la cliente ni estados del PSR.
