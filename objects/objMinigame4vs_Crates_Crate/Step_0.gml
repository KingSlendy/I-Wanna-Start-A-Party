if (is_player_local(network_id) && crate_can_smash() && focus_player_by_id(network_id).spinning) {
	crate_smash();
	exit;
}

yprevious = y;

vspd += grav;
x += hspd;
y += vspd;

if (place_meeting(x, y, objBlock)) {
	y = yprevious;
	
	if (place_meeting(x, y + vspd, objBlock)) {
		while (!place_meeting(x, y + sign(vspd), objBlock)) {
			y += sign(vspd);
		}
		
		vspd = 0;
		grav = 0;
	}
}

if (!outside && x > room_width) {
	event_perform(ev_destroy, 0);
	hspd = 0;
	outside = true;
	
	if (sprite_index == sprMinigame4vs_Crates_Crate && network_id == global.player_id) {
		objMinigameController.trophy_crates = false;
	}
}