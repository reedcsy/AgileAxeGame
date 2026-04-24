if (instance_exists(target)) {
    // 1. Destination (Center of the screen)
    var _target_x = target.x;
    var _target_y = target.y;

    // 2. Smoothly move toward the target
    x = lerp(x, _target_x, cam_speed);
    y = lerp(y, _target_y, cam_speed);

    // 3. Add Screen Shake (The variables we set in the bridge)
    var _shake_x = random_range(-shake_remain, shake_remain);
    var _shake_y = random_range(-shake_remain, shake_remain);

    // 4. Update the actual View Camera
    var _cam_w = camera_get_view_width(view_camera[0]);
    var _cam_h = camera_get_view_height(view_camera[0]);
    
    // Set the view position (adjusted so target is in the center)
    camera_set_view_pos(view_camera[0], x - (_cam_w / 2) + _shake_x, y - (_cam_h / 2) + _shake_y);

    // 5. Reduce shake
    shake_remain = max(0, shake_remain - (shake_magnitude / 30));
}