<?php

define('CLI_SCRIPT', true);
require('/var/www/html/config.php');

global $DB;
$course = $DB->get_record('course', ['shortname' => 'SANLUQUITAS-PROGRAMACION'], '*', MUST_EXIST);
$sections = max(0, $DB->count_records('course_sections', ['course' => $course->id]) - 1);
$pages = $DB->count_records('page', ['course' => $course->id]);
$forums = $DB->count_records('forum', ['course' => $course->id]);
$assignments = $DB->count_records('assign', ['course' => $course->id]);

echo "course={$course->fullname}\n";
echo "sections=$sections pages=$pages forums=$forums assignments=$assignments\n";

$users = $DB->get_records_sql(
    "SELECT DISTINCT u.username, r.shortname
       FROM {user} u
       JOIN {user_enrolments} ue ON ue.userid = u.id
       JOIN {enrol} e ON e.id = ue.enrolid
       JOIN {role_assignments} ra ON ra.userid = u.id
       JOIN {context} cx ON cx.id = ra.contextid AND cx.contextlevel = 50 AND cx.instanceid = ?
       JOIN {role} r ON r.id = ra.roleid
      WHERE e.courseid = ? AND u.username <> ?
      ORDER BY u.username",
    [$course->id, $course->id, 'admin']
);
foreach ($users as $user) {
    echo "user={$user->username} role={$user->shortname}\n";
}

if ($sections < 3 || $pages < 3 || $forums < 1 || $assignments < 1 || count($users) < 4) {
    exit(1);
}
echo "PASS: curso, tres unidades, recursos, foro, tarea y roles verificados.\n";
