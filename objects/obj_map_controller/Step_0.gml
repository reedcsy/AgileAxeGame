// 1. Safety Check
if (!variable_instance_exists(id, "max_index")) exit;

// 2. Handle Navigation Input
var _h_move = gamepad_button_check_pressed(0, gp_padr) - gamepad_button_check_pressed(0, gp_padl);

if (_h_move != 0) {
    selected_index += _h_move;
    
    // Wrap around logic
    if (selected_index < 0) selected_index = max_index;
    if (selected_index > max_index) selected_index = 0;
    
    // Play the move sound
    audio_play_sound(snd_menu_move, 10, false);
}

// 3. Confirm Selection
if (gamepad_button_check_pressed(0, gp_face1)) {
    // Look through all buttons to find the one that matches our index
    with (obj_map_button_parent) {
        if (button_index == other.selected_index) {
            audio_play_sound(snd_menu_select, 10, false);
            
            if (room_exists(target_room)) {
                room_goto(target_room);
            }
        }
    }
}

// 4. Handle "Back" Functionality (B Button)
if (gamepad_button_check_pressed(0, gp_face2)) {
    // Play a "back" or "cancel" sound if you have one
    audio_play_sound(snd_menu_move, 10, false); 
    
    // Send the player back to the main menu
    if (room_exists(rm_title)) {
        room_goto(rm_title);
    } else {
        show_debug_message("Error: rm_main_menu does not exist!");
    }
}