/// @desc Draw Completion UI

var _display_w = display_get_gui_width();
var _display_h = display_get_gui_height();
var _cx = _display_w / 2;

// --- 1. THE STATS BLOCK ---
var _stats_y = _display_h * 0.45;
var _line_h = 45;
var _label_x = _cx - 280; 
var _value_x = _cx + 20;  
var _bonus_x = _cx + 60;  

draw_set_font(fnt_medium);

// Enemies Row
draw_set_halign(fa_left);
draw_set_color(c_ltgray);
draw_text(_label_x, _stats_y, "ENEMIES SLAIN:");
draw_set_halign(fa_right);
draw_set_color(c_white);
draw_text(_value_x, _stats_y, string(global.enemies_killed) + " / " + string(global.enemies_total));
if (slayer_bonus > 0) {
    draw_set_halign(fa_left);
    draw_set_color(c_yellow);
    draw_text(_bonus_x, _stats_y, "SLAYER +10000");
}

_stats_y += _line_h;

// Chests Row
draw_set_halign(fa_left);
draw_set_color(c_ltgray);
draw_text(_label_x, _stats_y, "CHESTS FOUND:");
draw_set_halign(fa_right);
draw_set_color(c_white);
draw_text(_value_x, _stats_y, string(global.chests_found) + " / " + string(global.chests_total));
if (explorer_bonus > 0) {
    draw_set_halign(fa_left);
    draw_set_color(c_yellow);
    draw_text(_bonus_x, _stats_y, "EXPLORER +10000");
}

_stats_y += _line_h;

// Deaths Row
draw_set_halign(fa_left);
draw_set_color(c_ltgray);
draw_text(_label_x, _stats_y, "PLAYER DEATHS:");
draw_set_halign(fa_right);
draw_set_color(c_white);
draw_text(_value_x, _stats_y, string(global.level_deaths));
if (survivor_bonus > 0) {
    draw_set_halign(fa_left);
    draw_set_color(c_yellow);
    draw_text(_bonus_x, _stats_y, "FLAWLESS +15000");
}

_stats_y += (_line_h * 2);

// Final Score
draw_set_font(fnt_large);
draw_set_halign(fa_left);
draw_set_color(c_yellow);
draw_text(_label_x, _stats_y, "FINAL SCORE:");
draw_set_halign(fa_right);
draw_text(_value_x, _stats_y, string(final_score_display));