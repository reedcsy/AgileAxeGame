// No sprite needed, just drawing a tiny block
draw_set_alpha(alpha);
draw_rectangle_color(x, y, x + size, y + size, color, color, color, color, false);
draw_set_alpha(1.0);