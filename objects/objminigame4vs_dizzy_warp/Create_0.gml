depth = layer_get_depth("Tiles") - 1;
actions = ["left", "right", "up", "down", "jump"];
touched = false;
trophy = false;

alarms_init(1);

alarm_create(function() {
	touched = false;
});