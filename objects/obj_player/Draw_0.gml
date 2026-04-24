/// @desc Draw Player with Flipping and Effects

// 1. THE MAIN DRAW
// This handles the standard sprite and the left/right flipping
draw_sprite_ext(
    sprite_index, 
    image_index, 
    x, 
    y, 
    image_xscale, 
    image_yscale, 
    image_angle, 
    image_blend, 
    image_alpha
);

// 2. INVINCIBILITY EFFECT
// If the player is hit, we draw a white semi-transparent "flash" over them
if (invincible) {
    var _blink = (current_time % 200 < 100); // Create a fast blinking effect
    if (_blink) {
        draw_sprite_ext(
            sprite_index, 
            image_index, 
            x, 
            y, 
            image_xscale, 
            image_yscale, 
            image_angle, 
            c_white, 
            0.6
        );
    }
}

// 3. DEBUG TEXT (REMOVED)
// The direction numbers (1 / -1) are gone now to keep the screen clean for the beta!