/// @desc Hover & Click Logic

// INCREASE THE HITBOX AREA
// Since the text is 4x bigger, the "clickable" zone needs to be bigger too
var _mouse_over = device_mouse_x_to_gui(0) > x - 400 && device_mouse_x_to_gui(0) < x + 400 &&
                  device_mouse_y_to_gui(0) > y - 100 && device_mouse_y_to_gui(0) < y + 100;

if (_mouse_over) {
    target_scale = 1; // A 20% "pop" relative to 4.0
    button_color = c_yellow;
    
    if (mouse_check_button(mb_left)) {
        target_scale = 1; // Shrinks slightly when pressed
        button_color = c_orange;
    }
    
    if (mouse_check_button_released(mb_left)) {
        if (room_exists(target_room)) room_goto(target_room);
    }
} else {
    target_scale = 1; // Return to jumbo base size
    button_color = c_white;
}

hover_scale = lerp(hover_scale, target_scale, 0.2);