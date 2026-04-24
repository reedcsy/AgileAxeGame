/// @desc Initialize Chest Persistence

// 1. UNIQUE IDENTIFICATION
my_key = "chest_" + string(room) + "_" + string(x) + "_" + string(y);

// 2. THE INDEXING FIX
// Instead of instance_destroy() immediately, we just hide it
// This allows the Game Controller to still 'count' the instance
if (variable_global_exists("dead_enemies") && ds_exists(global.dead_enemies, ds_type_map)) {
    if (ds_map_exists(global.dead_enemies, my_key)) {
        image_alpha = 0;    // Invisible
        is_opened = true;   // Mark as opened
        x = -1000;          // Move it way off-screen so no collisions happen
        alarm[1] = 1;       // Destroy it on the next frame
    } else {
        is_opened = false;
        image_alpha = 1;
    }
}

// 3. REGULAR INITIALIZATION
alarm[0] = 2 * 60;