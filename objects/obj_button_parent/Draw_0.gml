// 1. Always draw the button itself first
draw_self();

// 2. Safety Check: Only proceed if the controller exists AND this button has an index
if (instance_exists(obj_title_controller) && variable_instance_exists(id, "my_index")) {
    
    // 3. Check if this specific button is the one selected
    if (obj_title_controller.menu_index == my_index) {
        
        // --- SELECTION BOX ---
        draw_set_color(c_aqua);
        // Draws an empty rectangle slightly larger than the sprite's collision box
        draw_rectangle(bbox_left - 2, bbox_top - 2, bbox_right + 2, bbox_bottom + 2, true);
        
        // --- SELECTION ARROW ---
        draw_set_halign(fa_right);
        draw_set_valign(fa_middle); // Centers the arrow vertically to the button text
        draw_set_color(c_white);    // Ensure arrow color is visible
        
        // Draw the arrow 10 pixels to the left of the button
        draw_text(bbox_left - 10, y, ">");
        
        // Reset alignment so other draw events don't get messed up
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
    }
}

draw_self();

// If the controller says I'm the one, draw the "I'm selected!" effects
if (instance_exists(obj_title_controller)) {
    if (obj_title_controller.menu_index == my_index) {
        draw_set_color(c_aqua);
        draw_rectangle(bbox_left - 4, bbox_top - 4, bbox_right + 4, bbox_bottom + 4, true);
        
        draw_set_halign(fa_right);
        draw_set_valign(fa_middle);
        draw_text(bbox_left - 10, y, ">");
    }
}