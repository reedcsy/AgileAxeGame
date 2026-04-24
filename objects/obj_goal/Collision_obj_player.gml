/// @desc Level Win Trigger

// 1. Only run if we haven't already triggered the win
if (!has_triggered_win) {
    has_triggered_win = true;
    triggered = true; // Syncing legacy variable
    
    show_debug_message("GOAL: Level Win Sequence Triggered.");

    // 2. Stop the player and lock inputs
    // 'other' refers to the obj_player in a collision event
    with (other) {
        hsp = 0;
        vsp = 0;
        can_move = false;
        state = "WIN";
    }

    // 3. Create the results screen
    // REPLACE 'obj_completion_screen' with the EXACT name from your Asset Browser
    var _results_obj = obj_completion_screen; 
    
    if (!instance_exists(_results_obj)) {
        instance_create_depth(0, 0, -10000, _results_obj);
    }
}