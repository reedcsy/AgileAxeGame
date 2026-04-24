/// @desc Initialize Platform
speed_seconds = 2; // How many seconds to get from A to B
move_timer = 0;
moving_forward = true;

// Define start and end (Relative to initial placement)
start_x = x;
start_y = y;
target_x = x + 128; // Move 128 pixels right (adjust as needed)
target_y = y;

// Convert seconds to frames based on your game speed
duration = speed_seconds * game_get_speed(gamespeed_fps);