var a = instance_create_layer(400, 576, "Actors", objMinigame1vs3_Avoid_Cherry);
a.image_index = attack;
a.hspeed = irandom_range(-3, 3);
a.vspeed = irandom_range(-13, -7);
a.gravity = 0.2;

alarm[1] = 4;
