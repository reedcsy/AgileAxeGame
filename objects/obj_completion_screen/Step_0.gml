/// @desc Handle Exit & Continuation

// 1. INPUT DETECTION
var _key_proceed = keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter);
var _pad_proceed = false;

// Check all 4 gamepad slots for the A button
for (var i = 0; i < 4; i++) {
    if (gamepad_is_connected(i)) {
        if (gamepad_button_check_pressed(i, gp_face1)) {
            _pad_proceed = true;
            break;
        }
    }
}

// 2. HANDLE CONTINUATION
if (_key_proceed || _pad_proceed) {
    
    // Safety check: ensure we only run this once
    if (!variable_instance_exists(id, "transitioning")) transitioning = false;
    
    if (!transitioning) {
        transitioning = true;
        
        // A. UNFREEZE THE PLAYER 
        // We set them to IDLE so they can move immediately in the next room
        with (obj_player) {
            state = "IDLE";
            hsp = 0;
            vsp = 0;
            image_speed = 1;
            image_alpha = 1;
        }

        // B. DETERMINE DESTINATION
        var _goal = instance_find(obj_goal, 0);
        
        if (_goal != noone) {
            // Check if this was the Final Goal of the game
            if (variable_instance_exists(_goal, "is_final_goal") && _goal.is_final_goal == true) {
                room_goto(rm_completion); 
            } 
            // Otherwise, check for a specific target room assigned in Room Editor
            else if (_goal.target_room != noone) {
                room_goto(_goal.target_room);
            } 
            // Fallback: Just go to the next room in the Asset Browser
            else if (room_exists(room_next(room))) {
                room_goto_next();
            } else {
                room_goto(rm_title);
            }
        } else {
            // Emergency fallback if no goal is found in the room
            if (room_exists(room_next(room))) room_goto_next();
            else room_goto(rm_title);
        }
    }
}