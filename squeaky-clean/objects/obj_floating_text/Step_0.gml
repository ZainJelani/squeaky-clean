lifetime -= 1;
if (lifetime <= 0) {
    instance_destroy(); // Remove when time runs out
}
x_offset -= 0.5; // Moves the text up slowly
y_offset -= 0.5; // Moves the text up slowly
x = x + x_offset
y = y + y_offset
image_alpha = lifetime / room_speed; // Gradually fades out
