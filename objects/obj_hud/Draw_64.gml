/// @desc Consolidated HUD Logic

// --- 1. ROOM GATEKEEPER ---
// Only run the drawing logic if we are NOT in the splash, title, or options rooms
if (room == rm_splash || room == rm_options || room == rm_title) {
    exit; 
}

// --- 2. INITIAL SETUP ---
draw_set_font(-1); 
draw_set_valign(fa_top);

// Helper function for shadow text
var draw_text_shadow_ext = function(_x, _y, _text, _color, _scale) {
    draw_set_color(c_black);
    draw_text_transformed(_x + 2, _y + 2, _text, _scale, _scale, 0);
    draw_set_color(_color);
    draw_text_transformed(_x, _y, _text, _scale, _scale, 0);
}

// --- 3. DRAW PLAYER HEALTH (Top Left) ---
var _margin_x = 20;
var _current_y = 20;

if (instance_exists(obj_player)) {
    var _h_spacing = 40;
    if (sprite_exists(spr_heart)) {
        for (var i = 0; i < obj_player.hp_max; i++) {
            var _xx = _margin_x + (i * _h_spacing);
            // Draw empty heart "shell"
            draw_sprite_ext(spr_heart, 0, _xx, _current_y, 1, 1, 0, c_black, 0.5);
            // Draw full heart
            if (i < obj_player.hp) draw_sprite(spr_heart, 0, _xx, _current_y);
        }
    }
}

// --- 4. DRAW SCORE (Below Hearts) ---
_current_y += 45; 
draw_set_halign(fa_left);

// Padding score (e.g., 000500)
var _score_padded = string_replace_all(string_format(global.player_score, 6, 0), " ", "0");
draw_text_shadow_ext(_margin_x, _current_y, "SCORE: " + _score_padded, c_yellow, 1.0);

// --- 5. DRAW GEMS (Below Score) ---
_current_y += 35; 
if (sprite_exists(spr_gem_basic)) {
    draw_sprite_ext(spr_gem_basic, 0, _margin_x, _current_y + 10, 0.8, 0.8, 0, c_white, 1);
    draw_text_shadow_ext(_margin_x + 30, _current_y, "x " + string(global.gems_collected), c_aqua, 1.0);
}

// --- 6. DRAW TIMERS (Top Right) ---
if (instance_exists(obj_game_controller)) {
    draw_set_halign(fa_right);
    var _tx = display_get_gui_width() - 20;
    var _ty = 20;
    var _t_scale = 0.75; 

    var _r_str = "ROOM: " + scr_format_time(obj_game_controller.room_frames);
    var _t_str = "TOTAL: " + scr_format_time(obj_game_controller.total_frames);

    draw_text_shadow_ext(_tx, _ty, _r_str, c_white, _t_scale);
    draw_text_shadow_ext(_tx, _ty + (20 * _t_scale), _t_str, c_aqua, _t_scale);
}

// --- 7. CLEANUP ---
draw_set_halign(fa_left);
draw_set_color(c_white);