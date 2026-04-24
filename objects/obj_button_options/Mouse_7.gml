/// @desc Left Released Event for Options Button

// 1. Check if the button is intended to be used
// (Assumes you set menu_selection = "OPTIONS" in the Create Event of this button)
if (menu_selection == "OPTIONS") {
    
    show_debug_message("--- OPTIONS BUTTON CLICKED ---");

    // 2. Room Transition
    if (room_exists(rm_options)) {
        show_debug_message("Heading to Options Room.");
        
        // Use a sound effect for the click if you have one
        if (audio_exists(snd_menu_select)) audio_play_sound(snd_menu_select, 10, false);
        
        room_goto(rm_options);
    } else {
        show_debug_message("ERROR: rm_options does not exist in the Asset Browser!");
        
        // Safety fallback to title if room is missing
        if (room != rm_title) room_goto(rm_title);
    }
    
} else {
    // This is a safety check in case the object has the wrong selection tag
    show_debug_message("FAIL: menu_selection is NOT 'OPTIONS'. It is: " + string(menu_selection));
}