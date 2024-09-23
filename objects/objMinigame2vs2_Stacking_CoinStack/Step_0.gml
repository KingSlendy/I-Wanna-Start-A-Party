vspd += grav;
x += hspd;
y += vspd;

if (!objMinigameController.info.is_finished && stacked_id == null) {
	var coin = instance_place_any(x, y, objMinigame2vs2_Stacking_CoinStack, function(o) {
		if (o.stacked_id == null || o.stacked_falling) {
			return false;
		}
		
		var stack = o.stacked_id.coin_line_stack;
		return (o.id == stack[array_length(stack) - 1]);
	});

	if (coin != noone && is_player_local(coin.stacked_id.network_id)) {
		coin_line_stack_add(coin.stacked_id.network_id);

		var add_velocity = 0;

		if (x + sprite_width / 2 >= coin.stacked_id.x) {
			add_velocity = -0.1;	
		} else if (x + sprite_width / 2 < coin.stacked_id.x) {
			add_velocity = 0.1;
		}
	
		if (add_velocity != 0) {
			do {
				coin.stacked_id.coin_line_stack_velocity += add_velocity;
			} until (coin.stacked_id.coin_line_stack_velocity != 0);
		}
	}
}