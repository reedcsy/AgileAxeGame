/// @desc Draw Logo with Glow Effect

var _cx = room_width / 2;
var _cy = room_height / 2;

// Verify sprite exists to prevent crashes
if (sprite_exists(spr_splash_screen)) {
    
    // A. DRAW THE GLOW (Orange Bloom)
    // We draw it slightly larger (1.08) and at a lower alpha (30%)
    // This creates a "pulsing" heat look behind the logo
    var _glow_alpha = image_alpha * 3;
    draw_sprite_ext(spr_splash_screen, 0, _cx, _cy, 1.00, 1.00, 0, c_blue, _glow_alpha);
    
    // B. DRAW THE MAIN LOGO
    draw_sprite_ext(spr_splash_screen, 0, _cx, _cy, 1, 1, 0, c_white, image_alpha);

} else {
    // Fallback if asset name is wrong
    draw_set_color(c_white);
    draw_rectangle(_cx - 50, _cy - 50, _cx + 50, _cy + 50, false);
}