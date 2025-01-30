randomize();
var i = instance_create_layer(room_width + 100, room_height/2 + irandom_range(-300, 100), "Clouds", obj_cloud);

if (global.gameOver) exit;

alarm[0] = room_speed * random_range(3/global.speedModifier, 6/global.speedModifier);