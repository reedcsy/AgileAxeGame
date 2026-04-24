/// @desc Collision with obj_chest_parent

// Only trigger if we aren't already locked (prevents re-triggering)
if (input_lock_timer <= 0) {
    input_lock_timer = 60; // 2 seconds at 60fps
    
    // Stop the player in their tracks
    hsp = 0;
    vsp = 0;
    
    // Optional: Play a "discovery" sound
    if (audio_exists(snd_big_bonus)) {
        audio_play_sound(snd_big_bonus, 10, false);
    }
    
    show_debug_message("CHEST: Inputs locked for 2 seconds.");
}