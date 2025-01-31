global.speedModifier += 0.0002;
score += 1 * global.speedModifier;

if (score > global.highScore){
	global.highScore = score;
	ini_open("save_data.ini"); 
	ini_write_real("HighScore", "Value", global.highScore);
	ini_close();
}

layer_hspeed("Clouds", -5 * global.speedModifier);
part_emitter_stream(global.comboPartSys, self.emitter, self.part_type, 1);
part_emitter_region(global.comboPartSys, 0, x - 100, x + 30, y - 100, y - 60, ps_shape_rectangle, ps_distr_linear);

if(keyboard_check(ord("R"))){
	part_system_destroy(global.playerPartSys);
	part_system_destroy(global.comboPartSys);
	room_restart();
}