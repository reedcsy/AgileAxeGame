/// @desc Draw High-Res Button Text

// 1. USE THE NEW FONT
draw_set_font(fnt_main_menu); // This uses your sharp, high-res asset
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_alpha(1.0);

// 2. DRAW SHADOW
draw_set_color(c_black);
// Notice we still use hover_scale, but now 1.0 is "Full Size"
draw_text_transformed(x + 4, y + 4, text, hover_scale, hover_scale, 0);

// 3. DRAW MAIN TEXT
draw_set_color(button_color);
draw_text_transformed(x, y, text, hover_scale, hover_scale, 0);

// 4. CLEANUP
draw_set_color(c_white);