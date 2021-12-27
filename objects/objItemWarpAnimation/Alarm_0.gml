var temp = {x: player2.x, y: player2.y};
player2.x = player1.x;
player2.y = player1.y;
player1.x = temp.x;
player1.y = temp.y;

alarm[1] = game_get_speed(gamespeed_fps) * 1;