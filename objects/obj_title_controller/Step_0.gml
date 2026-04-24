/// @desc Title Menu Navigation

// 1. INPUT GATHERING
var _in = scr_get_inputs(0);

// Vertical navigation flags
var _u_press = keyboard_check_pressed(vk_up)    || keyboard_check_pressed(ord("W")) || gamepad_button_check_pressed(0, gp_padu);
var _d_press = keyboard_check_pressed(vk_down)  || keyboard_check_pressed(ord("S")) || gamepad_button_check_pressed(0, gp_padd);

// 2. ANALOG STICK (With Cooldown)
var _v_axis = gamepad_axis_value(0, gp_axislv);
if (abs(_v_axis) > 0.5 && alarm[0] <= 0) {
    if (_v_axis < 0) _u_press = true;
    else             _d_press = true;
    alarm[0] = 12; // Adjusted to 12 for a slightly snappier feel
}

// 3. APPLY NAVIGATION & WRAPPING
var _move = _d_press - _u_press;
if (_move != 0) {
    menu_index += _move;
    
    // Count buttons dynamically
    var _button_count = instance_number(obj_button_parent);
    if (_button_count > 0) {
        if (menu_index < 0) menu_index = _button_count - 1;
        if (menu_index >= _button_count) menu_index = 0;
    }
    
    // Play a menu tick sound here if you have one!
    // if (audio_exists(snd_menu_tick)) audio_play_sound(snd_menu_tick, 5, false);
}

// 4. SELECTION (A Button / Enter)
if (_in.select) {
    var _found_button = false;
    
    // Find the button instance assigned to this index
    with (obj_button_parent) {
        if (variable_instance_exists(id, "my_index") && my_index == other.menu_index) {
            // Trigger the button's release logic
            event_perform(ev_mouse, ev_left_release);
            _found_button = true;
            break; 
        }
    }
    
    if (!_found_button) show_debug_message("Menu Warning: No button found for index " + string(menu_index));
}