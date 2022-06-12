array_sort(kids, function(a, b) { return b.angle - a.angle ; });

for (var i = 0; i < 4; i++) {
	var kid = kids[i];
	kid.draw();
}

draw_sprite(sprTitleGift, 0, 400, 304);

for (var i = 4; i < 7; i++) {
	var kid = kids[i];
	kid.draw();
}

//draw_sprite_ext(sprTitleGift, 0, 400, 304, 1, 1, 5 * dsin((ang * 1.25 + 360 + 40) % 360), c_white, 1);
//draw_sprite_ext(sprNormalPlayerIdle, 0, , 5, 5, 0, c_white, 1);

