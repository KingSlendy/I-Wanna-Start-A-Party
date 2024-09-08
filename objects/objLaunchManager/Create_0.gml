if (instance_number(object_index) > 1) {
	instance_destroy();
	exit;
}

text = "";

alarms_init(1);

alarm_create(function() {
	game_end();
});

var param = parameter_string(1);

if (param == "-game" || param == "-launch") {
	room_goto_next();
	exit;
}

text = language_get_text("LAUNCH_NOT_DETECTED");
alarm_call(0, 3);