draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(-1); // Uses default font; you can create/set a custom font later

for (var i = 0; i < array_length(menu_options); i++) {
    var _color = c_white;
    var _prefix = "";
    
    // Highlight the selected option
    if (i == index) {
        _color = c_yellow;
        _prefix = "> ";
    }
    
    draw_text_transformed_color(
        room_width / 2, 
        (room_height / 2) + (i * 40), 
        _prefix + menu_options[i], 
        2, 2, 0, // Scale the text up (2x)
        _color, _color, _color, _color, 1
    );
}