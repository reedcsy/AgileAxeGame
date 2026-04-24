// --- INITIALIZE GLOBALS (This runs once at boot) ---
global.paused = false;

// --- THE FUNCTION ---
function scr_get_inputs(_device = 0) {
    var _inputs = {
        up:    keyboard_check(vk_up)    || keyboard_check(ord("W")) || gamepad_button_check(_device, gp_padu) || (gamepad_axis_value(_device, gp_axislv) < -0.5),
        down:  keyboard_check(vk_down)  || keyboard_check(ord("S")) || gamepad_button_check(_device, gp_padd) || (gamepad_axis_value(_device, gp_axislv) > 0.5),
        left:  keyboard_check(vk_left)  || keyboard_check(ord("A")) || gamepad_button_check(_device, gp_padl) || (gamepad_axis_value(_device, gp_axislh) < -0.5),
        right: keyboard_check(vk_right) || keyboard_check(ord("D")) || gamepad_button_check(_device, gp_padr) || (gamepad_axis_value(_device, gp_axislh) > 0.5),
        
        jump:  keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(_device, gp_face1),
        pause: keyboard_check_pressed(vk_escape) || gamepad_button_check_pressed(_device, gp_start),
        select: keyboard_check_pressed(vk_enter) || gamepad_button_check_pressed(_device, gp_face1)
    };
    
    return _inputs;
}

var _in = scr_get_inputs(0);

// --- PAUSE TOGGLE (Start Button) ---
if (_in.pause) {
    global.paused = !global.paused;
    if (global.paused) {
        pause_index = 0; // Reset selection to top when pausing
        instance_deactivate_all(true);
        instance_activate_object(id); 
    } else {
        instance_activate_all();
    }
}

// --- PAUSE NAVIGATION ---
if (global.paused) {
    // 1. Move selection up/down
    if (_in.up)    pause_index -= 1;
    if (_in.down)  pause_index += 1;

    // 2. Wrap index
    var _count = array_length(pause_options);
    if (pause_index < 0) pause_index = _count - 1;
    if (pause_index >= _count) pause_index = 0;

    // 3. Confirm Selection (A button / Enter)
    if (_in.select) {
        switch(pause_index) {
            case 0: // RESUME
                global.paused = false;
                instance_activate_all();
                break;
                
            case 1: // RESTART
                global.paused = false;
                instance_activate_all();
                room_restart();
                break;
                
            case 2: // QUIT
                global.paused = false;
                instance_activate_all();
                room_goto(rm_title);
                break;
        }
    }
}