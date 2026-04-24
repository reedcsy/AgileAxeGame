/// @desc Level Win Trigger

// 1. Check for collision AND ensure we haven't triggered yet
// We use 'has_triggered_win' as our master gate
if (!has_triggered_win && place_meeting(x, y, obj_player)) {
    
    // 2. Flip the switch immediately so this block can't run again next frame
    has_triggered_win = true;
    triggered = true; // Syncing your legacy variable just in case
    
    show_debug_message("GOAL: Level Win Sequence Triggered.");
    
    // 3. Create the results screen
    // We check if it exists first to be 100% sure we don't double-draw
    if (!instance_exists(obj_completion_screen)) {
        instance_create_depth(x, y, -10000, obj_completion_screen);
    }
    
    // 4. Freeze the Player
    // We use 'with' to ensure the player stops moving and inputting
    with (obj_player) {
        // Stop physics (hsp/vsp should match your player variable names)
        hsp = 0;
        vsp = 0;
        
        // Disable state machine / input
        state = "WIN"; 
        can_move = false; 
        
        // Optional: Make player invincible or semi-transparent
        image_alpha = 0.5;
    }
}