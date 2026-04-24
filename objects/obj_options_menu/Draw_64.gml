/// @desc Draw Options UI (Scaled)

var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();
var _cx = _gui_w / 2;

// 1. Draw Title
draw_set_halign(fa_center);
draw_set_font(fnt_large);
draw_set_color(c_yellow);
draw_text(_cx, _gui_h * 0.15, "OPTIONS"); // Positioned at 15% height

// 2. Draw Menu Options
draw_set_font(fnt_medium);
var _start_y = _gui_h * 0.4; // Start menu at 40% height
var _spacing = _gui_h * 0.1; // Space items by 10% height

for (var i = 0; i < array_length(menu_options); i++) {
    var _color = (i == index) ? c_yellow : c_white;
    var _yy = _start_y + (i * _spacing);
    var _text = menu_options[i];
    
    // Append Values
    if (i == 0) _text += ": " + (fullscreen ? "ON" : "OFF");
    if (i == 1) _text += ": " + string(floor(music_vol)) + "%";
    if (i == 2) _text += ": " + string(floor(sfx_vol)) + "%";

    draw_text_color(_cx, _yy, _text, _color, _color, _color, _color, 1);
}

// 3. Draw "X" Close Button (Visual Only)
var _x_size = 40;
var _x_margin = 40;
var _bx = _gui_w - _x_margin;
var _by = _x_margin;

draw_set_color(c_red);
draw_rectangle(_bx - _x_size, _by, _bx, _by + _x_size, false);
draw_set_color(c_white);
draw_text(_bx - (_x_size/2), _by, "X");