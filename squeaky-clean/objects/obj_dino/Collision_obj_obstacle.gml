if (global.gameOver) exit;

if (other.object_index == obj_cake)
{
	global.bday = true;
	with (other)
	{
		instance_destroy();
	}
	audio_play_sound(snd_cake, 100, false);
	
	return;
}

if (other.object_index == obj_inverse)
{
	global.inverse = !global.inverse;
	with (other)
	{
		instance_destroy();
	}
		
	return;
}

// Starting point of the vertical line
start_x = x;      // The given x value
start_y = 0;      // The given y value

// Define an arbitrary large value for the bottom of the line
end_x = start_x;  // Vertical line keeps the same x value
end_y = room_height; // Assuming the line goes all the way to the bottom of the room

// Check for the collision
collision_id = collision_line(start_x, start_y, end_x, end_y, obj_ramp, true, true);
var collision_y = 0; // Initialize the y value for the collision point

// If a collision is found
if (collision_id != noone) {
    // Get the collision point
    
    // Move down until you collide with the object to find the exact y
    while (!position_meeting(start_x, start_y, collision_id)) {
        start_y += 1; // Move down pixel by pixel
    }

    collision_y = start_y; // The exact collision point
    show_debug_message("Collision point: " + string(start_x) + ", " + string(collision_y));	
}

if (other.object_index == obj_ramp)
{
	//if(y < other.y - other.sprite_height*(4/5)){
	if(collision_y > 0){
		while(y > collision_y){ 
			y = y - 40;
		}
	}
	y -= 10;
	rampTimer = coyoteTimeMax;
	return;
}


///stuck terrain failsafe
if place_meeting(x, y, obj_ramp) {
    vspd = 0;
	x -= 5
    y -= 75;
}

///horizontal collision
if place_meeting(x + hspd, y, obj_ramp) {
    while !place_meeting(x + sign(hspd), y, obj_ramp) {
        x += sign(hspd);
    }
    hspd = 0;
}

//vertical collision
if place_meeting(x, y + vspd, obj_ramp) {
    while !place_meeting(x, y + sign(vspd), obj_ramp) {
        y += sign(vspd);
    }
    vspd = 0;
}

if (other.object_index == obj_bubble)
{
	jumping = true;
    vspd = -jspd;
    coyoteTimer = 0; // Prevent multiple jumps within coyote time
	jumpSound = choose(snd_bubble_jump_1, snd_bubble_jump_2);
	audio_play_sound(jumpSound, 100, false);
	global.comboExtensionTimer = comboTimer;
    score += 500 * global.comboMultiplier;
	global.speedModifier += 0.002;
	image_angle = 20;
	sprite_index = global.bday ? spr_squirtle_trick : spr_pika_trick;
	var txt = instance_create_depth(obj_dino.x, obj_dino.y, -10, obj_floating_text);
	bonusJump = 1;
	
	audio_play_sound(snd_pop, 100, false);
	with (other)
	{
		instance_destroy();
	}
	return;
}

var collidedSprite;

if (other.object_index == obj_gastly){
	collidedSprite = sprite_get_height(spr_gastly)
}

if (other.object_index == obj_pidgy){
	collidedSprite = sprite_get_height(spr_pidgey_2)*(3/4)
}

if (y - (sprite_get_height(spr_pika_surf)/2) < other.y - collidedSprite){
    jumping = true;
    vspd = -jspd;
    coyoteTimer = 0; // Prevent multiple jumps within coyote time
	jumpSound = choose(snd_special_jump_1, snd_special_jump_2);
	audio_play_sound(jumpSound, 100, false);
    global.bubbleMeter += 10;
	global.comboMultiplier += 1;
	global.comboExtensionTimer = comboTimer;
    score += 400 * global.comboMultiplier;
	global.speedModifier += 0.002;
	var txt = instance_create_depth(obj_dino.x, obj_dino.y, -10, obj_floating_text);
	bonusJump = 1;
	image_angle = 20;
	sprite_index = global.bday ? spr_squirtle_trick : spr_pika_trick;
	
	with (other)
	{
		instance_destroy();
	}
	return;
}

// otherwise a death object
if (!audio_is_playing(snd_game_over_sc) && !global.gameOver)
	audio_play_sound(snd_game_over_sc, 100, false);
	//audio_play_sound(snd_pika_death, 100, false);
global.gameOver = true;
global.speedModifier = 0;
grav = 0;
	
image_angle = 0;
sprite_index = global.bday ? spr_squirtle_fly : spr_pika_fly;

if (!instance_exists(obj_replay))
	instance_create_layer(room_width/2, room_height/2 + 50, "Instances", obj_replay);
	
with (obj_gastly || obj_pidgy)
{
	speed = 0;	
}