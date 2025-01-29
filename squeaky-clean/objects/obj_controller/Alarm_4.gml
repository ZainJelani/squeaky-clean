if (global.gameOver) exit;
if(global.comboExtensionTimer > 0){
	global.comboExtensionTimer -= 1;
	if (global.comboExtensionTimer == 0){
		global.comboMultiplier = 1;	
	}
}
alarm[4] = room_speed;