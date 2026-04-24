image_speed = 0; // Prevent the button from cycling through frames
hover_scale = 1.0;
target_scale = 1.0;

selected_index = 0; // The index we are currently highlighting
max_index = 2;      // Set this to your highest button_index (e.g., 4 for 5 missions)
input_delay = 10;    // To prevent the selection from flying too fast

// Assign the sprite chosen in the room editor to this instance
sprite_index = target_sprite;