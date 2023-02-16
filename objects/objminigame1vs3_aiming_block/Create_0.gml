hspd = 0;
max_hspd = 1;

function move_block() {
	xprevious = x;
	x += hspd;

	var block_check = function(x, y) {
		return (place_meeting(x, y, objBlock) || place_meeting(x, y, object_index));
	}
	
	if (block_check(x, y)) {
		x = xprevious;
		
		if (block_check(x + hspd, y)) {
			while (!block_check(x + sign(hspd), y)) {
				x += sign(hspd);
			}
			
			hspd = 0;
		}
	}
}

alarms_init(1);

alarm_create(function() {
	next_seed_inline();
	var prev_hspd = hspd;
	
	do {
		hspd = choose(-max_hspd, 0, max_hspd);
	} until (hspd != prev_hspd);
	
	alarm_call(0, random_range(1, 2));
});

if (!is_player) {
	alarm_call(0, 1);
}