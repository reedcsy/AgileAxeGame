activated = false;
image_speed = 0;
image_index = 0;

// Default state
activated = false;
image_speed = 0;
image_index = 0;

// THE RECALL: Check if this specific checkpoint was the last one saved
// We use a small 'distance_check' to see if these coordinates match the global save
if (global.checkpoint_room == room && global.checkpoint_x == x && global.checkpoint_y == y) {
    activated = true;
    image_index = 1; // Stay on the 'Reached' sprite frame
}

// In Create Event
if (global.checkpoint_room == room && global.checkpoint_x == x && global.checkpoint_y == y) {
    sprite_index = spr_checkpoint_active;
} else {
    sprite_index = spr_checkpoint_idle;
}