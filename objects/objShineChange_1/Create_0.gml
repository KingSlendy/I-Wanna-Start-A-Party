event_inherited();

enum ShineChangeType {
	None,
	Get,
	Lose,
	Spawn,
	Exchange
}

spawned_shine = noone;
animation_type = ShineChangeType.None;
final_action = choose_shine;