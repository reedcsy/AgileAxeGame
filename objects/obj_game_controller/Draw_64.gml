/// @desc Global HUD & Transitions

// 1. Get GUI Dimensions
var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

// 2. HUD / DEBUG (Always visible unless a fade covers it)
// We check the manager specifically to see if we should draw the HUD
if (!instance_exists(obj_pause_manager) || !obj_pause_manager.pause) {
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
    
    // Using your established time tracking
  //  draw_text(20, 20, "TIME: " + string(total_frames));
    
    // You could also draw your Gem count or HP here!
}

// 3. THE FADE TRANSITION 
// This stays here because it's a "Global" effect that covers the whole screen
if (variable_instance_exists(id, "fade_alpha") && fade_alpha > 0) {
    fade_alpha -= 0.02; 
    draw_set_alpha(fade_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, _gw, _gh, false);
    draw_set_alpha(1);
}

// 4. FINAL RESET
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);