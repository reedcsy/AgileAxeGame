// If the mouse is hovering over us (image_index 1)
if (image_index == 1) {
    // Pulse the colors: Cycle through neon pink, blue, and purple
    var _col = make_color_hsv((get_timer() * 0.001) % 255, 200, 255);
    image_blend = _col;
} else {
    // Return to normal color when not hovered
    image_blend = c_white;
}