if (global.gameOver){
	speed = 0;
	exit;
}

speed = -20 * global.speedModifier;

if (x < -100)
{
	instance_destroy();
}