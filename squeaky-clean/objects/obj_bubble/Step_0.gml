event_inherited();
if (global.gameOver) exit;

speed = -20 * global.speedModifier;

// Sine wave movement with phase offset
var amplitude = 2; // Adjust for how far up/down it moves
var frequency = 0.05; // Adjust for speed of oscillation

// Calculate new y position
var new_y = y + amplitude * sin(degtorad(current_time * frequency + phase_offset));

// Set a max y limit (e.g., y can't go below 100)
var max_y = 600;  // Change this to your desired max height
y = min(new_y, max_y); // Prevent y from exceeding max_y

if (x < -100)
{
    instance_destroy();
}
