/// @desc Scorecard Control Logic

// 1. VISUAL FADE
// Smoothly dim the background
alpha = lerp(alpha, 0.8, 0.1);

// 2. INPUT & TRANSITION
// Consolidating all inputs into a single check
var _continue = keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(0, gp_start);

if (_continue) {
    // --- DATA CLEANUP ---
    // Reset trackers so Level 2 starts at 0% and 0 deaths
    global.level_deaths   = 0; 
    global.enemies_killed = 0;
    global.chests_found   = 0;
    
    // Unfreeze the game engine
    global.paused = false;

    // --- ROOM TRANSITION ---
    if (room_exists(room_next(room))) {
        room_goto_next();
    } else {
        // If it's the end of the game, head to the title or high scores
        var _target = asset_get_index("rm_title");
        if (_target != -1) {
            room_goto(_target);
        } else {
            game_restart(); // Emergency fallback
        }
    }
    
    // Play a "confirm" sound if you have one for the UI
    var _snd_select = asset_get_index("snd_menu_select");
    if (_snd_select != -1) audio_play_sound(_snd_select, 10, false);
}