depth = -9003;
fade_alpha = 0;
surf = noone;
draw_surf = false;
broken_sprite = noone;
broken_x = 400;
broken_y = 304;
broken_hspd = 0;
broken_vspd = 0;
broken_grav = 0;
music_fade();

prev_player_positions = store_player_positions();
rotate_turn = true;
follow_player = true;

function TheGuyOption(only_me, amount, text = "", action = null) constructor {
	self.only_me = only_me;
	self.text = text;
	self.amount = amount;
	
	if (self.text == "") {
		self.text += (self.only_me) ? "You " : "All of you ";
		self.text += "{COLOR,0000FF}lose{COLOR,FFFFFF} " + draw_coins_price(self.amount);
	} else {
		self.text = text;
	}
	
	if (action == null) {
		self.action = function() {
			if (self.only_me && player_info_by_turn().coins == 0) {
				start_dialogue([
					"What!? You don't even have coins!?",
					new Message("Let's see if this makes you feel like you're good at playing.",, function() {
						change_coins(30, CoinChangeType.Gain);
						
						with (objTheGuy) {
							alarm_call(5, 1);
						}
					})
				]);
			
				with (objTheGuy) {
					alarm_stop(5);
				}
				return;
			}
			
			for (var i = 1; i <= global.player_max; i++) {
				if (!self.only_me || i == global.player_turn) {
					change_coins(-self.amount, CoinChangeType.Lose, i);
				}
			}
		}
	} else {
		self.action = action;
	}
}

options_total = 5;
options_fade = -1;
options_alpha = 0;
options_width = 300;
options_height = 40;
options_timer = 3;
options_dir = 1;
shuffle_seed_bag();
reset_seed_inline();
options_chosen = irandom(options_total - 1);
global.choice_selected = irandom(options_total - 1);
options = [
	new TheGuyOption(true, 10,,),
	new TheGuyOption(true, 15,,),
	new TheGuyOption(true, 20,,),
	new TheGuyOption(true, 30,,),
	new TheGuyOption(false, 10,,),
	new TheGuyOption(false, 25,,),
	new TheGuyOption(true, ceil(player_info_by_turn().coins / 2), "You {COLOR,0000FF}lose{COLOR,FFFFFF} half {SPRITE,sprCoin,0,0,2,0.6,0.6}"),
	
	new TheGuyOption(true, 0, "You {COLOR,0000FF}lose{COLOR,FFFFFF} {SPRITE,sprShine,0,0,-2,0.5,0.5}1", function() {
		var player_info = player_info_by_turn();
		
		if (player_info.shines == 0) {
			if (player_info.coins > 0) {
				start_dialogue([
					"I see you don't have a shine on you.",
					new Message("To compensate I'm gonna take a couple coins instead.",, function() {
						change_coins(-30, CoinChangeType.Lose);
						
						with (objTheGuy) {
							alarm_call(5, 1);
						}
					})
				]);
			} else {
				start_dialogue([
					"You don't have shines, and I was gonna take coins away but apparently you're this bad at playing.",
					new Message("Here have a spare coin, play better.",, function() {
						change_coins(1, CoinChangeType.Gain);
						
						with (objTheGuy) {
							alarm_call(5, 1);
						}
						
						if (focused_player().network_id == global.player_id) {
							gain_trophy(54);
						}
					})
				]);
			}
			
			with (objTheGuy) {
				alarm_stop(5);
			}
			
			return;
		}
		
		change_shines(-1, ShineChangeType.Lose).final_action = null;
	}),
	
	new TheGuyOption(false, 0, "{COLOR,0000FF}The Guy{COLOR,FFFFFF} revolution", function() {
		total_coins = 0;
		
		for (var i = 1; i <= global.player_max; i++) {
			total_coins += player_info_by_turn(i).coins;
		}
		
		total_coins = floor(total_coins / 4);
		
		for (var i = 1; i <= global.player_max; i++) {
			change_coins(-999, CoinChangeType.Lose, i);
		}
		
		with (objTheGuy) {
			alarm_stop(5);
		}
		
		with (objTheGuy) {
			alarm_call(9, 1);
		}
	}),
	
	new TheGuyOption(true, 0, "You {COLOR,00FFFF}get{COLOR,FFFFFF} {SPRITE,sprShine,0,0,-2,0.5,0.5}100", function() {
		nono_the_guy();
		
		with (objTheGuy) {
			alarm_stop(5);
		}
		
		with (objTheGuy) {
			alarm_call(8, 1.5);
		}
		
		if (focused_player().network_id == global.player_id) {
			gain_trophy(30);
		}
	})
];

array_shuffle(options);

function show_the_guy_options() {
	alarm_frames(2, 1);
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ShowTheGuyOptions);
		network_send_tcp_packet();
	}
}

function nono_the_guy() {
	with (objTheGuyHead) {
		snd = audio_play_sound(sndTheGuyNoNo, 0, false);
		image_speed = 1;
	}
		
	objTheGuyEye.image_speed = 1;
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientUDP.NoNoTheGuy);
		network_send_udp_packet();
	}
}

function end_the_guy() {
	with (objPlayerBase) {
		change_to_object(objPlayerBoard);
	}
	
	var focus_player = focused_player();
	
	for (var i = 1; i <= global.player_max; i++) {
		var player = focus_player_by_turn(i);
		var prev_pos = prev_player_positions[i - 1];
		player.x = prev_pos.x;
		player.y = prev_pos.y;
	}
	
	switch_camera_target(focus_player.x, focus_player.y).final_action = function() {
		music_fade();

		with (objTheGuy) {
			alarm_call(7, 1);
		}
	}
	
	follow_player = true;
	visible = false;
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.EndTheGuy);
		network_send_tcp_packet();
	}
}

alarms_init(10);

alarm_create(function() {
	audio_play_sound(sndTheGuyIntro, 0, false);
	alarm_call(1, 2.6);
});

alarm_create(function() {
	music_pause();
	music_change(bgmTheGuy);
	var view_x = camera_get_view_x(view_camera[0]);
	var view_y = camera_get_view_y(view_camera[0]);
	instance_create_layer(view_x + 380, view_y + 284, "Actors", objTheGuyHead);
	follow_player = false;
	draw_surf = true;

	var broken_surf = surface_create(800, 608);
	surface_set_target(broken_surf);
	draw_sprite(sprTheGuyBroken, 0, 400, 304);
	gpu_set_colorwriteenable(true, true, true, false);
	draw_surface(application_surface, 0, 0);
	//draw_set_alpha(fade_alpha);
	//draw_set_color(c_black);
	//draw_rectangle(0, 0, 800, 608, false);
	//draw_set_alpha(1);
	gpu_set_colorwriteenable(true, true, true, true);
	surface_reset_target();
	broken_sprite = sprite_create_from_surface(broken_surf, 0, 0, 800, 608, false, false, 400, 304);
	surface_free(broken_surf);

	broken_hspd = irandom_range(-4, 4);
	broken_vspd = irandom_range(-6, -4);
	broken_grav = 0.5;
});

alarm_create(function() {
	options_fade = 0;
});

alarm_create(function() {
	global.choice_selected = (global.choice_selected + options_dir + options_total) % options_total;
	audio_play_sound(sndRouletteRoll, 0, false);

	if (options_dir == 1) {
		options_timer += 0.10;
	
		if (options_timer > 6 && irandom(10) == 0) {
			options_timer = 5;
			options_dir = -1;
		
			with (objTheGuyHead) {
				snd = audio_play_sound(sndTheGuyEscape, 0, false);
			}
		
			alarm_call(3, random_range(0.75, 1.5));
			return;
		}
	} else {
		if (irandom(1) == 0 && global.choice_selected == options_chosen) {
			alarm_call(6, 1);
			return;
		}
	}

	alarm_frames(3, floor(options_timer));
});

alarm_create(function() {
	if (is_local_turn()) {
		with (objTheGuy) {
			alarm_call(5, 1);
		}
			
		options[global.choice_selected].action();
	}
});

alarm_create(function() {
	if (!alarm_is_stopped(8)) {
		return;
	}

	if (instance_exists(objStatChange)) {
		alarm_frames(5, 1);
		return;
	}

	objTheGuyHead.snd = audio_play_sound(sndTheGuyCrushBones, 0, false);

	if (is_local_turn()) {
		start_dialogue([
			new Message("Hope you think twice before landing on my space again.",, end_the_guy)
		]);
	
		buffer_seek_begin();
		buffer_write_action(ClientUDP.CrushTheGuy);
		network_send_udp_packet();
	}
});

alarm_create(function() {
	options_fade = 1;
});

alarm_create(function() {
	music_stop();
	music_resume();
	audio_sound_gain(global.music_current, 1, 0);

	if (rotate_turn) {
		turn_next();
	}

	instance_destroy(objTheGuyHead);
	instance_destroy(objTheGuyEye);
	instance_destroy();
});

alarm_create(function() {
	end_the_guy();
});

alarm_create(function() {
	if (!alarm_is_stopped(8)) {
		return;
	}

	if (instance_exists(objStatChange)) {
		alarm_frames(9, 1);
		return;
	}

	for (var i = 1; i <= global.player_max; i++) {
		change_coins(total_coins, CoinChangeType.Gain, i);
	}
		
	alarm_frames(5, 1);
});

alarm_call(0, 1);