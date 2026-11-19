<?php

define('CLI_SCRIPT', true);
require('/var/www/html/config.php');
require_once($CFG->libdir . '/clilib.php');
require_once($CFG->dirroot . '/course/lib.php');
require_once($CFG->dirroot . '/course/modlib.php');
require_once($CFG->dirroot . '/user/lib.php');
require_once($CFG->dirroot . '/lib/enrollib.php');
require_once($CFG->dirroot . '/mod/page/lib.php');
require_once($CFG->dirroot . '/mod/forum/lib.php');
require_once($CFG->dirroot . '/mod/assign/lib.php');

global $DB, $CFG;
$CFG->debug = DEBUG_DEVELOPER;
$CFG->debugdisplay = true;

$admin = get_admin();
$category = core_course_category::get_default();
$course = $DB->get_record('course', ['shortname' => 'SANLUQUITAS-PROGRAMACION'], '*', IGNORE_MISSING);

if (!$course) {
    $course = create_course((object) [
        'fullname' => 'Mis primeros pasos en programación',
        'shortname' => 'SANLUQUITAS-PROGRAMACION',
        'idnumber' => 'SANLUQUITAS-PROG-2026',
        'category' => $category->id,
        'summary' => 'Curso para 4.º y 5.º de primaria sobre secuencias, algoritmos y programación visual.',
        'summaryformat' => FORMAT_HTML,
        'format' => 'topics',
        'numsections' => 3,
        'visible' => 1,
    ]);
    echo "course_created={$course->id}\n";
} else {
    echo "course_existing={$course->id}\n";
}

$sectionids = [];
$sections = $DB->get_records('course_sections', ['course' => $course->id], 'section ASC');
foreach ($sections as $section) {
    $sectionids[(int) $section->section] = $section->id;
}
for ($number = 1; $number <= 3; $number++) {
    if (!isset($sectionids[$number])) {
        $section = course_create_section($course->id, $number);
        $sectionids[$number] = $section->id;
    }
}

foreach ([
    1 => 'Unidad 1: Pensamiento computacional, secuencias y patrones',
    2 => 'Unidad 2: Algoritmos cotidianos e instrucciones',
    3 => 'Unidad 3: Programación visual y Scratch',
] as $number => $name) {
    $DB->set_field('course_sections', 'name', $name, ['id' => $sectionids[$number]]);
}

function ensure_page(stdClass $course, int $section, string $name, string $content): void {
    global $DB;
    if ($DB->record_exists('page', ['course' => $course->id, 'name' => $name])) {
        return;
    }
    $moduleinfo = (object) [
        'modulename' => 'page',
        'module' => $DB->get_field('modules', 'id', ['name' => 'page']),
        'course' => $course->id,
        'section' => $section,
        'name' => $name,
        'intro' => '<p>Recurso educativo del curso San Luquitas Digital.</p>',
        'introformat' => FORMAT_HTML,
        'content' => $content,
        'contentformat' => FORMAT_HTML,
        'visible' => 1,
        'display' => 5,
        'coursemodule' => 0,
    ];
    add_moduleinfo($moduleinfo, $course);
}

ensure_page($course, 1, 'Secuencias y patrones', '<h3>Aprendemos a ordenar pasos</h3><p>Una secuencia es una lista de pasos en un orden. Buscá patrones en rutinas diarias y explicá qué ocurre si cambiamos el orden.</p>');
ensure_page($course, 2, 'Algoritmos cotidianos', '<h3>Instrucciones claras</h3><p>Escribí un algoritmo para preparar una merienda. Cada instrucción debe ser concreta, verificable y estar en el orden correcto.</p>');
ensure_page($course, 3, 'Programación visual con Scratch', '<h3>Bloques y eventos</h3><p>Explorá Scratch con personajes, eventos y repeticiones. Diseñá una animación corta usando al menos una secuencia y un ciclo.</p>');

if (!$DB->record_exists('forum', ['course' => $course->id, 'name' => 'Foro de ideas de programación'])) {
    add_moduleinfo((object) [
        'modulename' => 'forum',
        'module' => $DB->get_field('modules', 'id', ['name' => 'forum']),
        'course' => $course->id,
        'section' => 1,
        'name' => 'Foro de ideas de programación',
        'intro' => '<p>Compartí una situación cotidiana que pueda describirse como un algoritmo.</p>',
        'introformat' => FORMAT_HTML,
        'forumtype' => 'general',
        'assessed' => 0,
        'visible' => 1,
        'coursemodule' => 0,
    ], $course);
}

if (!$DB->record_exists('assign', ['course' => $course->id, 'name' => 'Tarea: mi algoritmo paso a paso'])) {
    add_moduleinfo((object) [
        'modulename' => 'assign',
        'module' => $DB->get_field('modules', 'id', ['name' => 'assign']),
        'course' => $course->id,
        'section' => 2,
        'name' => 'Tarea: mi algoritmo paso a paso',
        'intro' => '<p>Entregá un algoritmo cotidiano con mínimo cinco pasos y una explicación.</p>',
        'introformat' => FORMAT_HTML,
        'duedate' => time() + 1209600,
        'cutoffdate' => 0,
        'gradingduedate' => 0,
        'allowsubmissionsfromdate' => time(),
        'grade' => 100,
        'visible' => 1,
        'submissiondrafts' => 0,
        'requiresubmissionstatement' => 0,
        'sendnotifications' => 0,
        'sendlatenotifications' => 0,
        'sendstudentnotifications' => 1,
        'teamsubmission' => 0,
        'requireallteammemberssubmit' => 0,
        'blindmarking' => 0,
        'markingworkflow' => 0,
        'markingallocation' => 0,
        'attemptreopenmethod' => 'untilpass',
        'maxattempts' => -1,
        'coursemodule' => 0,
    ], $course);
}

$manual = enrol_get_plugin('manual');
$instances = enrol_get_instances($course->id, true);
$instance = null;
foreach ($instances as $candidate) {
    if ($candidate->enrol === 'manual') {
        $instance = $candidate;
        break;
    }
}

if (!$instance) {
    throw new moodle_exception('Manual enrolment instance was not found.');
}

$teacherrole = array_values(get_archetype_roles('teacher'))[0];
$studentrole = array_values(get_archetype_roles('student'))[0];

function ensure_user(string $username, string $firstname, string $lastname, string $email): int {
    global $DB;
    $existing = $DB->get_record('user', ['username' => $username, 'mnethostid' => 1], 'id', IGNORE_MISSING);
    if ($existing) {
        return (int) $existing->id;
    }
    $password = getenv('MOODLE_TEST_USER_PASSWORD');
    if (!$password) {
        throw new moodle_exception('MOODLE_TEST_USER_PASSWORD is required for new lab users.');
    }
    $user = (object) [
        'username' => $username,
        'password' => $password,
        'firstname' => $firstname,
        'lastname' => $lastname,
        'email' => $email,
        'auth' => 'manual',
        'confirmed' => 1,
        'mnethostid' => 1,
    ];
    return (int) user_create_user($user, false, false);
}

$teacher = ensure_user('docente_sanluquitas', 'Docente', 'San Luquitas', 'docente@sanluquitas.local');
$students = [
    ensure_user('estudiante_ana', 'Ana', 'López', 'ana@sanluquitas.local'),
    ensure_user('estudiante_bruno', 'Bruno', 'Gómez', 'bruno@sanluquitas.local'),
    ensure_user('estudiante_carla', 'Carla', 'Ruiz', 'carla@sanluquitas.local'),
];
$manual->enrol_user($instance, $teacher, $teacherrole->id);
foreach ($students as $student) {
    $manual->enrol_user($instance, $student, $studentrole->id);
}

echo "teacher=$teacher\n";
echo 'students=' . implode(',', $students) . "\n";
echo "content=3 pages, forum, assign\n";
