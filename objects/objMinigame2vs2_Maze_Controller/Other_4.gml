event_inherited();
next_seed_inline();
maze_width = 10;
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
    for (var c = 0; c < maze_width ; c++) {
        maze[r][c] = [];
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
	
	//var index = (irandom(1) == 0) ? 0 : array_length(cells) - 1;
	var index = irandom(array_length(cells) - 1);
	var cell = cells[index];
	var row = cell[0];
	var col = cell[1];
	var neighbors = check_neighbors(row, col);
	
	if (array_length(neighbors) == 0) {
		array_delete(cells, index, 1);
		continue;
	}
	
	array_shuffle_ext(neighbors);
	var neighbor = neighbors[0];
	var next = directions[neighbor];
	var next_row = row + next[0];
	var next_col = col + next[1];
	array_push(maze[row][col], neighbor);
	array_push(maze[next_row][next_col], 3 - neighbor);
	array_push(cells, [next_row, next_col]);
}

//Destroys the blocks and carves the maze
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

//Destroys all the blocks from the rightmost wall of the half maze
for (var r = -1; r < (maze_height * 2); r++) {
	instance_destroy(instance_place(x + 32 * ((maze_width * 2) - 1), y + 32 * r, objBlock));
}

//Copies the blocks and mirrors them symmetrically
var current_block_x = room_width - 32;

while (true) {
	if (place_meeting(current_block_x, 0, objBlock)) {
		break;
	}
	
	for (var r = 0; r < room_height; r += 32) {
		if (place_meeting(room_width - current_block_x - 32, r, objBlock)) {
			var b = instance_create_layer(current_block_x, r, "Collisions", objBlock);
		    b.visible = true;
		    b.sprite_index = sprite_index;
		}
	}
	
	current_block_x -= 32;
}

grid = mp_grid_create(0, 0, room_width / 32, room_height / 32, 32, 32);
mp_grid_add_instances(grid, objBlock, false);

with (objPlayerBase) {
	path = path_add();
}

objCameraSplit4.boundaries = true;

if (trial_is_title(CHALLENGE_MEDLEY)) {
	with (objPlayerBase) {
		if (network_id != global.player_id) {
			y = -64;
		}
	}
	
	with (objMinigame2vs2_Maze_Item) {
		image_blend = c_blue;
		
		do {
			x = 32 * irandom(room_width / 32);
			y = 32 * irandom(room_height / 32);
		} until (!place_meeting(x, y, objBlock) && !place_meeting(x, y, objPlayerBase) && distance_to_object(objPlayerBase) >= 192);
	}
}