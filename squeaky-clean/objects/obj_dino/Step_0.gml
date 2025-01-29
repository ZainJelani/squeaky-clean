if(global.gameOver){
	image_angle = 0;
	if(!global.bday) sprite_index = spr_pika_fly;
	if(global.bday) sprite_index = spr_squirtle_fly;
	y -= 10;	
}

if (global.gameOver) exit;

// Controls
jumpKey = !global.inverse ? keyboard_check_pressed(vk_space) : keyboard_check_pressed(vk_down);
jumpKeyAlt = !global.inverse ? keyboard_check_pressed(vk_up) || keyboard_check(ord("W")) : keyboard_check_pressed(vk_alt);
duckKey = !global.inverse ? keyboard_check(vk_down) || keyboard_check(ord("S")) : keyboard_check(vk_space);
duckKeyAlt = !global.inverse ? keyboard_check(vk_alt) : keyboard_check(vk_up);

fastFallPressed = keyboard_check_pressed(vk_down) || keyboard_check(ord("S"));

forwardKey = !global.inverse ? keyboard_check(vk_right) || keyboard_check(ord("D")) : keyboard_check(vk_left);
backKey = !global.inverse ? keyboard_check(vk_left) || keyboard_check(ord("A")) : keyboard_check(vk_right);

ducking = duckKey || duckKeyAlt;
jumping = !(duckKey && duckKeyAlt);

comboTimer = 3;

// Ground check
var onGround = place_meeting(x, y + 1, obj_block);
var onRamp = place_meeting(x, y + 1, obj_ramp);

if (onGround){
	if global.comboMultiplier > 1 global.comboMultiplier -= 1;	
}

if (onGround || onRamp) {
	if(falling){
		//audio_play_sound(snd_surfing_2, 100, false);
		if(!ducking){
			audio_play_sound(snd_jump_land, 100, false);	
		}
	}
    // Reset coyote time and jump counter when on the ground
    coyoteTimer = coyoteTimeMax;
    jumpCounter = 0; // Reset jump counter
    vspd = 0;
    jumping = false;
    falling = false;
    ducking = duckKey || duckKeyAlt;
	bonusJump = 0;

    // If the player wants to jump
    if ((jumpKey || jumpKeyAlt) && !duckKey && !duckKeyAlt && jumpCounter == 0) {
        if (place_meeting(x, y + 1, obj_ramp)) {
            var _inst = instance_place(x, y, obj_ramp);
            if _inst != noone {
                if (x > _inst.x + sprite_get_width(spr_water_ramp) / 4) {
                    jumpSound = choose(snd_special_jump_1, snd_special_jump_1);
					audio_play_sound(jumpSound, 100, false);
					bonusJump = 1;
					//audio_pause_sound(snd_surfing_2);
                    global.bubbleMeter += 10;
                    //if (global.comboMultiplier < 16) {
                    //    global.comboMultiplier *= 2;
                    //}
					global.comboMultiplier += 1;
					global.comboExtensionTimer = comboTimer;
                    score += 500 * global.comboMultiplier;
                    extendCombo = true;
					global.speedModifier += 0.002;
                }
            }
        } else {
			jumpSound = choose(snd_bubble_jump_1, snd_bubble_jump_2);
            audio_play_sound(jumpSound, 100, false);
			//audio_pause_sound(snd_surfing_2);
        }
        jumping = true;
        vspd = -jspd;
        jumpCounter++; // Increment jump counter
    }
} else {
    // Decrease coyote timer when in the air
    if (coyoteTimer > 0) {
        coyoteTimer--;
    }

    // Allow jumping if coyote timer hasn't expired and jump counter is 0
    if ((jumpKey || jumpKeyAlt) && ((coyoteTimer > 0 && jumpCounter == 0) || bonusJump == 1) && !duckKey && !duckKeyAlt) {
        jumping = true;
        vspd = -jspd;
        jumpCounter++; // Increment jump counter
        coyoteTimer = 0; // Prevent multiple jumps within coyote time
		if(bonusJump == 1){
			bonusJump = 0;
		}
		//if(coyoteTimer > 0 && jumpCounter == 0){
		//	bonusJump = 1;
		//}
		
        jumpSound = choose(snd_bubble_jump_1, snd_bubble_jump_2);
		audio_play_sound(jumpSound, 100, false);
		//audio_pause_sound(snd_surfing_2);
        global.bubbleMeter += 10;
        //global.comboMultiplier += 1;
		//global.comboExtensionTimer = comboTimer;
        //score += 500 * global.comboMultiplier;
        //extendCombo = true;
		//global.speedModifier += 0.003;
    }

    if (fastFallPressed) {
		
		audio_play_sound(snd_drop_attack, 100, false);
        vspd += grav * 6;
    } else {
        if (vspd < termVelocity) {
            vspd += grav;
        }

        if (sign(vspd) == 1) {
            falling = true;
        }
    }
}

falling = jumping && vspd > 0;
jumping = jumping && vspd < 0;

if (place_meeting(x, y + vspd, obj_block) || place_meeting(x, y + vspd, obj_ramp)) {
    while (!place_meeting(x, y + sign(vspd), obj_block) && !place_meeting(x, y + sign(vspd), obj_ramp)) {
        y += sign(vspd);
    }
    vspd = 0;
}

y += vspd;

//if (jumping) {
//    sprite_index = global.bday ? spr_dino_stand_bday : spr_mouse_trick;
//}

if (falling) {
	image_angle = 0;
    sprite_index = global.bday ? spr_squirtle_surf : spr_pika_surf;
}

if (ducking) {
	image_angle = -20;
    sprite_index = global.bday ? spr_squirtle_dive : spr_pika_dive;
    image_speed = 2;
}

if (forwardKey && !backKey && x < room_width) {
    hspd = 20;
	
} else if (!forwardKey && backKey && x > 0) {
    hspd = -40;
	
} else {
    hspd = 0;
}

if (x > room_width)
	{
		x = room_width;
	}
if (x < 0)
	{
		x = 0;
	}
	
	
if place_meeting(x+hspd,y,obj_ramp)
{
    yplus = 0;
    while (place_meeting(x+hspd,y-yplus,obj_ramp) && yplus <= abs(1*hspd)) yplus += 1;
    if place_meeting(x+hspd,y-yplus,obj_ramp)
    {
        while (!place_meeting(x+sign(hspd),y,obj_ramp)) x+=sign(hspd);
        hspd = 0;
    }
    else
    {
        y -= yplus
    }
}
x += hspd;

if (!jumping && !falling && !ducking) {
	image_angle = 0;
    sprite_index = global.bday ? spr_squirtle_surf : spr_pika_surf;
    image_speed = 2;
}