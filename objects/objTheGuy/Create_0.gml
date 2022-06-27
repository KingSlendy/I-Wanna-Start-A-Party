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
alarm[0] = get_frames(1);

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
						objTheGuy.alarm[5] = get_frames(1);
					})
				]);
			
				objTheGuy.alarm[5] = 0;
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
shuffle_seed_inline();
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
					"I see you don't have any shine on you.",
					new Message("To compensate I'm gonna take a couple coins from you.",, function() {
						change_coins(-30, CoinChangeType.Lose);
						objTheGuy.alarm[5] = get_frames(1);
					})
				]);
			} else {
				start_dialogue([
					"You don't have shines, and I was gonna take coins away but apparently you're this bad at playing.",
					new Message("Here have a spare coin, play better.",, function() {
						change_coins(1, CoinChangeType.Gain);
						objTheGuy.alarm[5] = get_frames(1);
					})
				]);
			}
			
			objTheGuy.alarm[5] = 0;
			return;
		}
		
		change_shines(-1, ShineChangeType.Lose);
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
		
		objTheGuy.alarm[5] = 0;
		objTheGuy.alarm[9] = get_frames(1);
	}),
	
	new TheGuyOption(true, 0, "You {COLOR,00FFFF}get{COLOR,FFFFFF} {SPRITE,sprShine,0,0,-2,0.5,0.5}100", function() {
		with (objTheGuyHead) {
			snd = audio_play_sound(sndTheGuyNoNo, 0, false);
			image_speed = 1;
		}
		
		objTheGuyEye.image_speed = 1;
		objTheGuy.alarm[8] = get_frames(1.5);
		buffer_seek_begin();
		buffer_write_action(ClientUDP.NoNoTheGuy);
		network_send_udp_packet();
	})
];

array_shuffle(options);

function show_the_guy_options() {
	alarm[2] = 1;
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ShowTheGuyOptions);
		network_send_tcp_packet();
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
		objTheGuy.alarm[7] = get_frames(1);
	}
	
	follow_player = true;
	visible = false;
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.EndTheGuy);
		network_send_tcp_packet();
	}
}
