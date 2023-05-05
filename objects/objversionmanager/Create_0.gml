if (instance_number(object_index) > 1) {
	instance_destroy(id, false);
	exit;
}

text = language_get_text("VERSION_CHECK");
version = "";
tag = http_get("https://github.com/KingSlendy/I-Wanna-Start-A-Party/releases/latest");
file = null;
downloading = false;
size = 0;
sent = 0;

function occurred_error() {
	text = language_get_text("VERSION_ERROR");
	downloading = false;
	alarm_call(0, 3);
}

alarms_init(3);

alarm_create(function() {
	instance_destroy();
});

alarm_create(function() {
	game_end();
});

alarm_create(function() {
	text = language_get_text("VERSION_TIMEOUT");
	downloading = false;
	alarm_call(0, 3);
});

alarm_call(2, 15);