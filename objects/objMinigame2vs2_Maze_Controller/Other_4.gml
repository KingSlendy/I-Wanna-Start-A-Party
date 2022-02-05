player_positioning_2vs2(info);
camera_2vs2_split4(camera_start(objCameraSplit4), info);
player_2vs2_teammate(info);

var cells = [];
var maze_width = 19;
var maze_height = 16;
var maze;

for (var r = -1; r < maze_height * 2; r++) {
    for (var c = -1; c < maze_width * 2; c++) {
		var b = instance_create_layer(x + 32 * c, y + 32 * r, "Collisions", objBlock);
        b.visible = true;
        b.sprite_index = sprMinigame2vs2_Maze_Block;
	}
}

for (var r = 0; r < maze_height * 2 - 1; r++) {
    for (var c = 0; c < maze_width * 2 - 1; c++) {
        maze[r, c] = [];
    }
}

var row = 0;
var col = 0;
var directions = [
    [-1, 0],
    [0, 1],
    [0, -1],
    [1, 0],
];

var finished = false;
array_push(cells, [row, col]);

while (true) {
    var choice = -1;
	var adjacent = false;

    while (!adjacent) {
        if (choice != -1) {
			if (array_length(maze[row, col]) == 0) {
				array_push(maze[row, col], -1);
			}
			
			array_delete(cells, choice, 1);
		}
		
        if (array_length(cells) == 0) {
			finished = true;
			break;
		}

        choice = (irandom(1) == 0) ? 0 : array_length(cells) - 1;
        var cell = cells[choice];
		row = cell[0];
		col = cell[1];
		
		adjacent = false;
		
        for (var i = 0; i < 4; i++) {
	        var d = directions[i];
        
	        if (row + d[0] > -1 && row + d[0] < maze_height && col + d[1] > -1 && col + d[1] < maze_width && array_length(maze[row + d[0], col + d[1]]) == 0) {
	            adjacent = true;
	            break;
	        }    
	    }
    }

	if (finished) {
		break;
	}

    var pr = row;
    var pc = col;
    var rnd = irandom(3);
    
    for (var i = 0; i < 4; i++) {
        var n = (i + rnd) % 4;
        var d = directions[n];
            
        if (row + d[0] > -1 && row + d[0] < maze_height && col + d[1] > -1 && col + d[1] < maze_width && array_length(maze[row + d[0], col + d[1]]) == 0) {
            row += d[0];
            col += d[1];
            break;
        }    
    }
        
	array_push(maze[pr, pc], n);
	array_push(cells, [row, col]);
}

/*while (array_length(cells) > 0) {
    var adjacent = false;
    
    for (var i = 0; i < 4; i++) {
        var d = directions[i];
        
        if (row + d[0] > -1 && row + d[0] < maze_height && col + d[1] > -1 && col + d[1] < maze_width && array_length(maze[row + d[0], col + d[1]]) == 0) {
            adjacent = true;
            break;
        }    
    }
    
    if (adjacent) {
        var pr = row;
        var pc = col;
        var rnd = irandom(3);
    
        for (var i = 0; i < 4; i++) {
            var n = (i + rnd) % 4;
            var d = directions[n];
            
            if (row + d[0] > -1 && row + d[0] < maze_height && col + d[1] > -1 && col + d[1] < maze_width && array_length(maze[row + d[0], col + d[1]]) == 0) {
                row += d[0];
                col += d[1];
                break;
            }    
        }
        
		array_push(maze[pr, pc], n);
		array_push(cells, [row, col]);
    } else {
        if (array_length(maze[row, col]) == 0) {
            array_push(maze[row, col], -1);
        }
    
        var current = array_pop(cells);
        row = current[0];
        col = current[1];
    }
}*/

for (var r = 0; r < maze_height; r++) {
    for (var c = 0; c < maze_width; c++) {
        instance_destroy(instance_place(x + 32 * (c * 2), y + 32 * (r * 2), objBlock));
        
        var current = maze[r, c];
        var size = array_length(current);
        
        for (var i = 0; i < size; i++) {
            if (current[i] == -1) {
                break;
            }
        
            var d = directions[current[i]]; 
            instance_destroy(instance_place(x + 32 * (c * 2) + (32 * d[1]), y + 32 * (r * 2) + (32 * d[0]), objBlock));
        }
    }
}

alarm[0] = 1;