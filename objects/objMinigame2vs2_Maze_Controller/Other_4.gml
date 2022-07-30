event_inherited();
next_seed_inline();
maze_width = 19;
maze_height = 16;
maze = null;

for (var r = -1; r < maze_height * 2; r++) {
    for (var c = -1; c < maze_width * 2; c++) {
		var b = instance_create_layer(x + 32 * c, y + 32 * r, "Collisions", objBlock);
        b.visible = true;
        b.sprite_index = sprite_index;
	}
}

for (var r = 0; r < maze_height; r++) {
    for (var c = 0; c < maze_width; c++) {
        maze[r, c] = [];
    }
}

var row = irandom(maze_height - 1);
var col = irandom(maze_width - 1);
directions = [
    [-1, 0],
    [0, 1],
    [0, -1],
    [1, 0],
];

var cells = [[row, col]];
check_adjacent = function(r, c) {
	return (r >= 0 && r < maze_height && c >= 0 && c < maze_width && array_length(maze[r, c]) == 0);
}

var check_neighbors = function(r, c) {
	var neighbors = [];
	
	for (var i = 0; i < 4; i++) {
		var dir = directions[i];
		
		if (check_adjacent(r + dir[0], c + dir[1])) {
			array_push(neighbors, i);
		}
	}
	
	return neighbors;
}

while (true) {
	if (array_length(cells) == 0) {
		break;
	}
	
	var index = (irandom(1) == 0) ? 0 : array_length(cells) - 1;
	var cell = cells[index];
	var row = cell[0];
	var col = cell[1];
	var neighbors = check_neighbors(row, col);
	
	if (array_length(neighbors) == 0) {
		array_delete(cells, index, 1);
		continue;
	}
	
	array_shuffle(neighbors);
	var neighbor = neighbors[0];
	var next = directions[neighbor];
	var next_row = row + next[0];
	var next_col = col + next[1];
	array_push(maze[row, col], neighbor);
	array_push(maze[next_row, next_col], 3 - neighbor);
	array_push(cells, [next_row, next_col]);
}

for (var r = 0; r < maze_height; r++) {
    for (var c = 0; c < maze_width; c++) {
        instance_destroy(instance_place(x + 32 * (c * 2), y + 32 * (r * 2), objBlock));
        
        var current = maze[r, c];
        
        for (var i = 0; i < array_length(current); i++) {
            if (current[i] == -1) {
                break;
            }
        
            var d = directions[current[i]]; 
            instance_destroy(instance_place(x + 32 * (c * 2) + (32 * d[1]), y + 32 * (r * 2) + (32 * d[0]), objBlock));
        }
    }
}

grid = mp_grid_create(0, 0, room_width / 32, room_height / 32, 32, 32);
mp_grid_add_instances(grid, objBlock, false);

with (objPlayerBase) {
	path = path_add();
	move_delay_timer = 0;
	jump_delay_timer = 0;
	xstart = x;
	ystart = y;
}

objCameraSplit4.boundaries = true;