event_inherited();
snd = sndItemGain;
image_xscale = 0;
image_yscale = 0;
used = false;

alarms_init(1);

alarm_create(function() {
	vspeed = -6;
});