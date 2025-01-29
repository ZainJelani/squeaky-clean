draw_set_color(make_color_rgb(83, 83, 83));
draw_set_font(fnt_main);
draw_text(room_width - 250, 10, "Score: " + string(score));
draw_text(room_width - 250, 35, "Version 1.07");

draw_set_font(fnt_bubble);
draw_set_color(make_color_rgb(0, 0, 0));
draw_text(room_width/2 - 585, -10, string(round(global.comboMultiplier)) + "x");
draw_text(room_width/2 - 565, -10, string(round(global.comboMultiplier)) + "x");
draw_text(room_width/2 - 575, -20, string(round(global.comboMultiplier)) + "x");
draw_text(room_width/2 - 575, 0, string(round(global.comboMultiplier)) + "x");
// draw_set_color(make_color_rgb(133, 227, 251));

if global.bday draw_set_color(make_color_rgb(163, 254, 194));
else draw_set_color(make_color_rgb(255, 140, 197));

draw_text(room_width/2 - 575, -10, string(round(global.comboMultiplier)) + "x");

if(global.extendCombo){
	draw_set_color(make_color_rgb(83, 83, 83));
	draw_set_font(fnt_bubble);
	draw_text(obj_dino.x, obj_dino.y, "Perfect!");
	global.extendCombo = false;
}

if (global.gameOver){
	draw_sprite(spr_game_over, 0, room_width/2, room_height/2);
}