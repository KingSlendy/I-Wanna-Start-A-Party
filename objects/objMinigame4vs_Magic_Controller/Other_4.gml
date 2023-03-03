event_inherited();

instance_create_layer(0, 0, "Managers", objMinigame4vs_Magic_Intro, {
	depth: self.depth - 1
});

layer_set_visible("Curtains", true);

with (objCameraSplit4) {
	lock_x = true;
	lock_y = true;
	boundaries = true;
}