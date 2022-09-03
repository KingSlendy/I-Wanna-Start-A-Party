attack = image_index;
dir = 1;

function activate(image, network = false) {
	if (image_index == image_number - 1) {
		return;
	}
	
	with (object_index) {
		if (image_index == image) {
			alarm_frames(image, 10);
			
			if (!network) {
				buffer_seek_begin();
				buffer_write_action(ClientTCP.Minigame1vs3_Avoid_Block);
				buffer_write_data(buffer_u8, image);
				network_send_tcp_packet();
			}
		}
	
		image_index = image_number - 1;
		alarm_call(10, 2.4);
		alarm_call(11, 2);
	}
}

alarms_init(12);

alarm_create(function() {
	next_seed_inline();
	var rnd = irandom(359);

	for (var i = 0; i < 360; i += 360 / 28) {
		var a = instance_create_layer(400, 336, "Actors", objMinigame1vs3_Avoid_Cherry);
		a.image_index = attack;
		a.direction = i + rnd;
		a.speed = 6;
	}

	alarm_call(0, 0.55);
});

alarm_create(function() {
	next_seed_inline();
	var a = instance_create_layer(400, 576, "Actors", objMinigame1vs3_Avoid_Cherry);
	a.image_index = attack;
	a.hspeed = irandom_range(-3, 3);
	a.vspeed = irandom_range(-13, -7);
	a.gravity = 0.2;

	alarm_frames(1, 3);
});

alarm_create(function() {
	next_seed_inline();
	var a = instance_create_layer(768, 576, "Actors", objMinigame1vs3_Avoid_Cherry);
	a.image_index = attack;
	a.hspeed = choose(2, 4) * -1;
	a.vspeed = irandom_range(-10, -7);
	a.gravity = 0.2;

	var b = instance_create_layer(0, 576, "Actors", objMinigame1vs3_Avoid_Cherry);
	b.image_index = attack;
	b.hspeed = choose(2, 4);
	b.vspeed = irandom_range(-10, -7);
	b.gravity = 0.2;

	alarm_frames(2, 8);
});

alarm_create(function() {
	next_seed_inline();
	var a = instance_create_layer(0, irandom_range(160 + 16, 608 - 32 - 16), "Actors", objMinigame1vs3_Avoid_Cherry);
	a.image_index = attack;
	a.hspeed = irandom_range(4, 6);

	var b = instance_create_layer(800, irandom_range(160 + 16, 608 - 32 - 16), "Actors", objMinigame1vs3_Avoid_Cherry);
	b.image_index = attack;
	b.hspeed = irandom_range(4, 6) * -1;

	alarm_frames(3, 8);
});

alarm_create(10, function() {
	image_index = attack;
});

alarm_create(11, function() {
	for (var i = 0; i < 4; i++) {
		alarm_stop(i);
	}
});