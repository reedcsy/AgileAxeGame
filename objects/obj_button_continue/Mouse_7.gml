/// @desc Left Pressed Event for Continue Button
/// @desc Debugging the Continue Click

show_debug_message("--- CONTINUE BUTTON CLICKED ---");

if (menu_selection == "CONTINUE") {
    show_debug_message("Step 1: Menu selection confirmed.");

    if (file_exists("savedata.ini")) {
        show_debug_message("Step 2: savedata.ini found on disk.");

        if (instance_exists(obj_game_controller)) {
            show_debug_message("Step 3: Controller found. Calling load_game_state...");
            
            obj_game_controller.load_game_state();
            obj_game_controller.timer_active = true;
            
        } else {
            show_debug_message("ERROR: obj_game_controller is MISSING from this room!");
        }
    } else {
        show_debug_message("ERROR: No savedata.ini found. Have you saved yet?");
    }
} else {
    show_debug_message("FAIL: menu_selection is NOT 'CONTINUE'. It is: " + string(menu_selection));
}

// 1. Only proceed if this is the actual selection
if (menu_selection == "CONTINUE") {
    
    // 2. Check if the save file exists first
    if (file_exists("savedata.ini")) {
        
        // 3. Ensure the controller exists to handle the data
        if (instance_exists(obj_game_controller)) {
            
            // RUN THE CONTROLLER'S LOAD LOGIC
            // This now handles: Scores, Gems, Checkpoints, Campaign JSON, 
            // AND the room transition (room_goto).
            obj_game_controller.load_game_state();
            
            // Resume the gameplay timer
            obj_game_controller.timer_active = true;
            
        } else {
            show_debug_message("CRITICAL: obj_game_controller not found!");
            
            // EMERGENCY FALLBACK: If controller is missing, load room manually
            // (Though you should really ensure the controller is persistent!)
            ini_open("savedata.ini");
            var _fallback_room = ini_read_real("Progress", "Room", rm_level1);
            ini_close();
            if (room_exists(_fallback_room)) room_goto(_fallback_room);
        }
        
    } else {
        // Visual/Audio feedback that no save exists
        show_debug_message("No save file found!");
        if (audio_exists(snd_error)) audio_play_sound(snd_error, 10, false);
    }
}
/// @desc Left Pressed Event
if (can_click) {
    show_debug_message("Button clicked and allowed!");
    
    if (instance_exists(obj_game_controller)) {
        obj_game_controller.load_game_state();
        obj_game_controller.timer_active = true;
    }
} else {
    show_debug_message("Click ignored: No save file found.");
}