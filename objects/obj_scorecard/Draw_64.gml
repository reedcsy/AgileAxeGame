var _gw = display_get_gui_width();
var _gh = display_get_gui_height();
var _cx = _gw / 2;
var _cy = _gh / 2;

// 1. Background
draw_set_alpha(alpha);
draw_set_color(c_black);
draw_rectangle(0, 0, _gw, _gh, false);

// 2. Text Settings
draw_set_alpha(1.0);
draw_set_valign(fa_middle);
draw_set_font(-1);

// Header
draw_set_halign(fa_center);
draw_set_color(c_white);
draw_text_transformed(_cx, _cy - 120, "STAGE CLEAR", 2, 2, 0);

// --- Stats Block ---
draw_set_halign(fa_left);
var _tx_label = _cx - 180;
var _tx_count = _cx + 20;

// Enemies
draw_text(_tx_label, _cy - 30, "ENEMIES SLAIN:");
draw_text(_tx_count, _cy - 30, string(snap_enemies_k) + " / " + string(snap_enemies_t));

// Chests
draw_text(_tx_label, _cy, "CHESTS FOUND:");
draw_text(_tx_count, _cy, string(snap_chests_f) + " / " + string(snap_chests_t));

// Deaths
draw_text(_tx_label, _cy + 30, "PLAYER DEATHS:");
draw_text(_tx_count, _cy + 30, string(snap_deaths));

// Bonus text
if (flawless) {
    draw_set_color(c_yellow);
    draw_text(_cx + 120, _cy + 30, "FLAWLESS +15000");
}

// --- 4. THE BIG SCORE ---
draw_set_color(c_white);
draw_line(_tx_label, _cy + 60, _tx_label + 400, _cy + 60);

draw_set_color(c_yellow);
var _score_padded = string_replace_all(string_format(final_display_score, 6, 0), " ", "0");
draw_text_transformed(_tx_label, _cy + 100, "FINAL SCORE: " + _score_padded, 1.5, 1.5, 0);

// Footer
draw_set_halign(fa_center);
draw_set_color(c_white);
draw_text(_cx, _cy + 180, "- PRESS SPACE TO CONTINUE -");