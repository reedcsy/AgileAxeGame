// 1. SETUP
var _gw = display_get_gui_width();
var _gh = display_get_gui_height();
var _center = _gw / 2;

var _text_scale = 1.0;
var _y_start = 160;     
var _spacing = 40;       

draw_set_valign(fa_top);
draw_set_font(-1); 

// 2. HEADER
draw_set_halign(fa_center);
draw_set_color(c_aqua);
draw_text_transformed(_center, 50, "HALL OF FAME", 2, 2, 0);

// 3. COLUMN X-POSITIONS (Reordered: Rank -> Points -> Time -> Gems)
var _cX_rank  = _center - 320;
var _cX_score = _center - 150; // Points now comes first
var _cX_time  = _center + 80;  
var _cX_gems  = _center + 280; // Gems last

// Draw Labels
draw_set_color(c_gray);
draw_set_halign(fa_center);
draw_text(_cX_score, _y_start - 50, "SCORE");
draw_text(_cX_time,  _y_start - 50, "TIME");
draw_text(_cX_gems,  _y_start - 50, "GEMS");

// 4. THE LOOP
ini_open("scores.ini");
for (var i = 0; i < 10; i++) {
    var _p = ini_read_real("TopTen", "Points" + string(i), 0);
    var _t = ini_read_real("TopTen", "Time" + string(i), 999999);
    var _g = ini_read_real("TopTen", "Gems" + string(i), 0);
    var _yy = _y_start + (i * _spacing);
    
    var _col = c_white;
    if (i == 0) _col = c_yellow;
    if (i == 1) _col = make_color_rgb(170, 170, 170); // Silver
    if (i == 2) _col = make_color_rgb(205, 127, 50);  // Bronze
    draw_set_color(_col);

    // Rank
    draw_set_halign(fa_left);
    draw_text_transformed(_cX_rank, _yy, string(i + 1) + ".", _text_scale, _text_scale, 0);

    // Data
    draw_set_halign(fa_center);
    if (_p > 0) {
        draw_text_transformed(_cX_score, _yy, string(_p), _text_scale, _text_scale, 0);
        draw_text_transformed(_cX_time,  _yy, scr_format_time(_t), _text_scale, _text_scale, 0);
        draw_text_transformed(_cX_gems,  _yy, string(_g), _text_scale, _text_scale, 0);
    } else {
        draw_set_color(c_dkgray);
        draw_text_transformed(_cX_score, _yy, "0", _text_scale, _text_scale, 0);
        draw_text_transformed(_cX_time,  _yy, "--:--.--", _text_scale, _text_scale, 0);
        draw_text_transformed(_cX_gems,  _yy, "0", _text_scale, _text_scale, 0);
    }
}
ini_close();

// 5. FOOTER
draw_set_halign(fa_center);
draw_set_color(c_white);
draw_text(_center, _gh - 60, "PRESS ANY KEY TO RETURN");