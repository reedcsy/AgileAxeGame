// 1. RESET GLOBAL PLAYER DATA
// This clears any points or gems from a previous session
global.player_score = 0;
global.gems_collected = 0;

// Reset Checkpoints so they don't spawn in the middle of Level 1
global.checkpoint_x = -1;
global.checkpoint_y = -1;

// 2. RESET THE CONTROLLER
if (instance_exists(obj_game_controller)) {
    with (obj_game_controller) {
        total_frames = 0;
        room_frames  = 0;
        timer_active = true; // Start the clock for the new run
        paused       = false;
        
        // Clean up the pause surface if it exists
        if (surface_exists(pause_surf)) {
            surface_free(pause_surf);
            pause_surf = -1;
        }
    }
}

// 3. WIPE THE SAVE FILE (Optional but Recommended)
// This ensures "Continue" doesn't take them back to their old game
if (file_exists("savedata.ini")) {
    file_delete("savedata.ini");
}

// 4. START THE GAME
if (room_exists(rm_worldmap)) {
    room_goto(rm_worldmap);
} else {
    show_debug_message("ERROR: rm_level1 not found in Room list!");
}