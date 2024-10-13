event_inherited();
box_activate = open_chest;
image_speed = 0;
player = focused_player();
player.has_hit = false;
controls_text = new Text(global.fntControls);

alarms_init(1);

alarm_create(function() {
	if (is_local_turn()) {
		var has_used_medal = (player_info_by_turn().item_used == ItemType.Medal);
		var action = (!has_used_medal) ? turn_next : hide_chest;
		var chances = (!has_used_medal) ? 0.1 : 0.2;
		
		if (chance(chances)) {
			change_shines(1, ShineChangeType.Spawn).final_action = action;
		
			if (player.network_id == global.player_id) {
				achieve_trophy(4);
			}
		} else {
			var coin_amount = irandom_range(10, 20);
			
			if (has_used_medal) {
				coin_amount *= 2;
			}
			
			change_coins(coin_amount, CoinChangeType.Gain).final_action = action;
		}
	}
});