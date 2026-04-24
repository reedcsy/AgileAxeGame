draw_set_halign(fa_center);
draw_set_font(-1); // Or fnt_pixel

// Title
draw_set_color(c_aqua);
draw_text_transformed(room_width/2, 100, "HALL OF FAME", 2, 2, 0);

// Display the Record
draw_set_color(c_white);
var _display_time = format_time(best_time_frames);

if (best_time_frames > 0) {
    draw_text(room_width/2, 250, "FASTEST ESCAPE:");
    draw_set_color(c_yellow);
    draw_text_transformed(room_width/2, 300, _display_time, 1.5, 1.5, 0);
} else {
    draw_text(room_width/2, 250, "NO RECORD SET YET...");
}

// Draw a prompt at the bottom
draw_set_color(c_gray);
draw_text(room_width/2, room_height - 50, "PRESS ANY KEY TO RETURN");