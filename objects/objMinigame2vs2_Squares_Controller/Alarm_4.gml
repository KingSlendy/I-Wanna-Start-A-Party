next_seed_inline();
var index = irandom(sprite_get_number(sprMinigame2vs2_Squares_Half1) - 1);
var h1 = instance_create_layer(168, -100, "Actors", objMinigame2vs2_Squares_Halfs);
h1.image_index = index;
h1.image_angle = choose(irandom_range(0, 45), irandom_range(135, 359));
h1.network_id = points_teams[0][0].network_id;
h1.color = info.player_colors[0];
h1.target_y = 160;
var h2 = instance_create_layer(168, 708, "Actors", objMinigame2vs2_Squares_Halfs);
h2.sprite_index = sprMinigame2vs2_Squares_Half2;
h2.image_index = index;
h2.image_angle = choose(irandom_range(0, 45), irandom_range(135, 359));
h2.network_id = points_teams[0][1].network_id;
h2.color = info.player_colors[0];
h2.target_y = 448;
