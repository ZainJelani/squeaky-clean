if (global.gameOver) exit;
randomize();
// How many obstacles we create
var count = irandom_range(1, 10);

function createRamp(height, xCoord, yCoord, object){
	var i = instance_create_layer(xCoord, yCoord, "Instances", object);
	if (object == obj_ramp){
		i.sprite_index = spr_water_ramp;
	}
	if (object == obj_bubble){
		if(height > 550){
			height = 550;	
		}
	}
	if (object == obj_ramp){
		if(height > 600){
			height = 600;	
		}
	}
	i.y = height;
}

if (count < 5){
	xCoord = room_width + 100;
	yCoord = room_height - 75;
	rand = irandom_range(1,10);
	height = choose(room_height - 50 - rand*20);
	if(!collision_circle(xCoord, yCoord, 75, obj_ramp, false, false)){	
		var randomNumber1 = irandom_range(1, 2)
		if (randomNumber1 == 1){
			createRamp(height, xCoord, yCoord, obj_ramp);
		}
		else{
			createRamp(height, xCoord, yCoord, obj_bubble);
		}
		if (count > 4){
			var randomNumber2 = irandom_range(1, 2)
			if (randomNumber2 == 1){
				createRamp(height - 80, xCoord + 400, yCoord - 80, obj_ramp);
			}
			else {
				createRamp(height - 80, xCoord + 400, yCoord - 80, obj_bubble);
			}
		}
	}
	else{
		createRamp(height, xCoord, yCoord, obj_bubble);
	}
}
else {
	if(count > 8){
		var i = instance_create_layer(room_width + 100, room_height - 75, "Instances", obj_pidgy);
	}
	else{
		var i = instance_create_layer(room_width + 100, room_height - 75, "Instances", obj_gastly);
	}
	
	switch (i.sprite_index)
	{
		//case spr_cactus_small:
		case spr_cactus_large:
			i.image_speed = 0;
		
			if (global.speedModifier > 1.5)
			{
				if (count > 8)
				{
					var j = instance_create_layer(room_width + 100 + sprite_get_width(i.sprite_index), room_height - 75, "Instances", obj_gastly);
					j.sprite_index = choose(spr_cactus_small, spr_cactus_large);
					j.image_speed = 0;
				}
			}
		break;
	
		default:
		i.image_speed = 1;
		// Height that pterodactyls might spawn at
		rand = irandom_range(1,10);
		height = choose(room_height - 50 - rand*20);
		i.y = height;
	}
}
if (global.gameOver) exit;

alarm[0] = room_speed * random_range(0.5/global.speedModifier, 1/global.speedModifier);
