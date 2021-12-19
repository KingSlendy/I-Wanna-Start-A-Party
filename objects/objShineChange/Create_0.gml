enum ShineChangeType {
	None,
	Get,
	Lose,
	Spawn
}

player_id = 0;
amount = 0;
animation_type = ShineChangeType.None;
animation_amount = 0;
animation_alpha = 0;
animation_state = 0;
final_action = choose_shine;
spawned_shine = null;
alarm[0] = 1;