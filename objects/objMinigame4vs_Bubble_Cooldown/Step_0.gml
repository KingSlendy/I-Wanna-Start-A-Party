/// @desc Cooldown
if time < cooldown {
	bar_timeleft = min(time / cooldown, 1);
	time++;
}
else {
	instance_destroy();	
}