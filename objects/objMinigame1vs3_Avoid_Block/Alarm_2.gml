var a = instance_create_layer(768, 576, "Actors", objMinigame1vs3_Avoid_Cherry);
a.image_index = attack;
a.hspeed = choose(2, 4) * -1;
a.vspeed = irandom_range(-10, -7);
a.gravity = 0.2;

var b = instance_create_layer(0, 576, "Actors", objMinigame1vs3_Avoid_Cherry);
b.image_index = attack;
b.hspeed = choose(2, 4);
b.vspeed = irandom_range(-10, -7);
b.gravity = 0.2;

alarm[2] = 10;