randomize();
var i = instance_create_layer(room_width + 100, room_height/2 + irandom_range(-200, 100), "Clouds", obj_cloud);
i.depth = -100;

if (global.gameOver) exit;

alarm[1] = room_speed * random_range(6/global.speedModifier, 12/global.speedModifier);