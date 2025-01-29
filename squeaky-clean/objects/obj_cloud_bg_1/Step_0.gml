if (global.gameOver){
	speed = 0;
	exit;
}

speed = -0.5 * global.speedModifier;

if (global.gameOver) exit;

if (x + sprite_width < 0)
{
    x += sprite_width * 2;
}
