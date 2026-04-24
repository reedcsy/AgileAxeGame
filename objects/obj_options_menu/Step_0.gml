/// @desc Unified Menu Logic (Keyboard, Gamepad, & Mouse)

// --- 1. INPUT DETECTION ---
var _up    = keyboard_check_pressed(vk_up);
var _down  = keyboard_check_pressed(vk_down);
var _left  = keyboard_check(vk_left);
var _right = keyboard_check(vk_right);
var _select = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space);

// Gamepad Integration (Slot 0)
if (gamepad_is_connected(0)) {
    _up     = _up     || gamepad_button_check_pressed(0, gp_padu);
    _down   = _down   || gamepad_button_check_pressed(0, gp_padd);
    _left   = _left   || gamepad_button_check(0, gp_padl);
    _right  = _right  || gamepad_button_check(0, gp_padr);
    _select = _select || gamepad_button_check_pressed(0, gp_face1);

    // Thumbstick Vertical (with "pushed" state to prevent infinite scrolling)
    var _v_axis = gamepad_axis_value(0, gp_axislv);
    if (abs(_v_axis) > 0.5) {
        if (!variable_instance_exists(id, "stick_pushed")) stick_pushed = false;
        if (!stick_pushed) {
            if (_v_axis < 0) _up = true;
            if (_v_axis > 0) _down = true;
            stick_pushed = true; 
        }
    } else {
        stick_pushed = false;
    }
    
    // Thumbstick Horizontal
    var _h_axis = gamepad_axis_value(0, gp_axislh);
    if (_h_axis < -0.5) _left = true;
    if (_h_axis > 0.5)  _right = true;
}

// --- 2. VERTICAL NAVIGATION ---
var _move = _down - _up;
if (_move != 0) {
    index += _move;
    if (index < 0) index = array_length(menu_options) - 1;
    if (index >= array_length(menu_options)) index = 0;
}

// --- 3. MENU FUNCTIONALITY ---
var _h_move = _right - _left;

switch(index) {
    case 0: // FULLSCREEN
        if (_select) {
            fullscreen = !fullscreen;
            window_set_fullscreen(fullscreen);
        }
    break;

   case 1: // MUSIC VOLUME
        if (_h_move != 0) {
            music_vol = clamp(music_vol + (_h_move * 0.5), 0, 100); 
            global.music_volume = music_vol / 100;
            
            // This now controls EVERY sound assigned to the music group at once
            audio_group_set_gain(audiogroup_music, global.music_volume, 0);
        }
    break;

    case 2: // SFX VOLUME
        if (_h_move != 0) {
            sfx_vol = clamp(sfx_vol + (_h_move * 0.5), 0, 100);
            global.sfx_volume = sfx_vol / 100;
            audio_group_set_gain(audiogroup_default, global.sfx_volume, 0);
        }
    break;

    case 3: // CLEAR SCORES
        if (_select) {
            if (file_exists("scores.ini")) {
                file_delete("scores.ini");
                show_debug_message("Scores Wiped!");
            }
        }
    break;

    case 4: // CLOSE / BACK
        if (_select) {
            scr_save_settings();
            room_goto(rm_title);
        }
    break;
}

// --- 4. MOUSE LOGIC ---
if (mouse_check_button_pressed(mb_left)) {
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);
    var _gui_w = display_get_gui_width();
    
    // Clicking the "X" Close Button in corner
    if (point_in_rectangle(_mx, _my, _gui_w - 80, 0, _gui_w, 80)) {
        scr_save_settings();
        room_goto(rm_title);
    }
}