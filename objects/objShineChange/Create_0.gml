event_inherited();

enum ShineChangeType {
	None,
	Get,
	Lose,
	Spawn
}

spawned_shine = null;
animation_type = ShineChangeType.None;
final_action = choose_shine;