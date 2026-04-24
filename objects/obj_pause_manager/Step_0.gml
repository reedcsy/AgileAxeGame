/// @desc Navigable Pause Logic

// 1. TOGGLE PAUSE (Always active)
var _p_key = keyboard_check_pressed(vk_escape) || gamepad_button_check_pressed(0, gp_start);

if (_p_key) {
    pause = !pause;
    if (pause) {
        instance_deactivate_all(true);
        pause_surf = surface_create(surface_get_width(application_surface), surface_get_height(application_surface));
        surface_copy(pause_surf, 0, 0, application_surface);
    } else {
        instance_activate_all();
        if (surface_exists(pause_surf)) surface_free(pause_surf);
    }
}

// 2. NAVIGATION (Only runs when paused)
if (pause) {
    // We use keyboard_check directly to avoid external script dependencies
    var _up    = keyboard_check(vk_up)    || gamepad_button_check(0, gp_padu) || (gamepad_axis_value(0, gp_axislv) < -0.5);
    var _down  = keyboard_check(vk_down)  || gamepad_button_check(0, gp_padd) || (gamepad_axis_value(0, gp_axislv) > 0.5);
    var _confirm = keyboard_check_pressed(vk_enter) || gamepad_button_check_pressed(0, gp_face1);

    // Logic Timer (Must be inside the 'if pause' block)
    if (menu_timer > 0) menu_timer--;

    if (menu_timer <= 0) {
        if (_up) {
            menu_index--;
            if (menu_index < 0) menu_index = menu_count - 1;
            menu_timer = 10; // The delay
            if (audio_exists(snd_menu_move)) audio_play_sound(snd_menu_move, 10, false);
        }
        
        if (_down) {
            menu_index++;
            if (menu_index >= menu_count) menu_index = 0;
            menu_timer = 10;
            if (audio_exists(snd_menu_move)) audio_play_sound(snd_menu_move, 10, false);
        }
    }

// 3. EXECUTION
if (_confirm) {
    switch(menu_index) {
        case 0: // --- RESUME ---
            pause = false;
            instance_activate_all();
            if (surface_exists(pause_surf)) surface_free(pause_surf);
        break;
        
        case 1: // --- RESTART ---
            // 1. Reset the logic state so the menu closes
            pause = false; 
            
            // 2. Wake everyone up so they can be destroyed/recreated by the room
            instance_activate_all(); 
            
            // 3. Memory Cleanup
            if (surface_exists(pause_surf)) surface_free(pause_surf);
            
            // 4. Action
            room_restart();
        break;
        
        case 2: // --- QUIT ---
            pause = false;
            instance_activate_all();
            if (surface_exists(pause_surf)) surface_free(pause_surf);
            
            room_goto(rm_title); 
        break;
    }
}
}