max_speed = 5;
towards_start = false;

with (objBoardSpaces) {
	if (space_begin) {
		other.towards_start_x = x + 16;
		other.towards_start_y = y + 16;
		break;
	}
}

follow_path = null;
space_stack = [];

function board_advance() {
	follow_path = path_add();
	var path_total = path_get_number(global.path_current);
	var current_x = path_get_point_x(global.path_current, global.path_number);
	var current_y = path_get_point_y(global.path_current, global.path_number);
	path_add_point(follow_path, current_x, current_y, 100);
	
	if (global.path_direction == 1) {
		var next_x = path_get_point_x(global.path_current, global.path_number + global.path_direction);
		var next_y = path_get_point_y(global.path_current, global.path_number + global.path_direction);
		path_add_point(follow_path, next_x, next_y, 100);	
		array_push(space_stack, {prev_path: global.path_current, prev_number: global.path_number, prev_x: current_x, prev_y: current_y});
		
		if (array_length(space_stack) > 10) {
			array_delete(space_stack, 0, 1);
		}
		
		global.path_number = (global.path_number + global.path_direction + path_total) % path_total;
	} else if (global.path_direction == -1) {
		var reverse = array_pop(space_stack);
		path_add_point(follow_path, reverse.prev_x, reverse.prev_y, 100);
		global.path_current = reverse.prev_path;
		global.path_number = reverse.prev_number;
	}
	
	path_set_closed(follow_path, false);
	path_start(follow_path, max_speed, path_action_stop, true);
}