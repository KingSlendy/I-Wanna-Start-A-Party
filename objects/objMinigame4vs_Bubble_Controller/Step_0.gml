ds_priority_clear(priority);

with (objPlayerBase) {
	var next_num = (goal_num + other.goal_total + 1) % other.goal_total;
	var next_goal = null;
	
	with (objMinigame4vs_Bubble_Goal) {
		if (num == next_num) {
			next_goal = id;
			break;
		}
	}
	
	ds_priority_add(other.priority, network_id, (other.lap_total - other.info.player_scores[network_id - 1].points) * 10000 + (other.goal_total - goal_num) * 1000 + distance_to_object(next_goal));
}

ds_map_clear(places);
var place = global.player_max;

while (!ds_priority_empty(priority)) {
	places[? ds_priority_delete_max(priority)] = place--;
}