// Oráculos literales del formato de TSP_PSPS develop@ebcbccd (Sprint 2).
// No se generan con los modelos ni con el catálogo de Sprint 3.
// Origen de los campos/orden JSON:
// - Sprint 2/psps_academy/lib/data/progress_store.dart:32-44,92,102-103.
// - Sprint 2/psps_academy/lib/data/notes_store.dart:26,57-72 (fechas UTC).
// - Sprint 2/psps_academy/lib/data/reminder_store.dart:33-39,75,88-92.
// IDs e índices de respuesta: lib/data/catalog.dart:5-41,44-369 del Sprint 2;
// logros/temas: lib/domain/gamification.dart:83-173 del mismo origen.
// Son datos sintéticos válidos que ese código puede escribir, no una copia
// de datos personales. tool/verifications/tsp_sprint2_fixture_origin_test.dart
// verifica los bytes con los escritores originales y su controlador real.

const tspProgressKey = 'psps.progress.v1';
const tspNotesKey = 'psps.notes.v1';
const tspReminderKey = 'psps.reminder.v1';
const tspDate = '2026-11-05T18:42:03.125Z';

const tspCompleteProgress =
    '{"version":3,"answers":{'
    '"CT-01.s1.q1":1,"CT-01.s1.q2":2,'
    '"CT-02.s1.q1":0,"CT-02.s1.q2":1,'
    '"CT-03.s1.q1":1,"CT-03.s1.q2":2,'
    '"CT-04.s1.q1":0,"CT-04.s1.q2":1,'
    '"CT-06.s1.q1":1,"CT-06.s1.q2":2,'
    '"CT-07.s1.q1":0,"CT-07.s1.q2":1,'
    '"CT-08.s1.q1":1,"CT-08.s1.q2":2,'
    '"CT-05.s1.q1":0,"CT-05.s1.q2":1,'
    '"CT-09.s1.q1":1,"CT-09.s1.q2":2,'
    '"CT-10.s1.q1":2,"CT-10.s1.q2":0},'
    '"practices":{'
    '"CT-01.a1":[0,1,2],"CT-02.a1":[0,1,2],'
    '"CT-03.a1":[0,1,2],"CT-04.a1":[0,1,2],'
    '"CT-06.a1":[0,1,2],"CT-07.a1":[0,1,2],'
    '"CT-08.a1":[0,1,2],"CT-05.a1":[0,1,2],'
    '"CT-09.a1":[0,1,2],"CT-10.a1":[0,1,2]},'
    '"reviewAnswers":{},"points":100,"rewardedPractices":['
    '"CT-01.a1","CT-02.a1","CT-03.a1","CT-04.a1","CT-06.a1",'
    '"CT-07.a1","CT-08.a1","CT-05.a1","CT-09.a1","CT-10.a1"],'
    '"achievements":{'
    '"L-01":"$tspDate","L-02":"$tspDate","L-03":"$tspDate",'
    '"L-04":"$tspDate","L-05":"$tspDate","L-06":"$tspDate",'
    '"L-07":"$tspDate","L-08":"$tspDate","L-09":"$tspDate",'
    '"L-11":"$tspDate"},"selectedTheme":"U-03"}';

// Primera respuesta incorrecta, repaso resuelto y aún pendiente, una actividad
// completa, un borrador y un orden completo incorrecto. L-02 era válido con
// las dos preguntas originales de CT-01 y debe conservarse con su fecha.
// L-03 null es escribible tras recuperar un estado anterior y actuar después.
const tspMixedProgress =
    '{"version":3,"answers":{'
    '"CT-01.s1.q1":0,"CT-01.s1.q2":2,'
    '"CT-02.s1.q1":1,"CT-03.s1.q1":1},'
    '"practices":{"CT-01.a1":[0,1,2],"CT-02.a1":[0],'
    '"CT-03.a1":[2,1,0]},'
    '"reviewAnswers":{"CT-01.s1.q1":1,"CT-02.s1.q1":2},'
    '"points":10,"rewardedPractices":["CT-01.a1"],'
    '"achievements":{"L-01":"$tspDate","L-02":"$tspDate","L-03":null},'
    '"selectedTheme":"U-01"}';

const tspNotes =
    '{"version":1,"notes":{'
    '"CT-01.s1":{"text":"Fila y columna: ñ, á, 😀\\nmatriz[1][0] → 2",'
    '"modifiedAt":"$tspDate"},'
    '"CT-02.s1":{"text":"Push / pop","modifiedAt":"$tspDate"},'
    '"CT-03.s1":{"text":"FIFO","modifiedAt":"$tspDate"},'
    '"CT-04.s1":{"text":"Comparar vecinos","modifiedAt":"$tspDate"},'
    '"CT-06.s1":{"text":"try / catch / finally","modifiedAt":"$tspDate"},'
    '"CT-07.s1":{"text":"Extender el contrato","modifiedAt":"$tspDate"},'
    '"CT-08.s1":{"text":"Clase e instancia","modifiedAt":"$tspDate"},'
    '"CT-05.s1":{"text":"INSERT / UPDATE / SELECT","modifiedAt":"$tspDate"},'
    '"CT-09.s1":{"text":"Muchos a muchos","modifiedAt":"$tspDate"},'
    '"CT-10.s1":{"text":"  Conservar espacios  ","modifiedAt":"$tspDate"}}}';

const tspEnabledReminder =
    '{"version":1,"enabled":true,"hour":23,"minute":59,"weekdays":[1,4,7]}';
const tspDisabledReminder =
    '{"version":1,"enabled":false,"hour":0,"minute":0,"weekdays":[]}';
