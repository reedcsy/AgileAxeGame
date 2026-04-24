// 1. Determine Target State
if (instance_exists(obj_map_controller)) {
    if (obj_map_controller.selected_index == button_index) {
        // Selected State
        target_scale = 1.2;
        target_color = c_white;
    } else {
        // Unselected State
        target_scale = 1.0;
        target_color = c_dkgray;
    }
}

// 2. Smoothly Interpolate Values (The "Juice")
// We use a slightly faster lerp (0.2) for scale and slower for color
image_xscale = lerp(image_xscale, target_scale, 0.2);
image_yscale = lerp(image_yscale, target_scale, 0.2);
image_blend = merge_color(image_blend, target_color, 0.1);