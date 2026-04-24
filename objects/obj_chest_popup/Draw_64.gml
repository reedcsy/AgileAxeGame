/// @desc Draw GUI Event of obj_chest_popup

var _cx = display_get_gui_width() / 2;
var _cy = display_get_gui_height() / 2;

// 1. Draw Dark Overlay
draw_set_color(c_black);
draw_set_alpha(0.7);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_alpha(1.0);

// 2. Draw Glow (With updated function names)
if (sprite_exists(spr_glow)) {
    var _pulse = 2 + sin(get_timer() * 0.000005) * 0.2; 
    
    gpu_set_blendmode(bm_add); // REPLACED draw_set_blend_mode
    draw_sprite_ext(spr_glow, 0, _cx, _cy, _pulse, _pulse, get_timer() * 0.0001, c_yellow, 0.6);
    gpu_set_blendmode(bm_normal); // REPLACED draw_set_blend_mode
}

// 3. Draw the Chest/Reward
if (sprite_exists(spr_chest_open_large)) {
    draw_sprite(spr_chest_open_large, 0, _cx, _cy);
}

// 4. Draw Text with Drop Shadow
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Shadow
draw_set_color(c_black);
draw_text(_cx + 2, _cy + 102, "TREASURE FOUND!");

// Main Text
draw_set_color(c_white);
draw_text(_cx, _cy + 100, "TREASURE FOUND!");

// Reset alignment
draw_set_halign(fa_left);
draw_set_valign(fa_top);