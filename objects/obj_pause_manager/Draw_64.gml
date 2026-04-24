/// @desc Draw Pause Overlay with Wiggle

if (pause) {
    // 1. SETUP DIMENSIONS (The missing piece!)
    var _gw = display_get_gui_width();
    var _gh = display_get_gui_height();
    var _cx = _gw / 2;
    var _cy = _gh / 2;

    // 2. DRAW FROZEN BACKGROUND
    if (surface_exists(pause_surf)) {
        draw_surface_stretched(pause_surf, 0, 0, _gw, _gh);
    }

    // 3. DARKEN SCREEN
    draw_set_alpha(0.6);
    draw_set_color(c_black);
    draw_rectangle(0, 0, _gw, _gh, false);
    draw_set_alpha(1.0);

    // 4. DRAW "PAUSED" WITH WIGGLE
    var _wiggle = sin(current_time / 200) * 5; // Calculated based on time
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    // We use _gw and _gh here, now that they are defined above!
    draw_text_transformed_color(_cx, (_gh / 3) + _wiggle, "PAUSED", 2, 2, 0, c_orange, c_orange, c_red, c_red, 1);

    // 5. DRAW MENU OPTIONS
    for (var i = 0; i < menu_count; i++) {
        var _col = (menu_index == i) ? c_orange : c_white;
        var _txt = (menu_index == i) ? "> " + menu_options[i] + " <" : menu_options[i];
        var _scale = (menu_index == i) ? 1.2 : 1.0;
        
        draw_text_transformed_color(_cx, _cy + (i * 50), _txt, _scale, _scale, 0, _col, _col, _col, _col, 1);
    }
}