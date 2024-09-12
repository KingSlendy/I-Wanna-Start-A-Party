/// @desc
background = sprMinigame2vs2_Springing_MathBackground;
width = sprite_get_width(background);
height = sprite_get_height(background);

image_speed = 0;

math_x = irandom(width);
math_y = irandom(height);
math_index = irandom(1);

cloud_x = irandom(width);
cloud_y = irandom(height);
cloud_index = irandom(1);

orientation = choose(-1, 1);

math_speed = 1 * orientation;
cloud_speed = 0.5 * orientation;