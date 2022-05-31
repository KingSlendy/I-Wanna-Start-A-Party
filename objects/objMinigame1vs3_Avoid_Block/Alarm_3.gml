var a = instance_create_layer(0, irandom_range(160 + 16, 608 - 32 - 16), "Actors", objMinigame1vs3_Avoid_Cherry);
a.image_index = attack;
a.hspeed = irandom_range(4, 6);

var b = instance_create_layer(800, irandom_range(160 + 16, 608 - 32 - 16), "Actors", objMinigame1vs3_Avoid_Cherry);
b.image_index = attack;
b.hspeed = irandom_range(4, 6) * -1;

alarm[3] = 8;
